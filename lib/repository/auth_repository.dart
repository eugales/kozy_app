import 'package:kozy_app/repository/models/auth/auth_req_params.dart';
import 'package:kozy_app/repository/models/auth/auth_res_result.dart';
import 'package:kozy_app/repository/models/user.dart';
import 'package:kozy_app/repository/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  const AuthRepository({
    required this.service,
  });
  final AuthService service;

  Future<User> signUp(AuthReqParams reqParams) async {
    AuthResResult result = await service.signUp(reqParams);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authorization', result.token);

    return Future<User>.value(result.user);
  }

  Future<User> signIn(String email, String password) async {
    AuthResResult result = await service.signIn(email, password);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authorization', result.token);

    return Future<User>.value(result.user);
  }

  Future<bool> signOut(String token) async {
    bool result = await service.signOut(token);

    if(result) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('authorization');
    }

    return false;
  }
}
