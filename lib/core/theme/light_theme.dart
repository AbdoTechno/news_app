import 'package:flutter/material.dart';
import 'package:news/core/theme/light_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: LightColors.scaffoldBackground,
  primaryColor: LightColors.primary,
  appBarTheme: const AppBarTheme(),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.primary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primary,
      foregroundColor: LightColors.elevatedButtonForeground,
      textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: LightColors.bottomNavBarBackground,
    selectedItemColor: LightColors.primary,
    unselectedItemColor: LightColors.bottomNavBarUnselectedItem,
    enableFeedback: true,
  ),
  // input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LightColors.inputFillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: LightColors.inputHintColor),
    labelStyle: TextStyle(
      color: LightColors.inputLabelColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  // text theme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodyMedium: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodySmall: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: LightColors.elevatedButtonForeground,
    borderRadius: BorderRadius.circular(12),
    strokeWidth: 3,
    strokeCap: StrokeCap.round,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: LightColors.snackBarBackground,
    contentTextStyle: TextStyle(
      color: LightColors.snackBarTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
);
