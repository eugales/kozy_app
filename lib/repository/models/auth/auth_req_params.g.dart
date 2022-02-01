// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_req_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthReqParams _$AuthReqParamsFromJson(Map<String, dynamic> json) =>
    AuthReqParams(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthReqParamsToJson(AuthReqParams instance) =>
    <String, dynamic>{
      'user': instance.user,
      'password': instance.password,
    };
