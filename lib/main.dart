import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/utilities/task_manager.dart';

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
        return MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
