import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kozy_app/exceptions/exceptions.dart';
import 'package:kozy_app/models/models.dart';

abstract class ProductService {
  Future<List<Product>> getAllProducts(String accessToken);
  Future<List<Product>> getMyProducts(String accessToken);
  Future<Product?> createProduct(Map<String, dynamic> newProduct, String accessToken);
  Future<Product?> editProduct(Product product, String accessToken);
  Future<bool> deleteProduct(int productId, String accessToken);
}

class MainProductService extends ProductService {
  final String authority = 'localhost:3000';
  final Map<String, String> _headers = {
    'accept': '*/*',
    'content-type': 'application/json',
  };

  Uri _getUrl(String path) {
    Uri uri = Uri.http(authority, path);
    return uri;
  }

  @override
  Future<List<Product>> getAllProducts(String accessToken) async {
    _headers['authorization'] = accessToken;
    final url = _getUrl('products');
    final response = await http.get(url, headers: _headers);

    switch (response.statusCode) {
      case 200:
        return List<Product>.from(
          json.decode(response.body).map(
                (data) => Product.fromJson(data),
              ),
        );

      case 401:
        throw AuthorizationException(message: response.reasonPhrase ?? 'authorization exception');
      default:
        return [];
    }
  }

  @override
  Future<List<Product>> getMyProducts(String accessToken) async {
    _headers['authorization'] = accessToken;
    final url = _getUrl('products/my');
    final response = await http.get(url, headers: _headers);

    switch (response.statusCode) {
      case 200:
        return List<Product>.from(
          json.decode(response.body).map(
                (data) => Product.fromJson(data),
              ),
        );

      case 401:
        throw AuthorizationException(message: response.reasonPhrase ?? 'authorization exception');
      default:
        return [];
    }
  }

  @override
  Future<Product> createProduct(Map<String, dynamic> newProduct, String accessToken) async {
    _headers['authorization'] = accessToken;
    final url = _getUrl('products');
    final body = jsonEncode(newProduct);
    final response = await http.post(url, headers: _headers, body: body);

    final data = jsonDecode(response.body);
    switch (response.statusCode) {
      case 201:
        return Product.fromJson(data);
      case 401:
        throw AuthorizationException(message: response.reasonPhrase ?? 'authorization exception');
      case 422:
        throw ProductException.errors(data);
      default:
        throw ProductException(message: 'Unknown product create exception');
    }
  }

  @override
  Future<Product> editProduct(Product product, String accessToken) async {
    _headers['authorization'] = accessToken;
    final url = _getUrl('products/${product.id}');
    final body = jsonEncode(product.toJson());
    final response = await http.put(url, headers: _headers, body: body);

    final data = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return Product.fromJson(data);
      case 401:
        throw AuthorizationException(message: response.reasonPhrase ?? 'authorization exception');
      case 422:
        throw ProductException.errors(data);
      default:
        throw ProductException(message: 'Unknown product edit exception');
    }
  }

  @override
  Future<bool> deleteProduct(int productId, String accessToken) async {
    _headers['authorization'] = accessToken;
    final url = _getUrl('products/$productId');
    final response = await http.delete(url, headers: _headers);

    switch (response.statusCode) {
      case 204:
        return true;
      case 401:
        throw AuthorizationException(message: response.reasonPhrase ?? 'authorization exception');
      case 422:
        throw ProductException(message: response.reasonPhrase ?? 'product delete exception');
      default:
        throw ProductException(message: 'Unknown product delete exception');
    }
  }
}
