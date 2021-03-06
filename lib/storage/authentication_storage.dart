import 'dart:async';

import 'package:kozy_app/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationStorage {
  final String _accessToken = 'ACCESS_TOKEN';

  Future<bool> setAccessToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    return instance.setString(_accessToken, token);
  }

  Future<String> getAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    bool isAccessToken = await containsAccessToken();
    if (!isAccessToken) throw StorageException(message: 'No token found');

    final token = instance.getString(_accessToken);
    return token!;
  }

  Future<bool> removeAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.remove(_accessToken);
  }

  Future<bool> containsAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey(_accessToken);
  }
}
