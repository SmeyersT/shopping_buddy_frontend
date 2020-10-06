import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String firstName;
  String lastName;
  String email;
  DateTime createdOn;
  String imgUrl;
  ShoppingCart personalShoppingCart;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdOn,
      this.imgUrl,
      this.personalShoppingCart,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
