import 'dart:convert';

import 'package:http/http.dart';

Future deleteProduct(Client client, {id}) async {
  final response =
      await client.delete(Uri.parse('http://localhost:3000/products/$id'));
  if (response.statusCode == 204) {
    return response;
  } else {
    throw Exception('Failed to delete Product');
  }
}
