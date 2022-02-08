// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      deliveryAddress: json['delivery_address'] as String,
      buyerId: json['buyer_id'] as int,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'delivery_address': instance.deliveryAddress,
      'buyer_id': instance.buyerId,
    };
