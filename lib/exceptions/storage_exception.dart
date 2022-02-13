class StorageException implements Exception {
  final String message;

  StorageException({this.message = 'Unknown error occurred. '});
}
