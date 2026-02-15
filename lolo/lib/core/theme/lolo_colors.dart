import 'package:flutter/material.dart';

/// LOLO Design System color tokens.
///
/// Every color used in the app MUST come from this class.
/// No inline hex values anywhere in the codebase.
abstract final class LoloColors {
  // === Brand Colors ===
  static const Color colorPrimary = Color(0xFF4A90D9);
  static const Color colorAccent = Color(0xFFC9A96E);

  // === Semantic Colors ===
  static const Color colorSuccess = Color(0xFF3FB950);
  static const Color colorSuccessLight = Color(0xFF1A7F37);
  static const Color colorWarning = Color(0xFFD29922);
  static const Color colorWarningLight = Color(0xFFBF8700);
  static const Color colorError = Color(0xFFF85149);
  static const Color colorErrorLight = Color(0xFFCF222E);
  static const Color colorInfo = Color(0xFF58A6FF);
  static const Color colorInfoLight = Color(0xFF0969DA);

  // === Dark Mode Palette (Default) ===
  static const Color darkBgPrimary = Color(0xFF0D1117);
  static const Color darkBgSecondary = Color(0xFF161B22);
  static const Color darkBgTertiary = Color(0xFF21262D);
  static const Color darkSurfaceElevated1 = Color(0xFF282E36);
  static const Color darkSurfaceElevated2 = Color(0xFF30363D);
  static const Color darkSurfaceOverlay = Color(0xB30D1117); // 70% opacity
  static const Color darkTextPrimary = Color(0xFFF0F6FC);
  static const Color darkTextSecondary = Color(0xFF8B949E);
  static const Color darkTextTertiary = Color(0xFF484F58);
  static const Color darkTextDisabled = Color(0xFF30363D);
  static const Color darkBorderDefault = Color(0xFF30363D);
  static const Color darkBorderMuted = Color(0xFF21262D);
  static const Color darkBorderAccent = Color(0xFF4A90D9);

  // === Light Mode Palette ===
  static const Color lightBgPrimary = Color(0xFFFFFFFF);
  static const Color lightBgSecondary = Color(0xFFF6F8FA);
  static const Color lightBgTertiary = Color(0xFFEAEEF2);
  static const Color lightSurfaceElevated1 = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated2 = Color(0xFFFFFFFF);
  static const Color lightSurfaceOverlay = Color(0x801F2328); // 50% opacity
  static const Color lightTextPrimary = Color(0xFF1F2328);
  static const Color lightTextSecondary = Color(0xFF656D76);
  static const Color lightTextTertiary = Color(0xFF8C959F);
  static const Color lightTextDisabled = Color(0xFFAFB8C1);
  static const Color lightBorderDefault = Color(0xFFD0D7DE);
  static const Color lightBorderMuted = Color(0xFFEAEEF2);
  static const Color lightBorderAccent = Color(0xFF4A90D9);

  // === Gray Scale ===
  static const Color gray0 = Color(0xFFF0F6FC);
  static const Color gray1 = Color(0xFFC9D1D9);
  static const Color gray2 = Color(0xFFB1BAC4);
  static const Color gray3 = Color(0xFF8B949E);
  static const Color gray4 = Color(0xFF6E7681);
  static const Color gray5 = Color(0xFF484F58);
  static const Color gray6 = Color(0xFF30363D);
  static const Color gray7 = Color(0xFF21262D);
  static const Color gray8 = Color(0xFF161B22);
  static const Color gray9 = Color(0xFF0D1117);

  // === Action Card Type Colors ===
  static const Color cardTypeSay = Color(0xFF4A90D9);
  static const Color cardTypeDo = Color(0xFF3FB950);
  static const Color cardTypeBuy = Color(0xFFC9A96E);
  static const Color cardTypeGo = Color(0xFF8957E5);
}
