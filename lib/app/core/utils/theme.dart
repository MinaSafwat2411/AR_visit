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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.codGray2,
    selectedItemColor: AppColors.trinidadColor,
    unselectedItemColor: AppColors.white,
    showSelectedLabels: true,
    selectedLabelStyle: TextStyle(
      color: AppColors.trinidadColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.white,
    ),
    unselectedLabelStyle: TextStyle(
      color: AppColors.white,
    ),
    selectedIconTheme: IconThemeData(color: AppColors.trinidadColor),
    elevation: 1,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
  ),
);
var lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.trinidadColor,
      unselectedItemColor: AppColors.black,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: AppColors.trinidadColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.black,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.black,
      ),
      selectedIconTheme: IconThemeData(color: AppColors.trinidadColor),
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),
    scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white
  )
);