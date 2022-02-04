import 'package:kozy_app/repository/models/product.dart';
import 'package:kozy_app/repository/services/product_service.dart';
import 'package:kozy_app/utils/session_manager.dart';

class ProductRepository {
  final ProductService _service;

  const ProductRepository({
    required ProductService service,
  }) : _service = service;

  Future<List<Product>> getAllProducts() async {
    String token = await SessionManager().getAuthToken();
    return _service.getAllProducts(token);
  }

  Future<List<Product>> getMyProducts() async {
    String token = await SessionManager().getAuthToken();
    return _service.getMyProducts(token);
  }
}
