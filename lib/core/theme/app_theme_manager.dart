import 'package:flutter/material.dart';

import 'color_palette.dart';

abstract class AppThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorPalette.white,
    primaryColor: ColorPalette.primaryColor,
    brightness: Brightness.light,
    cardColor: ColorPalette.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryColor,
      ),
      iconTheme: IconThemeData(
        color: ColorPalette.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPalette.primaryColor,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      selectedItemColor: ColorPalette.white,
      unselectedItemColor: ColorPalette.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: ColorPalette.black),
      titleLarge: TextStyle(color: ColorPalette.black),
      titleMedium: TextStyle(color: ColorPalette.black),
      titleSmall: TextStyle(color: ColorPalette.black),
      bodyMedium: TextStyle(color: ColorPalette.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF101127),
    primaryColor: ColorPalette.primaryColor,
    brightness: Brightness.dark,
    cardColor: const Color(0xFF101127),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryColor,
      ),
      iconTheme: IconThemeData(
        color: ColorPalette.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF101127),
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      selectedItemColor: ColorPalette.white,
      unselectedItemColor: ColorPalette.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: ColorPalette.white),
      titleLarge: TextStyle(color: ColorPalette.white),
      titleMedium: TextStyle(color: ColorPalette.white),
      titleSmall: TextStyle(color: ColorPalette.white),
      bodyMedium: TextStyle(color: ColorPalette.white),
    ),
  );
}
