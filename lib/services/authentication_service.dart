import 'dart:convert';

import 'package:kozy_app/exceptions/authentication_exception.dart';
import 'package:kozy_app/models/models.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<AuthResponse> getCurrentUser(String accessToken);
  Future<AuthResponse> signUpWithEmailAndPassword(String email, String password);
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut(String accessToken);
}

class MainAuthenticationService extends AuthenticationService {
  final String authority = 'localhost:3000';
  final Map<String, String> _headers = {
    'content-type': 'application/json',
  };

  Uri _getUri(String path) {
    Uri uri = Uri.http(authority, path);
    return uri;
  }

  @override
  Future<AuthResponse> getCurrentUser(String accessToken) async {
    _headers['authorization'] = accessToken;
    final response = await http.get(_getUri('/auth/validate_token'), headers: _headers);
    switch (response.statusCode) {
      case 200:
      case 401:
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      default:
        throw AuthenticationException(message: response.reasonPhrase ?? 'get current user exception');
    }
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async {
    final body = jsonEncode({'email': email, 'password': password});
    final response = await http.post(_getUri('/auth/sign_in'), headers: _headers, body: body);

    switch (response.statusCode) {
      case 201:
      case 401:
      case 422:
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      default:
        throw AuthenticationException(message: response.reasonPhrase ?? 'sign in exception');
    }
  }

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(String email, String password) async {
    final body = jsonEncode({'email': email, 'password': password});
    final response = await http.post(_getUri('/auth/sign_up'), headers: _headers, body: body);
    switch (response.statusCode) {
      case 201:
      case 401:
      case 422:
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      default:
        throw AuthenticationException(message: response.reasonPhrase ?? 'sign up exception');
    }
  }

  @override
  Future<void> signOut(String accessToken) async {
    _headers['authorization'] = accessToken;
    final response = await http.delete(_getUri('/auth/sign_out'), headers: _headers);
    if (response.statusCode == 204) return;
    throw AuthenticationException(message: response.reasonPhrase ?? 'sign out exception');
  }
}
