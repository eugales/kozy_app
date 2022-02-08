import 'dart:async';

import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationStorage {
  final String _accessToken = 'ACCESS_TOKEN';

  Future<bool> setAccessToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    return instance.setString(_accessToken, token);
  }

  Future<String> getAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    final token = instance.getString(_accessToken);
    if (token == null) throw AuthenticationException(message: 'no token found in storage');
    return token;
  }

  Future<bool> removeAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.remove(_accessToken);
  }
}
