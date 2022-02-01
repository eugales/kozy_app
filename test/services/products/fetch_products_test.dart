import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kozy_app/services/products/fetch_products.dart';
import 'package:kozy_app/models/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_products_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group('fetchProducts', () {
    test('returns Products if http call completes successfully', () async {
      final client = MockClient();
      when(client.get(Uri.parse('http://localhost:3000/products'))).thenAnswer(
          (_) async => Response(
                  '[{"id": 1, "name": "Test Product Name 1", "description": "Test Description 1", "price": 100.0, "seller_id": 2}]',
                  200));
      final actual = await fetchProducts(client);
      expect(actual, isA<List<Product>>());
      expect(actual.first, isA<Product>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(Uri.parse('http://localhost:3000/products')))
          .thenAnswer((_) async => Response('', 404));
      final product = fetchProducts(client);
      expect(product, throwsException);
    });
  });
}
