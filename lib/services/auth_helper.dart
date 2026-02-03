import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/auth/signup_model.dart';
import 'package:shop_app/models/auth_response/profile_response_model.dart';
import 'package:shop_app/views/shared/export_files.dart';
import '../models/auth/login_model.dart';
import 'package:shop_app/models/auth_response/login_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthHelper {
  static var client = http.Client();
  final Box _userBox = Hive.box('userBox');

  Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.apiUrl, Config.loginUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    // 🔴 ADD THESE TWO LINES
    print("Login Status: ${response.statusCode}");
    print("Login Body: ${response.body}");

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final loginResponse = loginResponseModelFromJson(response.body);

      await prefs.setString("userToken", loginResponse.token);
      await prefs.setString("userId", loginResponse.id);
      await prefs.setBool("isLoggedIn", true);

      return true;
    }

    return false;
  }

  Future<ProfileRes> getProfileCached() async {
    final cached = _userBox.get('profile');

    if (cached != null) {
      log("👀 SHOWING HIVE PROFILE");

      // 🔄 Refresh in background (DON'T await)
      await getProfile().then((fresh) {
        log("🔄 UPDATING HIVE FROM API");
        _userBox.put('profile', fresh.toJson());
      }).catchError((e) {
        log("⚠️ API refresh failed: $e");
      });

      return ProfileRes.fromJson(Map<String, dynamic>.from(cached));
    }

    // First time only
    log("🌐 FIRST TIME PROFILE FROM API");
    final profile = await getProfile();
    _userBox.put('profile', profile.toJson());

    return profile;
  }


  // ----------------Get Profiles API ONLY ----------------
  Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      throw Exception("User token not found. Please login again.");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, Config.getUserUrl);
    var response = await client.get(url, headers: requestHeaders);

    print('Token: $userToken');
    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception("Failed get the profile: ${response.statusCode}");
    }
  }

  Future<bool> signUp(SignUpModel model) async {
    try {
      var uri = Uri.https(Config.apiUrl, Config.signupUrl);
      var request = http.MultipartRequest('POST', uri);

      // ---------- TEXT FIELDS ----------
      request.fields['username'] = model.username;
      request.fields['email'] = model.email;
      request.fields['password'] = model.password;

      if (model.location != null) {
        request.fields['location'] = model.location!;
      }

      // ---------- IMAGE FILE ----------
      if (model.profilePhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePhoto',
            model.profilePhoto!.path,
          ),
        );
      }

      // ---------- SEND ----------
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log("Signup response: ${response.statusCode}");
      log("Body: ${response.body}");

      return response.statusCode == 201;
    } catch (e) {
      log("Signup error: $e");
      return false;
    }
  }
}
