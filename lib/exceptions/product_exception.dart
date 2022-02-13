class ProductException implements Exception {
  final String message;

  factory ProductException.errors(Map<String, dynamic> data) {
    String message = data.entries.map((m) => m.key + ": " + m.value.toString()).join(' ');
    return ProductException(message: message);
  }
  ProductException({this.message = 'Unknown error occurred. '});
}
