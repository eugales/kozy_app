class ErrorGettingUser implements Exception {
  ErrorGettingUser(String error);
}

class ErrorAuthorization implements Exception {
  ErrorAuthorization(String error);
}

class ErrorRegistration implements Exception {
  final String message;
  ErrorRegistration({this.message = ''});
}

class ErrorEmptyAuthorization {}
