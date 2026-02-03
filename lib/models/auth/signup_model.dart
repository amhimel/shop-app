import 'dart:convert';
import 'dart:io';

class SignUpModel {
  final String username;
  final String email;
  final String password;
  final String? location;

  // 👇 NEW
  final File? profilePhoto;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
    this.location,
    this.profilePhoto,
  });
}
