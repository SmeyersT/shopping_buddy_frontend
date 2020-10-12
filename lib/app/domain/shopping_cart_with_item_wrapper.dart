import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';

part 'shopping_cart_with_item_wrapper.g.dart';

@JsonSerializable()
class ShoppingCartWithItemWrapper {
  ShoppingCart shoppingCart;
  ShoppingCartItem shoppingCartItem;

  ShoppingCartWithItemWrapper(
      this.shoppingCart,
      this.shoppingCartItem
      );

  factory ShoppingCartWithItemWrapper.fromJson(Map<String, dynamic> json) => _$ShoppingCartWithItemWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartWithItemWrapperToJson(this);
}