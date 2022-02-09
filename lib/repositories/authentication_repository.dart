import 'package:kozy_app/models/models.dart';
import 'package:kozy_app/services/services.dart';
import 'package:kozy_app/storage/authentication_storage.dart';

abstract class AuthenticationRepository {
  Future<User?> getCurrentUser();
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<bool> signOut();
}

class MainAuthenticationRepository extends AuthenticationRepository {
  final AuthenticationService _service = MainAuthenticationService();
  final AuthenticationStorage _storage = AuthenticationStorage();

  @override
  Future<User?> getCurrentUser() async {
    String? accessToken = await _storage.getAccessToken();
    AuthResponse authResponse = await _service.getCurrentUser(accessToken);
    if(authResponse.user == null) await _storage.removeAccessToken();
    return authResponse.user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    AuthResponse authResponse = await _service.signInWithEmailAndPassword(email, password);
    String? accessToken = authResponse.accessToken;
    if (accessToken != null) {
      await _storage.setAccessToken(accessToken);
      return authResponse.user;
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    AuthResponse authResponse = await _service.signUpWithEmailAndPassword(email, password);
    String? accessToken = authResponse.accessToken;
    if (accessToken != null) {
      await _storage.setAccessToken(accessToken);
      return authResponse.user;
    }
  }

  @override
  Future<bool> signOut() async {
    String accessToken = await _storage.getAccessToken();
    await _service.signOut(accessToken);
    return _storage.removeAccessToken();
  }
}
