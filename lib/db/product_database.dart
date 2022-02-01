import 'package:flutter/widgets.dart';
import 'package:kozy_app/db/sql.dart';
import 'package:kozy_app/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  ProductDatabase() {
    WidgetsFlutterBinding.ensureInitialized();
    database;
  }

  Future<Database> get database async => await init();

  Future<Database> init() async {
    return openDatabase(join(await getDatabasesPath(), 'my_products_database.db'),
        onCreate: (db, version) {
      return db.execute(Sql.createProductTable);
    }, version: 1);
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'my_products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Product> getProductById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'my_products',
      where: 'id = ?',
      whereArgs: [id],
    );

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        price: maps[i]['price'],
        seller_id: maps[i]['seller_id'],
      );
    }).first;
  }

  Future<List<Product>> products() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('my_products');

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        price: maps[i]['price'],
        seller_id: maps[i]['seller_id'],
      );
    });
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;

    await db.update(
      'my_products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;

    await db.delete(
      'my_products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
