// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
      order_id: json['order_id'] as int,
      product_id: json['product_id'] as int,
    );

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
      'order_id': instance.order_id,
      'product_id': instance.product_id,
    };
