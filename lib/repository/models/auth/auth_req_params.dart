import 'package:json_annotation/json_annotation.dart';
import 'package:kozy_app/repository/models/user.dart';

part 'auth_req_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthReqParams {
  final User user;
  final String password;
  AuthReqParams({
    required this.user,
    required this.password,
  });

  factory AuthReqParams.fromJson(Map<String, dynamic> json) => _$AuthReqParamsFromJson(json);
}
