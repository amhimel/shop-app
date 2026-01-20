import 'dart:convert';

// Convert JSON string to Model
LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  final String id;
  final String token;

  LoginResponseModel({
    required this.id,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['_id'],
      token: json['token'],
    );
  }

}
