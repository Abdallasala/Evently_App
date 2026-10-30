import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  String currentlangage = 'en';
  ThemeMode current_theme = ThemeMode.light;
  bool isSelected = true;
  int currentNavIndex = 0;
  int selectedCategoryIndex = 0;

  final List<String> _listLanguage = ["English", "عربي"];
  final List<String> _listTheme = ["Light", "Dark"];

  List<String> get listLanguage => _listLanguage;
  List<String> get listTheme => _listTheme;

  void changeNavIndex(int newIndex) {
    if (currentNavIndex == newIndex) return;
    currentNavIndex = newIndex;
    notifyListeners();
  }

  void changeCategoryIndex(int newIndex) {
    if (selectedCategoryIndex == newIndex) return;
    selectedCategoryIndex = newIndex;
    notifyListeners();
  }

  void setCurrentLangage(String newLangage) {
    if (currentlangage == newLangage) return;
    currentlangage = newLangage;
    notifyListeners();
  }

  void setCurrentTheme(ThemeMode newTheme) {
    if (current_theme == newTheme) return;
    current_theme = newTheme;
    notifyListeners();
  }

  void setSelector(bool selected) {
    if (isSelected == selected) return;
    isSelected = selected;
    notifyListeners();
  }

  void toggleSelector() {
    isSelected = !isSelected;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDark()) {
      setCurrentTheme(ThemeMode.light);
    } else {
      setCurrentTheme(ThemeMode.dark);
    }
  }

  void toggleLanguage() {
    if (isEnglish()) {
      setCurrentLangage('ar');
    } else {
      setCurrentLangage('en');
    }
  }

  bool isDark() {
    return current_theme == ThemeMode.dark;
  }

  bool isEnglish() {
    return currentlangage == 'en';
  }
}
