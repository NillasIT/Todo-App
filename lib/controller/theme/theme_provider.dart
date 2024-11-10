import 'package:flutter/material.dart';
import 'package:note/controller/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  static ThemeProvider instance = ThemeProvider(); //Apenas poder usar esta instancia
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

 bool get isDarkMode => _themeData == darkMode;

  void toogleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}