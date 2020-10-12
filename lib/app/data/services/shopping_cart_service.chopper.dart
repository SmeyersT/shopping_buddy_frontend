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
  Future<Response<ShoppingCart>> updateShoppingCart(
      [String idToken, ShoppingCart shoppingCart]) {
    final $url = '/shoppingCart/updateShoppingCart';
    final $headers = {'Authorization': idToken};
    final $body = shoppingCart;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ShoppingCart, ShoppingCart>($request);
  }

  @override
  Future<Response<ShoppingCart>> addCartItem(
      [String idToken, ShoppingCartWithItemWrapper wrapper]) {
    final $url = '/shoppingCart/addCartItem';
    final $headers = {'Authorization': idToken};
    final $body = wrapper;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ShoppingCart, ShoppingCart>($request);
  }

  @override
  Future<Response<ShoppingCart>> removeCartItem(
      [String idToken, ShoppingCartWithItemWrapper wrapper]) {
    final $url = '/shoppingCart/removeCartItem';
    final $headers = {'Authorization': idToken};
    final $body = wrapper;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ShoppingCart, ShoppingCart>($request);
  }
}
