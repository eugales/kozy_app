import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Order {
  final int id;
  final String delivery_address;
  final int buyer_id;

  Order({
    required this.id,
    required this.delivery_address,
    required this.buyer_id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
