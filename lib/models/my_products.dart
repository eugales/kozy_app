import 'package:flutter/foundation.dart';
import 'package:kozy_app/db/product_database.dart';
import 'package:kozy_app/models/product.dart';

class MyProducts extends ChangeNotifier {
  final productDatabase = ProductDatabase();

  MyProducts() {
    productDatabase.database;
  }

  Future<List<Product>> get items async => await productDatabase.products();

  void refresh() {
    items;
    notifyListeners();
  }

  void add(Product item) {
    productDatabase.insertProduct(item);
    notifyListeners();
  }

  void update(Product item) {
    productDatabase.updateProduct(item);
    notifyListeners();
  }

  void remove(Product item) {
    productDatabase.deleteProduct(item.id);
    notifyListeners();
  }
}
