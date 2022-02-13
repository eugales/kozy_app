import 'package:kozy_app/services/product_service.dart';
import 'package:kozy_app/models/models.dart';
import 'package:kozy_app/storage/authentication_storage.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getMyProducts();
  Future<Product?> createProduct(Map<String, dynamic> newProduct);
  Future<Product?> editProduct(Product product);
  Future<bool> deleteProduct(int productId);
}

class MainProductRepository extends ProductRepository {
  final ProductService _service = MainProductService();
  final AuthenticationStorage _storage = AuthenticationStorage();

  @override
  Future<List<Product>> getAllProducts() async {
    String accessToken = await _storage.getAccessToken();
    return await _service.getAllProducts(accessToken);
  }

  @override
  Future<List<Product>> getMyProducts() async {
    String accessToken = await _storage.getAccessToken();
    return await _service.getMyProducts(accessToken);
  }

  @override
  Future<Product?> createProduct(Map<String, dynamic> newProduct) async {
    String accessToken = await _storage.getAccessToken();
    return await _service.createProduct(newProduct, accessToken);
  }

  @override
  Future<Product?> editProduct(Product product) async {
    String accessToken = await _storage.getAccessToken();
    return _service.editProduct(product, accessToken);
  }

  @override
  Future<bool> deleteProduct(int productId) async {
    String accessToken = await _storage.getAccessToken();
    return _service.deleteProduct(productId, accessToken);
  }
}
