import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,  //Background
    primary: Colors.grey.shade100, //Container
    secondary: Colors.grey.shade400, //
    tertiary: Colors.grey.shade500, //Texto textfield search
    onTertiary: Colors.grey.shade300, //Cor de texfield search
    onSecondary: Colors.grey.shade900, //Search icon
    onPrimary: Colors.grey.shade300, //Divider
    onPrimaryFixed: const Color.fromARGB(255, 84, 82, 82), //Datetime String
    onSecondaryFixed: Colors.grey.shade900, //TextField Edit texto
    onTertiaryFixed: Colors.grey.shade700,
    onTertiaryFixedVariant: Colors.grey.shade500
  )

);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 21, 20, 20),
    primary: Colors.grey.shade900,
    secondary: const Color.fromARGB(255, 8, 8, 8),
    tertiary: Colors.grey.shade400,
    onTertiary: Colors.grey.shade900,
    onSecondary: Colors.white,
    onPrimary: const Color.fromARGB(255, 51, 51, 51),
    onPrimaryFixed: const Color.fromARGB(255, 195, 194, 194),
    onSecondaryFixed: Colors.grey.shade100,
    onTertiaryFixed: Colors.grey.shade800,
    onTertiaryFixedVariant: Colors.grey.shade500
  )
);