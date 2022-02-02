import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kozy_app/repository/models/auth/auth_req_params.dart';
import 'package:kozy_app/repository/models/auth/auth_res_result.dart';
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

  Future<AuthResResult> signUp(AuthReqParams reqParams) async {
    final response = await _httpClient.post(getUrl(url: 'auth/sign_up'),
        body: jsonEncode(reqParams.user.toMapForAuth(reqParams.password)),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      final token = response.headers['authorization'];
      if (token == null || token.isEmpty) throw ErrorEmptyAuthorization();
      if (response.body.isEmpty) throw ErrorEmptyResponse();

      return AuthResResult(user: User.fromString(response.body), token: token);
    } else {
      throw ErrorGettingUser('Error getting signed up');
    }
  }

  Future<AuthResResult> signIn(String email, String password) async {
    final url = getUrl(url: 'auth/sign_in');
    final data = jsonEncode({"email": email, "password": password});
    final response = await _httpClient.post(url,
        body: data,
        headers: {
          'content-type': 'application/json; charset=utf-8'
          });
    if (response.statusCode == 201) {
      final token = response.headers['authorization'];
      if (token == null || token.isEmpty) throw ErrorEmptyAuthorization();
      if (response.body.isEmpty) throw ErrorEmptyResponse();

      return AuthResResult(user: User.fromString(response.body), token: token);
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
