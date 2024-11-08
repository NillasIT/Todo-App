import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/app_controller.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/controller/task_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 660),
      builder: (context, child) {
        return AnimatedBuilder(
          animation: AppController.instance,
          builder: (context, child) {
            return MaterialApp(
              themeMode: ThemeMode.system,
              home: HomePage(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
