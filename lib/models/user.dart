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

}
