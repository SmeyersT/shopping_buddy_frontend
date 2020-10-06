// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartItem _$ShoppingCartItemFromJson(Map<String, dynamic> json) {
  return ShoppingCartItem(
    json['id'] as int,
    json['amount'] as int,
    json['addedOn'] == null ? null : DateTime.parse(json['addedOn'] as String),
    json['isBought'] as bool,
    json['isRepeating'] as bool,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ShoppingCartItemToJson(ShoppingCartItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'addedOn': instance.addedOn?.toIso8601String(),
      'isBought': instance.isBought,
      'isRepeating': instance.isRepeating,
      'name': instance.name,
    };
