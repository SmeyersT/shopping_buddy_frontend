import 'package:json_annotation/json_annotation.dart';

part 'shopping_cart_item.g.dart';

@JsonSerializable()
class ShoppingCartItem {
  int id;
  int amount;
  DateTime addedOn;
  bool isBought;
  bool isRepeating;
  String name;

  ShoppingCartItem(
      this.id,
      this.amount,
      this.addedOn,
      this.isBought,
      this.isRepeating,
      this.name
      );

  factory ShoppingCartItem.fromJson(Map<String, dynamic> json) => _$ShoppingCartItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartItemToJson(this);
}
