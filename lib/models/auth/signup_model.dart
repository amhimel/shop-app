// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final String id;
  final String username;
  final String email;
  final String location;
  final String token;

  SignUpModel({
    required this.id,
    required this.username,
    required this.email,
    required this.location,
    required this.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
