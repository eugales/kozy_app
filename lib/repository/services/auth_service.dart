import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kozy_app/repository/models/errors/auth_error.dart';
import 'package:kozy_app/repository/models/errors/common.dart';
import 'package:kozy_app/repository/models/user.dart';

class AuthService {
  AuthService({
    http.Client? httpClient,
    this.baseUrl = 'http://localhost:3000',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Uri getUrl({required String url}) {
    return Uri.parse('$baseUrl/$url');
  }

  Future<User> signUp(User user, String password) async {
    final response = await _httpClient.post(getUrl(url: 'auth/sign_up'),
        body: jsonEncode(user.toMapForAuth(password)),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return User.fromString(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingUser('Error getting signed up');
    }
  }

  Future<User> signIn(User user, String password) async {
    final response = await _httpClient.post(getUrl(url: 'auth/sign_in'),
        body: jsonEncode(user.toMapForAuth(password)),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return User.fromString(response.body);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingUser('Error getting signed in');
    }
  }

  Future<bool> signOut(String token) async {
    final response = await _httpClient.delete(getUrl(url: 'auth/sign_out'),
        headers: {'content-type': 'application/json', 'authorization': token});
    if (response.statusCode == 204) {
      return true;
    } else {
      throw ErrorGettingUser('Error getting signed out');
    }
  }
}
