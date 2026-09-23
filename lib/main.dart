
import 'package:evently_app_c13_sun_7_pm/core/theme/app_theme_manger.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenrateRoute,
      theme: AppThemeManger.themeDataLight,

      );


  }
}


