import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final int seller_id;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.seller_id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
