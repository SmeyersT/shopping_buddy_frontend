// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    (json['groupMembers'] as List)
        ?.map((e) =>
            e == null ? null : GroupMember.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['shoppingCart'] == null
        ? null
        : ShoppingCart.fromJson(json['shoppingCart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'groupMembers': instance.groupMembers,
      'shoppingCart': instance.shoppingCart,
    };
