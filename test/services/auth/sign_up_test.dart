import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kozy_app/models/user.dart';
import 'package:kozy_app/services/auth/sign_up.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_up_test.mocks.dart';

@GenerateMocks([Client])
@GenerateMocks([SharedPreferences])
void main() {
  group("signUp", () {
    test("returns User and saves Auth token", () async {
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

      when(prefs.setString('authorization', token))
          .thenAnswer((_) => Future<bool>.value(true));

      when(client.post(Uri.parse('http://localhost:3000/auth/sign_up'),
              headers: <String, String>{
                'content-type': 'application/json; charset=UTF-8',
              },
              encoding: Encoding.getByName('application/json'),
              body: jsonEncode(userData)))
          .thenAnswer((_) async => Response(
                  '{"id": 3,"email": "seller@kozy.kz","first_name": "Test First Name","last_name": "Test Last Name","role": "seller","created_at": "2022-01-30T02:06:04.832Z","confirmed": false}',
                  201,
                  headers: <String, String>{
                    'content-type': 'application/json; charset=UTF-8',
                    'authorization': token
                  }));

      final actual =
          await signUp(client, prefs, userData: jsonEncode(userData));
      expect(actual, isA<User>());
    });
  });
}
