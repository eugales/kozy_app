import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kozy_app/services/products/delete_product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_product_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group('deleteProduct', () {
    test('returns Product if http call completes successfully', () async {
      final client = MockClient();
      when(client.delete(Uri.parse('http://localhost:3000/products/1')))
          .thenAnswer((_) async => Response(
              '',
              204));
      final response = await deleteProduct(client, id: 1) as Response;
      expect(response.statusCode, 204);
    });

    test('throws an expeption if the http call completes with an error', () {
      final client = MockClient();
      when(client.delete(Uri.parse('http://localhost:3000/products/1')))
          .thenAnswer((_) async => Response('Not Found', 404));
      expect(deleteProduct(client, id: 1), throwsException);
    });
  });
}
