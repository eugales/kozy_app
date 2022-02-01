import 'package:http/http.dart';
import 'package:kozy_app/models/product.dart';

Future<Product> fetchProduct(Client client, {id}) async {
  final response =
      await client.get(Uri.parse('http://localhost:3000/products/$id'));
  if (response.statusCode == 200) {
    return Product.fromJson(response.body);
  } else {
    throw Exception('Failed to load Product');
  }
}
