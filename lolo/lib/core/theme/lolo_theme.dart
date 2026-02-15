import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_typography.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Builds the complete ThemeData for light and dark modes.
///
/// Always use `LoloTheme.dark()` or `LoloTheme.light()`.
/// The default theme mode is dark.
abstract final class LoloTheme {
  static ThemeData dark({Locale locale = const Locale('en')}) {
    final textTheme = LoloTypography.forLocale(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Colors
      colorScheme: const ColorScheme.dark(
        primary: LoloColors.colorPrimary,
        secondary: LoloColors.colorAccent,
        surface: LoloColors.darkBgSecondary,
        error: LoloColors.colorError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: LoloColors.darkTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: LoloColors.darkBgPrimary,

      // Typography
      textTheme: textTheme.apply(
        bodyColor: LoloColors.darkTextPrimary,
        displayColor: LoloColors.darkTextPrimary,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: LoloColors.darkBgSecondary,
        foregroundColor: LoloColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: LoloColors.darkTextPrimary,
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LoloColors.darkBgSecondary,
        selectedItemColor: LoloColors.colorPrimary,
        unselectedItemColor: LoloColors.darkTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Cards
      cardTheme: CardTheme(
        color: LoloColors.darkBgTertiary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          side: const BorderSide(
            color: LoloColors.darkBorderDefault,
            width: LoloSpacing.cardBorderWidth,
          ),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LoloColors.darkBgTertiary,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: LoloColors.darkTextTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.darkBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.darkBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(
            color: LoloColors.darkBorderAccent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.colorError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.spaceMd,
          vertical: LoloSpacing.spaceSm,
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LoloColors.colorPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: LoloColors.darkBorderMuted,
        thickness: 1,
        space: 1,
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LoloColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: LoloColors.darkSurfaceElevated1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: LoloColors.darkBgTertiary,
        selectedColor: LoloColors.colorPrimary.withValues(alpha: 0.15),
        side: const BorderSide(color: LoloColors.darkBorderDefault),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: textTheme.bodyMedium,
      ),
    );
  }

  static ThemeData light({Locale locale = const Locale('en')}) {
    final textTheme = LoloTypography.forLocale(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: LoloColors.colorPrimary,
        secondary: LoloColors.colorAccent,
        surface: LoloColors.lightBgSecondary,
        error: LoloColors.colorErrorLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: LoloColors.lightTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: LoloColors.lightBgPrimary,

      textTheme: textTheme.apply(
        bodyColor: LoloColors.lightTextPrimary,
        displayColor: LoloColors.lightTextPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: LoloColors.lightBgSecondary,
        foregroundColor: LoloColors.lightTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: LoloColors.lightTextPrimary,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LoloColors.lightBgSecondary,
        selectedItemColor: LoloColors.colorPrimary,
        unselectedItemColor: LoloColors.lightTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      cardTheme: CardTheme(
        color: LoloColors.lightBgTertiary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          side: const BorderSide(
            color: LoloColors.lightBorderDefault,
            width: LoloSpacing.cardBorderWidth,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LoloColors.lightBgTertiary,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: LoloColors.lightTextTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.lightBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.lightBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(
            color: LoloColors.lightBorderAccent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.colorErrorLight),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.spaceMd,
          vertical: LoloSpacing.spaceSm,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LoloColors.colorPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: LoloColors.lightBorderMuted,
        thickness: 1,
        space: 1,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LoloColors.lightBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: LoloColors.lightSurfaceElevated1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: LoloColors.lightBgTertiary,
        selectedColor: LoloColors.colorPrimary.withValues(alpha: 0.10),
        side: const BorderSide(color: LoloColors.lightBorderDefault),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: textTheme.bodyMedium,
      ),
    );
  }
}
