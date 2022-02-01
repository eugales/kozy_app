import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kozy_app/services/auth/sign_out.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_out_test.mocks.dart';

@GenerateMocks([Client])
@GenerateMocks([SharedPreferences])
void main() {
  group('signOut', () {
    test("destroy User session and delete Auth token ", () async {
      final prefs = MockSharedPreferences();
      final client = MockClient();
      const userData = {
        "email": "seller@kozy.kz",
        "password": "Test1234",
        "first_name": "Test First Name",
        "last_name": "Test Last Name",
        "role": "seller"
      };

      var faker = Faker();
      final token = 'Bearer ${faker.jwt.custom(expiresIn: DateTime.now(), payload: Map.from(userData))}';

      when(prefs.getString('authorization')).thenReturn(token);

      when(client.delete(Uri.parse('http://localhost:3000/auth/sign_out'),
              headers: <String, String>{
                'content-type': 'application/json; charset=UTF-8',
                'authorization': token
              },
              encoding: Encoding.getByName('application/json'),
              body: jsonEncode(userData)))
          .thenAnswer((_) async => Response('', 204));

      Response response =
          await signOut(client, prefs, userData: jsonEncode(userData));
      expect(response.statusCode, 204);
    });
  });
}
