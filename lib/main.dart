import 'package:flutter/material.dart';
import 'package:shopping_buddy_frontend/core/di/service_locator.dart';

import 'core/app.dart';

void main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
