
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_buddy_frontend/app/data/services/authentication_service.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';

class GoogleHelper {
  final AuthenticationService _authenticationService =
  serviceLocator.get<AuthenticationService>();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',
      'openid',
    ],
  );
  GoogleSignInAccount currentUser;
  GoogleSignInAuthentication authentication;
  String jwt;

  Future<bool> signInSilently() async {
    currentUser = await googleSignIn.signInSilently();
    if (currentUser == null) return false;
    authentication = await currentUser.authentication;
    if (authentication == null) return false;
    Response response =
    await _authenticationService.postGoogleLogin(getBearerToken());
    if (response != null) {
      jwt = response.bodyString;
      debugPrint("User authenticated silently. Received JWT: $jwt");
    }
    return true;
  }

  String getJwt() {
    return 'Bearer $jwt';
  }

  //regular print() cuts idtoken in half
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<bool> signInWithGoogle() async {
    currentUser = await googleSignIn.signIn();
    if (currentUser == null) return false;
    authentication = await currentUser.authentication;
    if (authentication == null) return false;
    Response response =
    await _authenticationService.postGoogleLogin(getBearerToken());
    if (response != null) {
      jwt = response.bodyString;
      debugPrint("User authenticated. Received JWT: $jwt");
    }
    if (response.statusCode == 400) return false;
    return true;
  }

  Future<bool> isSignedIn() async {
    return await googleSignIn.isSignedIn();
  }

  Future<void> signOutWithGoogle() async {
    await googleSignIn.signOut();
  }

  String getBearerToken() {
    if (authentication == null) return null;
    return 'Bearer ${authentication.idToken}';
  }
}
