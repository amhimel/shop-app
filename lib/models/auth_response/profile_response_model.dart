import 'dart:convert';

// JSON string → Model
ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

// Model → JSON string
String profileResToJson(ProfileRes data) =>
    json.encode(data.toJson());

class ProfileRes {
  final String id;
  final String username;
  final String email;
  final String location;

  ProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.location,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) {
    return ProfileRes(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'location': location,
    };
  }
}
