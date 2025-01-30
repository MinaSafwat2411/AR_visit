import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.deepPurpleAccent,
  scaffoldBackgroundColor: AppColors.codGray2,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: AppColors.gray
    ),
    backgroundColor: AppColors.codGray2,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.deepPurpleAccent,
    secondary: Colors.tealAccent,
    background: AppColors.codGray2,
    surface: AppColors.codGray,
  ),
  cardTheme: CardTheme(
    color: AppColors.codGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.codGray,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.deepPurpleAccent),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
    ),
    hintStyle: const TextStyle(color: Colors.white54),
  ),
);
var lightTheme = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.white
  ),
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white
  )
);