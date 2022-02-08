import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Order {
  final int id;
  @JsonKey(name: 'delivery_address')
  final String deliveryAddress;
  @JsonKey(name: 'buyer_id')
  final int buyerId;

  Order({
    required this.id,
    required this.deliveryAddress,
    required this.buyerId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
