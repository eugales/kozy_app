import 'package:kozy_app/repository/models/product.dart';
import 'package:kozy_app/repository/services/product_service.dart';

class ProductRepository {
  const ProductRepository({
    required this.service,
  });
  final ProductService service;


  Future<List<Product>> getAllProducts() async => service.getAllProducts();

  Future<List<Product>> getMyProducts() async => service.getMyProducts();
}
