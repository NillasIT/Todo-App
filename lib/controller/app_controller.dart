import 'package:flutter/material.dart';

class AppController extends ChangeNotifier { //ChangeNotifier é como se fosse um setState, usado apenas para codigo e não tela
  static AppController instance = AppController(); //Apenas poder usar esta instancia

  bool isDartTheme = true;
  changeTheme() {
    isDartTheme = !isDartTheme;
    notifyListeners();
  }
}