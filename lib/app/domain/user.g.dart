// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    json['imgUrl'] as String,
    json['personalShoppingCart'] == null
        ? null
        : ShoppingCart.fromJson(
            json['personalShoppingCart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'createdOn': instance.createdOn?.toIso8601String(),
      'imgUrl': instance.imgUrl,
      'personalShoppingCart': instance.personalShoppingCart,
    };
