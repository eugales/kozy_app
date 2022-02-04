import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String _authTokenKey = "auth_token";

  Future<bool> haveAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey(_authTokenKey);
  }

  Future<void> setAuthToken(String authTokenValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, authTokenValue);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? authTokenValue = pref.getString(_authTokenKey);
    if (authTokenValue == null) {
      throw Exception('No authorization key in prefs');
    }
    return authTokenValue;
  }

  Future<bool> clearAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(_authTokenKey);
  }
}
