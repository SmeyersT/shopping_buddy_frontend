import 'package:flutter/material.dart';

class NavHelper {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}
