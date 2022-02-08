import 'package:json_annotation/json_annotation.dart';
import 'package:kozy_app/models/models.dart';

part 'auth_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  User user;
  String access_token;

  AuthResponse({required this.user, required this.access_token});
  
  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
