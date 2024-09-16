import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_color_schemes.dart';
import 'app_text_themes.dart';

class AppThemeData {
  // --------------------------------------
  //  Theme Data
  // --------------------------------------
  static final lightThemeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: CupertinoColors.systemGrey6,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      color: AppColorSchemes.lightColorScheme.surface,
      margin: EdgeInsets.zero,
    ),
    colorScheme: AppColorSchemes.lightColorScheme,
    textTheme: AppTextThemes.lightTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      foregroundColor: AppColorSchemes.lightColorScheme.onSurface,
      elevation: 0,
      titleTextStyle: AppTextThemes.lightTextTheme.titleLarge
          ?.copyWith(color: AppColorSchemes.lightColorScheme.onSurface),
      iconTheme: IconThemeData(
        color: AppColorSchemes.lightColorScheme.onSurface,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(1),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.disabled)
                ? AppColorSchemes.lightColorScheme.outline.withOpacity(0.5)
                : AppColorSchemes.lightColorScheme.primary;
          },
        ),
        foregroundColor:
            WidgetStatePropertyAll(AppColorSchemes.lightColorScheme.onPrimary),
        shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        textStyle: WidgetStatePropertyAll(
          AppTextThemes.lightTextTheme.titleMedium
              ?.copyWith(color: AppColorSchemes.lightColorScheme.onTertiary),
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) {
            return states.contains(WidgetState.pressed)
                ? AppColorSchemes.lightColorScheme.tertiary.withOpacity(0.2)
                : null;
          },
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      hintStyle: AppTextThemes.lightTextTheme.bodyMedium?.copyWith(
        color: AppColorSchemes.lightColorScheme.outline.withOpacity(0.6),
      ),
      errorStyle: AppTextThemes.lightTextTheme.labelMedium?.copyWith(
        color: AppColorSchemes.lightColorScheme.error,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: AppColorSchemes.lightColorScheme.outline.withOpacity(0.6),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: AppColorSchemes.lightColorScheme.outline.withOpacity(0.6),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
            color: AppColorSchemes.lightColorScheme.outline.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColorSchemes.lightColorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: AppColorSchemes.lightColorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      labelStyle: AppTextThemes.lightTextTheme.bodyMedium?.copyWith(
        color: AppColorSchemes.lightColorScheme.outline.withOpacity(0.75),
      ),
      prefixIconColor: WidgetStateColor.resolveWith(
        (states) {
          return states.contains(WidgetState.focused)
              ? AppColorSchemes.lightColorScheme.onSurface
              : AppColorSchemes.lightColorScheme.outline.withOpacity(0.6);
        },
      ),
      suffixIconColor: WidgetStateColor.resolveWith(
        (states) {
          return states.contains(WidgetState.focused)
              ? AppColorSchemes.lightColorScheme.onSurface
              : AppColorSchemes.lightColorScheme.outline.withOpacity(0.6);
        },
      ),
    ),
  );
}
