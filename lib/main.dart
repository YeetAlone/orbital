import 'package:building/screens/login/login.dart';
import 'package:building/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Login(),
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
    themeMode: ThemeMode.system,

    );
  }
}
