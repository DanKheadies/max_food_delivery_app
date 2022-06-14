import 'package:flutter/material.dart';

import 'package:max_food_delivery_app/config/app_router.dart';
import 'package:max_food_delivery_app/config/theme.dart';
import 'package:max_food_delivery_app/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: LocationScreen.routeName,
    );
  }
}
