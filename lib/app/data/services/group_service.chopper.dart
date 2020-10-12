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
  Future<Response<Group>> createNewGroup([String idToken, Group group]) {
    final $url = '/group/createNewGroup';
    final $headers = {'Authorization': idToken};
    final $body = group;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Group, Group>($request);
  }

  @override
  Future<Response<List<Group>>> getGroupsByUser([String idToken]) {
    final $url = '/group/getGroupsByUser';
    final $headers = {'Authorization': idToken};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<Group>, Group>($request);
  }

  @override
  Future<Response<List<Group>>> searchGroups(
      [String idToken, String searchInput]) {
    final $url = '/group/searchGroups';
    final $headers = {'Authorization': idToken};
    final $body = searchInput;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<List<Group>, Group>($request);
  }

  @override
  Future<Response<Group>> deleteGroup([String idToken, Group group]) {
    final $url = '/group/deleteGroup';
    final $headers = {'Authorization': idToken};
    final $body = group;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Group, Group>($request);
  }
}
