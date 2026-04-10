import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/theme/light_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: LightColors.scaffoldBackground,
  primaryColor: LightColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: LightColors.appBarBackground,
    foregroundColor: LightColors.appBarForeground,
    elevation: 0,
    centerTitle: true,

    titleTextStyle: TextStyle(
      color: LightColors.titleTextColor,
      fontSize: AppSizes.fontSize18,
      fontWeight: FontWeight.w700,
      fontFamily: 'Times New Roman',
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColors.primary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primary,
      foregroundColor: LightColors.elevatedButtonForeground,
      textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppSizes.fontSize16,
      ),
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
      fontSize: AppSizes.fontSize16,
      fontWeight: FontWeight.w400,
    ),
  ),
  // text theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: AppSizes.fontSize16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodyMedium: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodySmall: TextStyle(
      color: LightColors.bodyTextColor,
      fontSize: AppSizes.fontSize12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: LightColors.elevatedButtonForeground,
    borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
    strokeWidth: AppSizes.borderWidth3,
    strokeCap: StrokeCap.round,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: LightColors.snackBarBackground,
    contentTextStyle: TextStyle(
      color: LightColors.snackBarTextColor,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),

  // appbar theme
);
