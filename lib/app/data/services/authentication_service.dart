import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

part 'authentication_service.chopper.dart';

@ChopperApi(baseUrl: '/login')
abstract class AuthenticationService extends ChopperService {
  static AuthenticationService create() {
    final client = ChopperClient(
      client: new IOClient(new HttpClient()),
      baseUrl: BASE_URL,
      services: [
        _$AuthenticationService(),
      ],
    );

    return _$AuthenticationService(client);
  }

  @Post(path: '/authorize')
  Future<Response> postGoogleLogin(
      @Header("Authorization") String idToken
      );

  @Post(path: '/refresh')
  Future<Response> refreshJWT(
      @Header("Authorization") String jwt
      );
}
