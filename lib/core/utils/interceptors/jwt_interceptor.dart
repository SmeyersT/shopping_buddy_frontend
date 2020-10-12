import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/google_helper.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/jwt_helper.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/nav_helper.dart';


class JWTInterceptor extends RequestInterceptor {
  final GoogleHelper _googleHelper = serviceLocator.get<GoogleHelper>();
  final JWTHelper _jwtHelper = serviceLocator.get<JWTHelper>();
  final NavHelper _navHelper = serviceLocator.get<NavHelper>();

  @override
  FutureOr<Request> onRequest(Request request) async {
    String response = await _jwtHelper.refreshJwtToken(_googleHelper.getJwt());

    if (response != null && response == "expired") {
      _googleHelper.googleSignIn.signOut();
      _navHelper.navigateTo("/login");
    } else if (response != null && response != "expired") {
      _googleHelper.jwt = response;
    }
    return request;
  }
}