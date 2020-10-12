import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart.dart';
import 'package:shopping_buddy_frontend/app/domain/shopping_cart_with_item_wrapper.dart';
import 'package:shopping_buddy_frontend/core/utils/converters/json_to_type_converter.dart';
import 'package:shopping_buddy_frontend/core/utils/interceptors/jwt_interceptor.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

part 'shopping_cart_service.chopper.dart';

@ChopperApi(baseUrl: '/shoppingCart')
abstract class ShoppingCartService extends ChopperService {

  static ShoppingCartService create() {
    final client = ChopperClient(
      client: new IOClient(new HttpClient()),
      baseUrl: BASE_URL,
      services: [
        _$ShoppingCartService(),
      ],
      converter: JsonToTypeConverter(
          {ShoppingCart: (jsonData) => ShoppingCart.fromJson(jsonData)}
      ),
      interceptors: [JWTInterceptor()]
    );
    return _$ShoppingCartService(client);
  }

  @Post(path: '/updateShoppingCart')
  Future<Response<ShoppingCart>> updateShoppingCart([
    @Header('Authorization') String idToken,
    @Body() ShoppingCart shoppingCart]);

  @Post(path: '/addCartItem')
  Future<Response<ShoppingCart>> addCartItem([
    @Header('Authorization') String idToken,
    @Body() ShoppingCartWithItemWrapper wrapper]);

  @Post(path: '/removeCartItem')
  Future<Response<ShoppingCart>> removeCartItem([
    @Header('Authorization') String idToken,
    @Body() ShoppingCartWithItemWrapper wrapper]);

}
