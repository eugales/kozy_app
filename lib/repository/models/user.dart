import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String role;
  final DateTime created_at;
  final bool confirmed;
  User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.role,
    required this.created_at,
    required this.confirmed,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => json.encode(toJson());

  factory User.fromString(String data) => User.fromJson(json.decode(data));

  static Map<String, String> mapForAuth(String email, String password,
          String first_name, String last_name, String role) =>
      <String, String>{
        'email': email,
        'password': password,
        'first_name': first_name,
        'last_name': last_name,
        'role': role,
      };
}
