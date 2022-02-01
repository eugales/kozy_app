import 'package:flutter_test/flutter_test.dart';
import 'package:kozy_app/models/product.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';
import 'package:kozy_app/services/products/update_product.dart';
import 'package:mockito/mockito.dart';

import 'update_product_test.mocks.dart';


@GenerateMocks([Client])
void main() {
  group('updateProduct', () {
    test('returns Product if http call completes successfully', () async {
      final client = MockClient();

      const body =
          '{"product":{"name":"Test Product Name Edited","description":"Test Description Edited"}}';

      when(client.patch(Uri.parse('http://localhost:3000/products/1'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: body))
          .thenAnswer((_) async => Response(
              '{"id": 1, "name":"Test Product Name Edited","description":"Test Description Edited","price":2.0, "seller_id":1}',
              200));
      final actual = await updateProduct(client, id: 1, body: body);
      expect(actual, isA<Product>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      const body =
          '{"product":{"name":"Test Product Name Edited","description":"Test Description Edited"}}';
      when(client.patch(Uri.parse('http://localhost:3000/products/2'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: body))
          .thenAnswer((_) async =>
              Response('{"name":["has already been taken"]}', 422));
      final actual = updateProduct(client, id: 2, body: body);
      expect(actual, throwsException);
    });
  });
}
