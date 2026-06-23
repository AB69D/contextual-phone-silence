import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF7C68EE);
  static const surface = Color(0xFF16141F);
  static const surfaceVariant = Color(0xFF1A1532);
  static const background = Color(0xFF0F0F13);
  static const error = Color(0xFFE24B4A);
  static const tertiary = Color(0xFF4CAF82);
  static const onPrimary = Colors.white;
  static const onSurface = Color(0xFFE8E6F0);
  static const onSurfaceVariant = Color(0xFFB0ACCC);

  static const profileWork = Color(0xFF7C68EE);
  static const profileGym = Color(0xFF4CAF82);
  static const profileInterview = Color(0xFF2196F3);
  static const profilePrayer = Color(0xFF66BB6A);
  static const profileCinema = Color(0xFFEF5350);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.surface,
          surfaceContainerHighest: AppColors.surfaceVariant,
          background: AppColors.background,
          error: AppColors.error,
          tertiary: AppColors.tertiary,
          onPrimary: AppColors.onPrimary,
          onSurface: AppColors.onSurface,
          onSurfaceVariant: AppColors.onSurfaceVariant,
        ),
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: const CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: Color(0x307C68EE),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(88, 48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceVariant,
          selectedColor: AppColors.primary.withOpacity(0.25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          labelStyle:
              const TextStyle(color: AppColors.onSurface, fontSize: 13),
        ),
      );

  static ThemeData get light => dark; // Dark-first design per spec
}
