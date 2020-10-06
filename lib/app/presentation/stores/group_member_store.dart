
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/data/services/group_member_service.dart';
import 'package:shopping_buddy_frontend/app/domain/group_member.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';

part 'group_member_store.g.dart';

class GroupMemberStore = _GroupMemberStoreBase with _$GroupMemberStore;

abstract class _GroupMemberStoreBase with Store {

  final GroupMemberService _groupMemberService = serviceLocator.get<GroupMemberService>();

  GroupMember createdGroupMember;

  @observable
  ObservableFuture<Response<GroupMember>> _groupMemberFuture;

  Future createNewGroupMember(GroupMember groupMember) async {
    _groupMemberFuture = ObservableFuture(
        _groupMemberService.createNewGroupMember(groupMember)
    );
    Response response = await _groupMemberFuture;
    createdGroupMember = response.body;
  }

  Future deleteGroupMember(int groupMemberId) async {
    _groupMemberFuture = ObservableFuture(
      _groupMemberService.removeGroupMember(groupMemberId)
    );
    Response response = await _groupMemberFuture;
  }

}
