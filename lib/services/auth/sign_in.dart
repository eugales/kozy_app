import 'dart:convert';

import 'package:kozy_app/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> signIn(Client client, SharedPreferences prefs,
    {userData}) async {
  final response =
      await client.post(Uri.parse('http://localhost:3000/auth/sign_in'),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
          },
          encoding: Encoding.getByName('application/json'),
          body: userData);
  if (response.statusCode == 201) {
    final token = response.headers['authorization'];
    if (token != null) {
      await prefs.setString('authorization', token);
      return User.fromJson(response.body);
    } else {
      throw Exception('Sign in: No auth token received');
    }
  } else {
    throw Exception('Sign in: Failed to create User');
  }
}
