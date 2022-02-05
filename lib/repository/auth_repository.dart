import 'package:kozy_app/repository/models/auth/auth_req_params.dart';
import 'package:kozy_app/repository/models/auth/auth_res_result.dart';
import 'package:kozy_app/repository/models/user.dart';
import 'package:kozy_app/repository/services/auth_service.dart';
import 'package:kozy_app/utils/token_preferences.dart';

class AuthRepository {
  final AuthService _service;
  final TokenPreferences _tokenPreferences = TokenPreferences();

  AuthRepository({
    required AuthService service,
  }) : _service = service;

  Future<User> signUp(AuthReqParams reqParams) async {
    AuthResResult result = await _service.signUp(reqParams);
    _tokenPreferences.setAuthToken(result.token);
    return Future<User>.value(result.user);
  }

  Future<User> signIn(String email, String password) async {
    AuthResResult result = await _service.signIn(email, password);
    _tokenPreferences.setAuthToken(result.token);
    return Future<User>.value(result.user);
  }

  Future<bool> signOut(String token) async {
    final result = await _service.signOut(token);
    if (result) {
      return _tokenPreferences.clearAuthToken();
    }
    return false;
  }

  Future<bool> validateAuthToken() async {
    String token = await _tokenPreferences.getAuthToken();
    return await _service.validateAuthToken(token);
  }
}
