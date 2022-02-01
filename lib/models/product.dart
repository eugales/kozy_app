import 'dart:convert';

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
  

  Product copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? seller_id,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      seller_id: seller_id ?? this.seller_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'seller_id': seller_id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toInt() ?? 0,
      seller_id: map['seller_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, seller_id: $seller_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.seller_id == seller_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      seller_id.hashCode;
  }
}
