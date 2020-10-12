
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/core/utils/converters/json_to_type_converter.dart';
import 'package:shopping_buddy_frontend/core/utils/interceptors/jwt_interceptor.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: '/user')
abstract class UserService extends ChopperService {

  static UserService create() {
    final client = ChopperClient(
      client: new IOClient(new HttpClient()),
      baseUrl: BASE_URL,
      services: [
        _$UserService(),
      ],
      converter: JsonToTypeConverter(
        {User: (jsonData) => User.fromJson(jsonData)}
      ),
      interceptors: [JWTInterceptor()]
      );
    return _$UserService(client);
  }

  @Get(path: '/getCurrentUser')
  Future<Response<User>> getCurrentUser([
    @Header('Authorization') String idToken
  ]);

}
