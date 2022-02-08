import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int id;
  final String email;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String role;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final bool confirmed;
  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.role,
    required this.createdAt,
    required this.confirmed,
  });


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}
