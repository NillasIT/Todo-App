import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/features/theme/theme_provider.dart';
import 'package:note/features/controller/task_manager.dart';
import 'package:note/features/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskManager()),
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: Size(360, 660),
      builder: (context, child) {
        return AnimatedBuilder(
          animation: ThemeProvider.instance,
          builder: (context, child) {
            return MaterialApp(
              themeMode: ThemeMode.system,
              home: HomePage(),
              theme: Provider.of<ThemeProvider>(context).themeData,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      });
}
