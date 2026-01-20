import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/models/auth/signup_model.dart';
import 'package:shop_app/models/auth_response/profile_response_model.dart';
import 'package:shop_app/views/shared/export_files.dart';

class AuthHelper {
  static var client = http.Client();

  Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final SharedPreferences shPrefs = await SharedPreferences.getInstance();
      String userId = loginModelFromJson(response.body).id;
      String userToken = loginModelFromJson(response.body).token;
      await shPrefs.setString("userId", userId);
      await shPrefs.setString("userToken", userToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(SignUpModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
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

  Future<ProfileRes> getProfile() async {
    final SharedPreferences shPrefs = await SharedPreferences.getInstance();
    String? token = shPrefs.getString("userToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': "Bearer $token",
    };
    var url = Uri.http(Config.apiUrl, Config.getUserUrl);
    var response = await client.post(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception("Failed to get profile");
    }
  }
}
