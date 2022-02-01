import 'package:json_annotation/json_annotation.dart';

part 'line_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LineItem {
  final int order_id;
  final int product_id;

  LineItem({
    required this.order_id,
    required this.product_id,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);
}
