// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartItem _$ShoppingCartItemFromJson(Map<String, dynamic> json) {
  return ShoppingCartItem(
    json['id'] as int,
    json['isBought'] as bool,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ShoppingCartItemToJson(ShoppingCartItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isBought': instance.isBought,
      'name': instance.name,
    };
