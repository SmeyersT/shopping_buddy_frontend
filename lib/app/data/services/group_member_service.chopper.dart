// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GroupMemberService extends GroupMemberService {
  _$GroupMemberService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GroupMemberService;

  @override
  Future<Response<GroupMember>> createNewGroupMember(
      [String idToken, GroupMember groupMember]) {
    final $url = '/groupMember/createGroupMember';
    final $headers = {'Authorization': idToken};
    final $body = groupMember;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<GroupMember, GroupMember>($request);
  }

  @override
  Future<Response<GroupMember>> removeGroupMember(
      [String idToken, int groupMemberId]) {
    final $url = '/groupMember/deleteGroupMember';
    final $headers = {'Authorization': idToken};
    final $body = groupMemberId;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<GroupMember, GroupMember>($request);
  }
}
