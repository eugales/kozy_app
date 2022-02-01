import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Response> signOut(Client client, SharedPreferences prefs,
    {required String userData}) async {
  final token = prefs.getString('authorization');
  if (token == null) {
    throw Exception('Sign out: Failed to fetch auth token');
  }

  final response = await client.delete(
      Uri.parse('http://localhost:3000/auth/sign_out'),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
        'authorization': token
      },
      encoding: Encoding.getByName('application/json'),
      body: userData);
  if (response.statusCode == 204) {
    return response;
  } else {
    throw Exception('Failed to destory User session');
  }
}
