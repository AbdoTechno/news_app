import 'package:flutter/material.dart';
import 'package:news/core/theme/dark_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: DarkColors.scaffoldBackground,
  primaryColor: DarkColors.primary,
  appBarTheme: const AppBarTheme(),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: DarkColors.primary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkColors.primary,
      foregroundColor: DarkColors.elevatedButtonForeground,
      textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: DarkColors.bottomNavBarBackground,
    selectedItemColor: DarkColors.bottomNavBarSelectedItem,
    unselectedItemColor: DarkColors.bottomNavBarUnselectedItem,
    enableFeedback: true,
  ),
);
