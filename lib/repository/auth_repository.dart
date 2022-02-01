import 'package:kozy_app/repository/models/auth/auth_req_params.dart';
import 'package:kozy_app/repository/models/auth/auth_res_result.dart';
import 'package:kozy_app/repository/models/user.dart';
import 'package:kozy_app/repository/services/auth_service.dart';

class AuthRepository {
  const AuthRepository({
    required this.service,
  });
  final AuthService service;

  Future<User> signUp(AuthReqParams reqParams) async {
    AuthResResult result = await service.signUp(reqParams);

    //sharedPreferences set
    result.token;

    return Future<User>.value(result.user);
  }

  Future<User> signIn(AuthReqParams reqParams) async {
    AuthResResult result = await service.signIn(reqParams);

    //sharedPreferences set
    result.token;

    return Future<User>.value(result.user);
  }

  Future<bool> signOut(String token) async {
    bool result = await service.signOut(token);

    if(result) {
      //sharedPreferences remove
    }

    return false;
  }
}
