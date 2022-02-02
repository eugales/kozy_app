import 'package:kozy_app/repository/models/product.dart';
import 'package:kozy_app/repository/services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  const ProductRepository({
    required this.service,
  });
  final ProductService service;

  Future<List<Product>> getAllProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authorization');
    if (token == null) throw Exception('No authorization key in prefs');
    return service.getAllProducts(token);
  }

  Future<List<Product>> getMyProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authorization');
    if (token == null) throw Exception('No authorization key in prefs');
    return service.getMyProducts(token);
  }
}
