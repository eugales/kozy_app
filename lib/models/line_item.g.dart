// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
      orderId: json['order_id'] as int,
      productId: json['product_id'] as int,
    );

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'product_id': instance.productId,
    };
