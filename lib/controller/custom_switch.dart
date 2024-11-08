import 'package:flutter/material.dart';
import 'package:note/controller/app_controller.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.black,
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.white,
      value: AppController.instance.isDartTheme, 
      onChanged: (value) {
        AppController.instance.changeTheme();
      }
    );
  }
}