import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kozy_app/repository/models/errors/common.dart';
import 'package:kozy_app/repository/models/errors/product_error.dart';
import 'package:kozy_app/repository/models/product.dart';

class ProductService {
  ProductService({
    http.Client? httpClient,
    this.baseUrl = 'http://localhost:3000',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Uri getUrl({required String url}) {
    return Uri.parse('$baseUrl/$url');
  }

  Future<List<Product>> getAllProducts() async {
    final response = await _httpClient.get(
      getUrl(url: 'products'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Product>.from(
          json.decode(response.body).map(
                (data) => Product.fromJson(data),
              ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingProducts('Error getting all products');
    }
  }


  Future<List<Product>> getMyProducts() async {
    final response = await _httpClient.get(
      getUrl(url: 'products/my'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Product>.from(
          json.decode(response.body).map(
                (data) => Product.fromJson(data),
              ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingProducts('Error getting my products');
    }
  }
}
