import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/group_role.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';


part 'group_member.g.dart';

@JsonSerializable()
class GroupMember {
  int id;
  GroupRole role;
  User user;
  Group group;

  GroupMember(
      this.id,
      this.role,
      this.user,
      this.group,
      );

  factory GroupMember.fromJson(Map<String, dynamic> json) => _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}
