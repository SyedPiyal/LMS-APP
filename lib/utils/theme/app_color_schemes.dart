import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor =Color(0xff21254A);
  static const Color secondaryColor = Color(0xFF217EBE);
  static const Color tertiaryColor = Color(0xFF059628);
  static const Color hintColor = Color(0xFF999999);
  static const Color errorColor = Color(0xFFcc3300);
  static const Color successColor = Color(0xFF339900);
  static const Color scaffoldBackgroundColor = CupertinoColors.systemGrey6;
  static const Color darkScaffoldBackgroundColor = Colors.black45;
}

class AppColorSchemes {
  // --------------------------------------
  //  Color scheme
  // --------------------------------------
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: AppColors.errorColor,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    outline: AppColors.hintColor,
    tertiary: AppColors.tertiaryColor,
    onTertiary: Colors.white,
  );


}
