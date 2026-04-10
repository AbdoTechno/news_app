import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/theme/dark_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: DarkColors.scaffoldBackground,
  primaryColor: DarkColors.primary,
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.appBarBackground,
    foregroundColor: DarkColors.appBarForeground,
    elevation: 0,
    centerTitle: true,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: DarkColors.primary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkColors.primary,
      foregroundColor: DarkColors.elevatedButtonForeground,
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
    backgroundColor: DarkColors.bottomNavBarBackground,
    selectedItemColor: DarkColors.primary,
    unselectedItemColor: DarkColors.bottomNavBarUnselectedItem,
    enableFeedback: true,
  ),
  // input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkColors.inputFillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: DarkColors.inputHintColor),
    labelStyle: TextStyle(
      color: DarkColors.inputLabelColor,
      fontSize: AppSizes.fontSize16,
      fontWeight: FontWeight.w400,
    ),
  ),
  // text theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: DarkColors.bodyTextColor,
      fontSize: AppSizes.fontSize16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodyMedium: TextStyle(
      color: DarkColors.bodyTextColor,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
    bodySmall: TextStyle(
      color: DarkColors.bodyTextColor,
      fontSize: AppSizes.fontSize12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Times New Roman',
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: DarkColors.elevatedButtonForeground,
    borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
    strokeWidth: AppSizes.borderWidth3,
    strokeCap: StrokeCap.round,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: DarkColors.snackBarBackground,
    contentTextStyle: TextStyle(
      color: DarkColors.snackBarTextColor,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
);
