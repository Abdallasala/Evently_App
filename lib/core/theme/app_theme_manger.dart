import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManger {
  static ThemeData themeDataLight =ThemeData(
    scaffoldBackgroundColor: ColorPalette.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalette.primaryColor,
      centerTitle: true,
    )
  );
}