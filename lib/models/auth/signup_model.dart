import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) =>
    json.encode(data.toJson());

class SignUpModel {
  final String username;
  final String email;
  final String password;
  final String? location;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
    this.location,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      location: json['location'] ?? 'Not set',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'location': location,
    };
  }
}
