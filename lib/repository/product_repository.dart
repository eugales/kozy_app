import 'package:kozy_app/repository/models/product.dart';
import 'package:kozy_app/repository/services/product_service.dart';
import 'package:kozy_app/utils/token_preferences.dart';

class ProductRepository {
  final ProductService _service;
  final TokenPreferences _tokenPreferences = TokenPreferences();

  ProductRepository({
    required ProductService service,
  }) : _service = service;

  Future<List<Product>> getAllProducts() async {
    String token = await _tokenPreferences.getAuthToken();
    return _service.getAllProducts(token);
  }

  Future<List<Product>> getMyProducts() async {
    String token = await _tokenPreferences.getAuthToken();
    return _service.getMyProducts(token);
  }
}
