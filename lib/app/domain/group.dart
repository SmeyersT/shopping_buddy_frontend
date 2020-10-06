import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  int id;
  String name;
  String description;
  List<GroupMember> groupMembers;
  ShoppingCart shoppingCart;

  Group(
      this.id,
      this.name,
      this.description,
      this.groupMembers,
      this.shoppingCart
      );

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
