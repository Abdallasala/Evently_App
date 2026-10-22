import 'package:bot_toast/bot_toast.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/loading_service.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/app_theme_manager.dart';
import 'package:evently_app_c13_sun_7_pm/l10n/generated/app_localizations.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/setting_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenrateRoute,
      theme: AppThemeManager.lightTheme,
      darkTheme:AppThemeManager.darkTheme,
      themeMode: provider.current_theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentlangage),
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
