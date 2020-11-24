import 'package:json_annotation/json_annotation.dart';

part 'shopping_cart_item.g.dart';

@JsonSerializable()
class ShoppingCartItem {
  int id;
  bool isBought;
  String name;

  ShoppingCartItem(
      this.id,
      this.isBought,
      this.name
      );

  factory ShoppingCartItem.fromJson(Map<String, dynamic> json) => _$ShoppingCartItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartItemToJson(this);
}
