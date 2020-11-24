// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCart _$ShoppingCartFromJson(Map<String, dynamic> json) {
  return ShoppingCart(
    json['id'] as int,
    json['isRepeating'] as bool,
    (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingCartItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['isPersonalCart'] as bool,
  );
}

Map<String, dynamic> _$ShoppingCartToJson(ShoppingCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isRepeating': instance.isRepeating,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'isPersonalCart': instance.isPersonalCart,
    };
