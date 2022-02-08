import 'package:json_annotation/json_annotation.dart';

part 'line_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LineItem {
  @JsonKey(name: 'order_id')
  final int orderId;
  @JsonKey(name: 'product_id')
  final int productId;

  LineItem({
    required this.orderId,
    required this.productId,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);
}
