import 'dart:convert';
import 'package:http/http.dart';
import 'package:kozy_app/models/product.dart';

Future<List<Product>> fetchProducts(Client client) async {
  final response =
      await client.get(Uri.parse('http://localhost:3000/products'));
  if (response.statusCode == 200) {
    final decodedList = jsonDecode(response.body) as List;
    return List<Product>.from(decodedList.map((p) => Product.fromMap(p)));
  } else {
    throw Exception('Failed to load Products');
  }
}
