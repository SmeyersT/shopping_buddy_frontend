
import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/app/data/services/user_service.dart';
import 'package:shopping_buddy_frontend/app/domain/user.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';

import '../StoreState.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {

  final UserService _userService = serviceLocator.get<UserService>();
  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();

  @observable
  User currentUser;

  @observable
  ObservableFuture<Response<User>> _userFuture;

  Future getCurrentUser() async {
    _userFuture = ObservableFuture(
      _userService.getCurrentUser(_googleHelper.getJwt())
    );
    Response<User> response = await _userFuture;
    currentUser = response.body;
  }

  @computed
  StoreState get getCurrentUserState {
    if (_userFuture == null || _userFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _userFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

}
