import 'dart:io';

import 'package:http/io_client.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/core/utils/converters/json_to_type_converter.dart';
import 'package:shopping_buddy_frontend/core/values/globals.dart';

part 'group_member_service.chopper.dart';

@ChopperApi(baseUrl: '/groupMember')
abstract class GroupMemberService extends ChopperService {

  static GroupMemberService create() {
    final client = ChopperClient(
      client: new IOClient(new HttpClient()),
      baseUrl: BASE_URL,
      services: [
        _$GroupMemberService(),
      ],
      converter: JsonToTypeConverter(
          {GroupMember: (jsonData) => GroupMember.fromJson(jsonData)}
      ),
      //interceptors: [JWTInterceptor()]
    );
    return _$GroupMemberService(client);
  }

  @Post(path: '/createGroupMember')
  Future<Response<GroupMember>> createNewGroupMember(@Body() GroupMember groupMember);

  @Post(path: '/deleteGroupMember')
  Future<Response<GroupMember>> removeGroupMember(@Body() int groupMemberId);

}
