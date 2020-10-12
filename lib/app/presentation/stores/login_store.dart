import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_buddy_frontend/app/presentation/stores/user_store.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';


part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final UserStore _userStore = serviceLocator.get<UserStore>();
  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();

  @observable
  bool isSignedIn = true;

  @observable
  bool isSigningIn = false;

  @action
  _setSigningIn(bool value) => isSigningIn = value;

  @action
  _setSignedIn(bool value) => isSignedIn = value;

  void signOut(BuildContext context) {
    _googleHelper.googleSignIn.signOut();
    _userStore.currentUser = null;
    Navigator.pushNamed(context, '/login');
  }

  Future<void> signIn(BuildContext context) async {
    _setSigningIn(true);
    bool isLoggedIn = await _googleHelper.signInWithGoogle();
    if (isLoggedIn) Navigator.pushReplacementNamed(context, '/home');
    _setSigningIn(false);
  }

  Future<void> signInSilently(BuildContext context) async {
    bool alreadySignedIn = await _googleHelper.isSignedIn();
    _setSignedIn(alreadySignedIn);
    if (isSignedIn) {
      await _googleHelper.signInSilently();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

}
