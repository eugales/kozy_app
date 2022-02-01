import 'package:json_annotation/json_annotation.dart';
import 'package:kozy_app/repository/models/user.dart';

part 'auth_res_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResResult {
  final User user;
  final String token;
  AuthResResult({
    required this.user,
    required this.token,
  });

  factory AuthResResult.fromJson(Map<String, dynamic> json) => _$AuthResResultFromJson(json);
}
