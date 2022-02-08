import 'package:kozy_app/models/models.dart';
import 'package:kozy_app/services/services.dart';
import 'package:kozy_app/storage/authentication_storage.dart';

abstract class AuthenticationRepository {
  Future<User> getCurrentUser();
  Future<User> signUpWithUsernameAndPassword(String username, String password);
  Future<User> signInWithUsernameAndPassword(String username, String password);
  Future<bool> signOut(String accessToken);
}

class MainAuthenticationRepository extends AuthenticationRepository {
  final AuthenticationService _service = MainAuthenticationService();
  final AuthenticationStorage _storage = AuthenticationStorage();

  @override
  Future<User> getCurrentUser() async {
    final accessToken = await _storage.getAccessToken();
    return _service.getCurrentUser(accessToken);
  }

  @override
  Future<User> signInWithUsernameAndPassword(String username, String password) async {
    final authResponse = await _service.signInWithUsernameAndPassword(username, password);
    await _storage.setAccessToken(authResponse.access_token);
    return authResponse.user;
  }

  @override
  Future<User> signUpWithUsernameAndPassword(String username, String password) async {
    final authResponse = await _service.signUpWithUsernameAndPassword(username, password);
    await _storage.setAccessToken(authResponse.access_token);
    return authResponse.user;
  }

  @override
  Future<bool> signOut(String accessToken) async {
    await _service.signOut(accessToken);
    return _storage.removeAccessToken();
  }
}
