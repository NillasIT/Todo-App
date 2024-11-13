import 'package:flutter/material.dart';
import 'package:note/features/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      activeColor: Colors.black,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: themeProvider.isDarkMode
                        ? WidgetStatePropertyAll(const Color.fromARGB(255, 21, 20, 20))
                        : WidgetStatePropertyAll(Colors.grey),
      
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toogleTheme();
      }
    );
  }
}