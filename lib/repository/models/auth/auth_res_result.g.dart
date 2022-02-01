// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_res_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResResult _$AuthResResultFromJson(Map<String, dynamic> json) =>
    AuthResResult(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthResResultToJson(AuthResResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
