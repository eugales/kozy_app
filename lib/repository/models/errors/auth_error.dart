class ErrorGettingUser implements Exception {
  ErrorGettingUser(String error);
}

class ErrorAuthorization implements Exception {
  ErrorAuthorization(String error);
}

class ErrorEmptyAuthorization {}
