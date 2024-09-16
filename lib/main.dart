import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms_app/utils/theme/app_theme_data.dart';

import 'core/view/login/login_view.dart';


void main() {

  runApp(const MyApp());
}
bool isDesktop() {
  return (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeData.lightThemeData,
      home: const LoginView(),
    );
  }
}
