import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/core/utils/converters/json_to_type_converter.dart';
import 'package:shopping_buddy_frontend/core/utils/interceptors/jwt_interceptor.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

part 'group_service.chopper.dart';

@ChopperApi(baseUrl: '/group')
abstract class GroupService extends ChopperService {

  static GroupService create() {
    final client = ChopperClient(
      client: new IOClient(new HttpClient()),
      baseUrl: BASE_URL,
      services: [
        _$GroupService(),
      ],
      converter: JsonToTypeConverter(
          {Group: (jsonData) => Group.fromJson(jsonData)}
      ),
      interceptors: [JWTInterceptor()]
    );
    return _$GroupService(client);
  }

  @Post(path: '/createNewGroup')
  Future<Response<Group>> createNewGroup([
    @Header('Authorization') String idToken,
    @Body() Group group
  ]);

  @Get(path: '/getGroupsByUser')
  Future<Response<List<Group>>> getGroupsByUser([
      @Header('Authorization') String idToken
  ]);

  @Get(path: '/searchGroups')
  Future<Response<List<Group>>> searchGroups([
    @Header('Authorization') String idToken,
    @Body() String searchInput]);

  @Post(path: '/deleteGroup')
  Future<Response<Group>> deleteGroup([
    @Header('Authorization') String idToken,
    @Body() Group group
  ]);

}
