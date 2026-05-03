import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme(
      primary: AppColors.grey900,
      brightness: Brightness.light,
      onPrimary: AppColors.textWhite,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.textWhite,
      error: AppColors.error,
      onError: AppColors.error,
      surface: AppColors.surface,
      onSurface: AppColors.grey900,
    ),

    // Divider
    dividerColor: AppColors.divider,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      floatingLabelBehavior: FloatingLabelBehavior.always,

      hintStyle: const TextStyle(color: AppColors.textHint),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.textSecondary),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.textSecondary),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.textSecondary),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),

    //  Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    ),
  );
}
