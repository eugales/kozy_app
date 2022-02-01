import 'package:kozy_app/models/product.dart';
import 'package:http/http.dart';

Future<Product> createProduct(Client client,
    {required String body}) async {
  final response =
      await client.post(Uri.parse('http://localhost:3000/products'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
  if (response.statusCode == 201) {
    return Product.fromJson(response.body);
  } else {
    throw Exception('Failed to create Product');
  }
}
