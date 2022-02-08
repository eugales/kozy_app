import 'package:json_annotation/json_annotation.dart';
import 'package:kozy_app/models/models.dart';

part 'auth_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  User? user;
  @JsonKey(name: 'access_token')
  String? accessToken;
  List<String>? errors;

  AuthResponse({this.user, this.accessToken, this.errors});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
