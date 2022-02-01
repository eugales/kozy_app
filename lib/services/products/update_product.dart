import 'package:kozy_app/models/product.dart';
import 'package:http/http.dart';

Future<Product> updateProduct(Client client,
    {required int id, required String body}) async {
  final response =
      await client.patch(Uri.parse('http://localhost:3000/products/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
  if (response.statusCode == 200) {
    return Product.fromJson(response.body);
  } else {
    throw Exception('Failed to edit Product');
  }
}
