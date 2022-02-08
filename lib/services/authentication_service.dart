import 'dart:convert';

import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:kozy_app/models/models.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<User> getCurrentUser(String accessToken);
  Future<AuthResponse> signUpWithUsernameAndPassword(String username, String password);
  Future<AuthResponse> signInWithUsernameAndPassword(String username, String password);
  Future<void> signOut(String accessToken);
}

class MainAuthenticationService extends AuthenticationService {
  final String _host = 'http://localhost';
  final int _port = 3000;
  final Map<String, String> _headers = {
    'content-type': 'application/json',
  };

  Uri _getUri(String path) {
    return Uri(host: _host, port: _port, path: path);
  }

  @override
  Future<User> getCurrentUser(String accessToken) async {
    _headers['authorization'] = accessToken;
    final response = await http.get(_getUri('/auth/current_user'), headers: _headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    throw AuthenticationException(message: response.reasonPhrase ?? 'get current user exception');
  }

  @override
  Future<AuthResponse> signInWithUsernameAndPassword(String username, String password) async {
    final response = await http.get(_getUri('/auth/sign_in'), headers: _headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AuthResponse.fromJson(json);
    }
    throw AuthenticationException(message: response.reasonPhrase ?? 'sign in exception');
  }

  @override
  Future<AuthResponse> signUpWithUsernameAndPassword(String username, String password) async {
    final body = jsonEncode({username: username, password: password});
    final response = await http.post(_getUri('/auth/sign_up'), headers: _headers, body: body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return AuthResponse.fromJson(json);
    }
    throw AuthenticationException(message: response.reasonPhrase ?? 'sign up exception');
  }

  @override
  Future<void> signOut(String accessToken) async {
    _headers['authorization'] = accessToken;
    final response = await http.delete(_getUri('/auth/sign_in'), headers: _headers);
    if (response.statusCode == 205) return;
    throw AuthenticationException(message: response.reasonPhrase ?? 'sign out exception');
  }
}
