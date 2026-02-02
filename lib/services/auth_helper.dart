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

    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final loginResponse = loginResponseModelFromJson(response.body);

      if (loginResponse.token == null || loginResponse.token!.isEmpty) {
        throw Exception("Token missing from response");
      }

      await prefs.setString("userToken", loginResponse.token!);

      // ✅ SAVE userId ONLY if not null
      if (loginResponse.id != null) {
        await prefs.setString("userId", loginResponse.id!);
      }

      await prefs.setBool("isLoggedIn", true);
      return true;
    }
    return false;
  }

  // ---------------- PROFILE (CACHE FIRST) ----------------
  Future<ProfileRes> getProfileCached() async {
    // 1 Hive cache check
    final cached = _userBox.get('profile');
    if (cached != null) {
      log("PROFILE FROM HIVE");
      return ProfileRes.fromJson(Map<String, dynamic>.from(cached));
    }

    // 2 API call
    final profile = await getProfile();

    // 3 Save to Hive
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

    var url = Uri.http(Config.apiUrl, Config.getUserUrl);
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
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
