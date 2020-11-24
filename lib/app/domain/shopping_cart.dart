import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';

part 'shopping_cart.g.dart';

@JsonSerializable(explicitToJson: true)
class ShoppingCart {
  int id;
  bool isRepeating;
  List<ShoppingCartItem> items;
  bool isPersonalCart;

  ShoppingCart(
      this.id,
      this.isRepeating,
      this.items,
      this.isPersonalCart,
      );

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => _$ShoppingCartFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartToJson(this);
}

