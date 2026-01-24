import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) =>
    json.encode(data.toJson());

class ProfileRes {
  final String? id;
  final String? username;
  final String? email;
  final String? location;

  ProfileRes({
    this.id,
    this.username,
    this.email,
    this.location,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) {
    return ProfileRes(
      id: json['_id']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      location: json['location']?.toString(),
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
