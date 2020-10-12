// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_with_item_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartWithItemWrapper _$ShoppingCartWithItemWrapperFromJson(
    Map<String, dynamic> json) {
  return ShoppingCartWithItemWrapper(
    json['shoppingCart'] == null
        ? null
        : ShoppingCart.fromJson(json['shoppingCart'] as Map<String, dynamic>),
    json['shoppingCartItem'] == null
        ? null
        : ShoppingCartItem.fromJson(
            json['shoppingCartItem'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShoppingCartWithItemWrapperToJson(
        ShoppingCartWithItemWrapper instance) =>
    <String, dynamic>{
      'shoppingCart': instance.shoppingCart,
      'shoppingCartItem': instance.shoppingCartItem,
    };
