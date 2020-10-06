// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GroupService extends GroupService {
  _$GroupService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GroupService;

  @override
  Future<Response<Group>> createNewGroup(Group group) {
    final $url = '/group/createNewGroup';
    final $body = group;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Group, Group>($request);
  }

  @override
  Future<Response<List<Group>>> getGroupsByUser(User user) {
    final $url = '/group/getGroupsByUser';
    final $body = user;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<List<Group>, Group>($request);
  }

  @override
  Future<Response<List<Group>>> searchGroups(String searchInput) {
    final $url = '/group/searchGroups';
    final $body = searchInput;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<List<Group>, Group>($request);
  }
}
