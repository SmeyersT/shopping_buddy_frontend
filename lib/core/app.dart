
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';
import 'package:shopping_buddy_frontend/core/route_generator.dart';
import 'package:shopping_buddy_frontend/core/utils/helpers/nav_helper.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
    );
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: serviceLocator.get<NavHelper>().navigatorKey,
    );
  }

}
