import 'package:flutter_test/flutter_test.dart';
import 'package:kozy_app/models/product.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';
import 'package:kozy_app/services/products/create_product.dart';
import 'package:mockito/mockito.dart';

import 'create_product_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group('createProduct', () {
    test('returns Product if http call completes successfully', () async {
      final client = MockClient();

      const body =
          '{"product":{"name":"Test Product Name","description":"Test Description","price":2.0, "seller_id":2}}';

      when(client.post(Uri.parse('http://localhost:3000/products'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: body))
          .thenAnswer((_) async => Response(
              '{"id": 2, "name":"Test Product Name","description":"Test Description","price":2.0, "seller_id":2}',
              201));
      final actual = await createProduct(client, body: body);
      expect(actual, isA<Product>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      const body =
          '{"product":{"name":"Test Product Name","description":"Test Description","price":2.0, "seller_id":2}}';
      when(client.post(Uri.parse('http://localhost:3000/products'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: body))
          .thenAnswer((_) async => Response(
              '{"name":["has already been taken"]}',
              422));
      final actual = createProduct(client, body: body);
      expect(actual, throwsException);
    });
  });
}
