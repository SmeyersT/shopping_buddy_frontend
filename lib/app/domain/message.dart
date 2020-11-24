import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_item.dart';

part 'message.g.dart';

@JsonSerializable()
class WebSocketMessage {
  String sender;
  String content;

  WebSocketMessage(
      this.sender,
      this.content,
      );

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) => _$WebSocketMessageFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketMessageToJson(this);
}
