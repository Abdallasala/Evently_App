
import 'package:bot_toast/bot_toast.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/loading_service.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/app_theme_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(const MyApp());
  configLoading();
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
      builder: EasyLoading.init(
        builder: BotToastInit()
      ),
      );


  }
}


