import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String id;
  final String username;
  final String email;
  final String location;
  final String token;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.location,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    location: json["location"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "location": location,
    "token": token,
  };
}
