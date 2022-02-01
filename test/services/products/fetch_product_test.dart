import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kozy_app/services/products/fetch_product.dart';
import 'package:kozy_app/models/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_product_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group('fetchProduct', () {
    test('returns Product if http call completes successfully', () async {
      final client = MockClient();
      when(client.get(Uri.parse('http://localhost:3000/products/1')))
          .thenAnswer((_) async => Response(
              '{"id": 1, "name": "Test Product Name", "description": "Test Description", "price": 1.0, "seller_id": 2}',
              200));
      final product = await fetchProduct(client, id: 1);
      expect(product, isA<Product>());
    });

    test('throws an expeption if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(Uri.parse('http://localhost:3000/products/1')))
          .thenAnswer((_) async => Response('Not Found', 404));
      expect(fetchProduct(client, id: 1), throwsException);
    });
  });
}
