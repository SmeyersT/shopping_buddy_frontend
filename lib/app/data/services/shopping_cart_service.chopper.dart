// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ShoppingCartService extends ShoppingCartService {
  _$ShoppingCartService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ShoppingCartService;

  @override
  Future<Response<ShoppingCart>> updateShoppingCart(ShoppingCart shoppingCart) {
    final $url = '/shoppingCart/updateShoppingCart';
    final $body = shoppingCart;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<ShoppingCart, ShoppingCart>($request);
  }
}
