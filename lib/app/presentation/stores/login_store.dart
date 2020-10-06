import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';


part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final UserStore _userStore = serviceLocator.get<UserStore>();

  @observable
  bool isSigningIn = false;

  @action
  _setSigningIn(bool value) => isSigningIn = value;

  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();

  void signOut(BuildContext context) {
    _googleHelper.googleSignIn.signOut();
    _userStore.currentUser = null;
    Navigator.pushNamed(context, '/login');
  }

  Future<void> signIn(BuildContext context) async {
    _setSigningIn(true);
    bool isLoggedIn = await _googleHelper.signInWithGoogle();
    if (isLoggedIn) Navigator.pushReplacementNamed(context, '/');
    _setSigningIn(false);
  }

}
