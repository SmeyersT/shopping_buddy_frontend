import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/data/services/group_service.dart';
import 'package:shopping_buddy_frontend/app/domain/group.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:mobx/mobx.dart';

import '../StoreState.dart';

part 'group_store.g.dart';

class GroupStore = _GroupStoreBase with _$GroupStore;

abstract class _GroupStoreBase with Store {

  final GroupService _groupService = serviceLocator.get<GroupService>();

  @observable
  Group createdGroup;

  @observable
  List<Group> userGroups;

  @observable
  List<Group> searchResultGroups;

  @observable
  ObservableFuture<Response<List<Group>>> _searchResultGroupsFuture;

  @observable
  ObservableFuture<Response<List<Group>>> _userGroupsFuture;

  @observable
  ObservableFuture<Response<Group>> _createGroupFuture;

  Future createNewGroup(Group group) async {
    _createGroupFuture = ObservableFuture(
      _groupService.createNewGroup(group)
    );
    Response<Group> response = await _createGroupFuture;
    createdGroup = response.body;
  }

  Future getUserGroups(User user) async {
    print("Called getUserGroups method.");
    _userGroupsFuture = ObservableFuture(
        _groupService.getGroupsByUser(user)
    );
    Response<List<Group>> response = await _userGroupsFuture;
    userGroups = response.body;
  }

  Future searchGroups(String searchInput) async {
    print("Called searchGroups method. Input: " + searchInput);
    _searchResultGroupsFuture = ObservableFuture(
      _groupService.searchGroups(searchInput)
    );
    Response<List<Group>> response = await _searchResultGroupsFuture;
    searchResultGroups = response.body;
    for (var group in searchResultGroups) {
      print(group.name.toString());
    }
  }

  @computed
  StoreState get getUserGroupsState {
    if (_userGroupsFuture == null || _userGroupsFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _userGroupsFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

}
