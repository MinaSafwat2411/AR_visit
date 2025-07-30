import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppThemes {
  static final light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.trinidadColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      splashColor: AppColors.transparent,
      foregroundColor: AppColors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.trinidadColor,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(color: AppColors.white),
      unselectedIconTheme: IconThemeData(color: AppColors.white),
      unselectedLabelStyle: TextStyle(color: AppColors.white),
      selectedIconTheme: IconThemeData(color: AppColors.white),
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.trinidadColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      actionsIconTheme: IconThemeData(color: AppColors.trinidadColor),
      iconTheme: IconThemeData(color: AppColors.trinidadColor),
      titleTextStyle: TextStyle(color: AppColors.trinidadColor, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: AppColors.trinidadColor),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.trinidadColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.boulder),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.boulder),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.boulder),

      displayLarge: TextStyle(fontSize: 57, color: AppColors.trinidadColor),
      displayMedium: TextStyle(fontSize: 45, color: AppColors.trinidadColor),
      displaySmall: TextStyle(fontSize: 36, color: AppColors.trinidadColor),

      headlineLarge: TextStyle(fontSize: 32, color: AppColors.trinidadColor),
      headlineMedium: TextStyle(fontSize: 28, color: AppColors.trinidadColor),
      headlineSmall: TextStyle(fontSize: 24, color: AppColors.trinidadColor),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
    splashColor: AppColors.transparent,
    highlightColor: AppColors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.white,
        ), // Set text color
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.trinidadColor,
        ), // Set text color
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.softAmber,
      shadowColor: AppColors.gray,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.catskillWhite,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      elevation: 8,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.white,
      width: 300,
      elevation: 8,
      scrimColor: AppColors.gray20, // subtle overlay behind drawer
    ),
    datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        headerBackgroundColor: AppColors.white,
        headerForegroundColor: AppColors.trinidadColor,
        yearForegroundColor: WidgetStateProperty.all(AppColors.trinidadColor),
        rangeSelectionBackgroundColor: AppColors.white,
        rangePickerSurfaceTintColor: AppColors.trinidadColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.trinidadColor;
          }
          return AppColors.white;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.trinidadColor;
          }
          return AppColors.white;
        }),
        todayBorder: const BorderSide(
          color: AppColors.trinidadColor,
        ),
        todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.trinidadColor;
        }),
        rangeSelectionOverlayColor: const WidgetStatePropertyAll(AppColors.trinidadColor),
        rangePickerBackgroundColor: AppColors.trinidadColor,
        dayStyle: const TextStyle(
            color: AppColors.white
        ),
        cancelButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.trinidadColor)
        ),
        confirmButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.trinidadColor)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          helperStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          labelStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          hintStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          floatingLabelStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          counterStyle: TextStyle(
            color: AppColors.trinidadColor,
          ),
          filled: false,
        )
    ),
    colorScheme:  const ColorScheme.light(
      primary: AppColors.trinidadColor,
    ),
  );
  static final dark = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      splashColor: AppColors.transparent,
      foregroundColor: AppColors.trinidadColor,
    ),
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.trinidadColor,
      unselectedItemColor: AppColors.trinidadColor,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(color: AppColors.trinidadColor),
      unselectedIconTheme: IconThemeData(color: AppColors.trinidadColor),
      unselectedLabelStyle: TextStyle(color: AppColors.trinidadColor),
      selectedIconTheme: IconThemeData(color: AppColors.trinidadColor),
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      actionsIconTheme: IconThemeData(color: AppColors.white),
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.boulder),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.boulder),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.boulder),

      displayLarge: TextStyle(fontSize: 57, color: AppColors.white),
      // Large headings
      displayMedium: TextStyle(fontSize: 45, color: AppColors.white),
      displaySmall: TextStyle(fontSize: 36, color: AppColors.white),

      headlineLarge: TextStyle(fontSize: 32, color: AppColors.trinidadColor),
      // Section headings
      headlineMedium: TextStyle(fontSize: 28, color: AppColors.trinidadColor),
      headlineSmall: TextStyle(fontSize: 24, color: AppColors.trinidadColor),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      // Titles
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      // Buttons & labels
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    splashColor: AppColors.transparent,
    highlightColor: AppColors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.trinidadColor,
        ), // Set text color
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          AppColors.white,
        ), // Set text color
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.softAmber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.blackPearl,
      surfaceTintColor: AppColors.blackPearl2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      elevation: 8,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.white,
        splashColor: AppColors.transparent
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.blackPearl2,
      width: 300,
      elevation: 8,
      scrimColor: AppColors.gray20,
    ),
    datePickerTheme: DatePickerThemeData(
        headerForegroundColor: AppColors.white, // Changes "May 2025" text color
        headerHeadlineStyle: const TextStyle(color: AppColors.white), // Optional: change style of the date
        headerHelpStyle: const TextStyle(color: AppColors.white),
        backgroundColor: AppColors.riverBed,
        surfaceTintColor: AppColors.trinidadColor,
        headerBackgroundColor: AppColors.riverBed,
        weekdayStyle: const TextStyle(
            color: AppColors.white
        ),
        rangePickerHeaderHeadlineStyle: const TextStyle(
            color: AppColors.white
        ),
        rangePickerHeaderHelpStyle: const TextStyle(
            color: AppColors.white
        ),
        yearStyle: const TextStyle(
            color: AppColors.white
        ),
        rangePickerHeaderForegroundColor: AppColors.white,
        yearForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.trinidadColor; // Selected year text color
          }
          return AppColors.white; // Default year text color
        }),
        rangeSelectionBackgroundColor: AppColors.white,
        rangePickerSurfaceTintColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return null;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.riverBed;
        }),
        dayForegroundColor:WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.trinidadColor;
          }else if(states.contains(WidgetState.disabled)){
            return AppColors.gray;
          }
          return AppColors.white;
        }) ,
        todayBorder: const BorderSide(
          color: AppColors.white,
        ),
        todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.trinidadColor;
          }
          return AppColors.white;
        }),
        rangeSelectionOverlayColor: const WidgetStatePropertyAll(AppColors.white),
        rangePickerBackgroundColor: AppColors.trinidadColor,
        dayStyle: const TextStyle(
            color: AppColors.white
        ),
        cancelButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.white)
        ),
        confirmButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.white)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          helperStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.trinidadColor,
            ),
          ),
          labelStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          hintStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          floatingLabelStyle: TextStyle(
              color: AppColors.trinidadColor
          ),
          counterStyle: TextStyle(
            color: AppColors.trinidadColor,
          ),
          filled: false,
        )
    ),
    colorScheme:  const ColorScheme.dark(
      primary: AppColors.white,
    ),
  );
}
