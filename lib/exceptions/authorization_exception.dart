class AuthorizationException implements Exception {
  final String message;

  AuthorizationException({this.message = 'Unknown error occurred. '});
}
