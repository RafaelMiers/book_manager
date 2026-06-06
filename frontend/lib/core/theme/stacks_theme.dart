import 'package:flutter/material.dart';

abstract class StacksColors {
  static const Color primary        = Color(0xFFA78BFA);
  static const Color primaryLight   = Color(0xFFC4B5FD);
  static const Color primaryDark    = Color(0xFF7C3AED);
  static const Color primarySurface = Color(0x22A78BFA);
  static const Color bgBase         = Color(0xFF0F0F12);
  static const Color bgSurface      = Color(0xFF1A1A24);
  static const Color bgElevated     = Color(0xFF222230);
  static const Color textPrimary    = Color(0xFFE0E0EA);
  static const Color textSecondary  = Color(0xFF888888);
  static const Color textHint       = Color(0xFF555555);
  static const Color textOnPrimary  = Color(0xFFFFFFFF);
  static const Color borderSubtle   = Color(0xFF2A2A38);
  static const Color borderMuted    = Color(0xFF222222);
  static const Color progressGreen  = Color(0xFF6EE7B7);
  static const Color progressOrange = Color(0xFFFB923C);
  static const Color starColor      = Color(0xFFF59E0B);
  static const Color success        = Color(0xFF34D399);
  static const Color error          = Color(0xFFE24B4A);
}

class StacksTheme {
  StacksTheme._();

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: StacksColors.bgBase,
      primaryColor: StacksColors.primary,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: StacksColors.primary,
        onPrimary: StacksColors.textOnPrimary,
        primaryContainer: StacksColors.primarySurface,
        onPrimaryContainer: StacksColors.primaryLight,
        secondary: StacksColors.progressGreen,
        onSecondary: StacksColors.bgBase,
        tertiary: StacksColors.progressOrange,
        surface: StacksColors.bgSurface,
        onSurface: StacksColors.textPrimary,
        onSurfaceVariant: StacksColors.textSecondary,
        outline: StacksColors.borderSubtle,
        outlineVariant: StacksColors.borderMuted,
        error: StacksColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: StacksColors.bgBase,
        foregroundColor: StacksColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: StacksColors.bgBase,
        indicatorColor: StacksColors.primarySurface,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
              color: s.contains(WidgetState.selected)
                  ? StacksColors.primary
                  : StacksColors.textHint,
              size: 22,
            )),
        labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
              fontSize: 10,
              color: s.contains(WidgetState.selected)
                  ? StacksColors.primary
                  : StacksColors.textHint,
            )),
      ),
      cardTheme: CardThemeData(
        color: StacksColors.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: StacksColors.borderSubtle, width: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: StacksColors.bgSurface,
        hintStyle: const TextStyle(color: StacksColors.textHint, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: StacksColors.borderSubtle, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: StacksColors.borderSubtle, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: StacksColors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: StacksColors.error, width: 0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: StacksColors.primary,
          foregroundColor: StacksColors.textOnPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: StacksColors.textSecondary,
          side: const BorderSide(color: StacksColors.borderSubtle, width: 0.5),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: StacksColors.bgSurface,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: StacksColors.primary,
          textStyle: const TextStyle(fontSize: 11),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: StacksColors.bgSurface,
        selectedColor: StacksColors.primarySurface,
        side: const BorderSide(color: StacksColors.borderSubtle, width: 0.5),
        labelStyle: const TextStyle(fontSize: 12, color: StacksColors.textSecondary),
        secondaryLabelStyle: const TextStyle(fontSize: 12, color: StacksColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        showCheckmark: false,
      ),
      dividerTheme: const DividerThemeData(
        color: StacksColors.borderMuted,
        thickness: 0.5,
        space: 0,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? StacksColors.primary : Colors.transparent),
        checkColor: WidgetStateProperty.all(StacksColors.textOnPrimary),
        side: const BorderSide(color: StacksColors.primary, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: StacksColors.bgElevated,
        contentTextStyle: const TextStyle(color: StacksColors.textPrimary, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: StacksColors.textPrimary),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: StacksColors.textPrimary),
        headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: StacksColors.textPrimary),
        titleLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: StacksColors.textPrimary, letterSpacing: -0.02),
        titleMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: StacksColors.textPrimary),
        titleSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: StacksColors.textSecondary, letterSpacing: 0.05),
        bodyLarge: TextStyle(fontSize: 16, color: StacksColors.textPrimary, height: 1.7),
        bodyMedium: TextStyle(fontSize: 13, color: StacksColors.textPrimary),
        bodySmall: TextStyle(fontSize: 11, color: StacksColors.textSecondary),
        labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: StacksColors.textPrimary),
        labelMedium: TextStyle(fontSize: 11, color: StacksColors.textSecondary),
        labelSmall: TextStyle(fontSize: 9, color: StacksColors.textHint, letterSpacing: 0.08),
      ),
    );
  }
}
