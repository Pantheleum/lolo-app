import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// LOLO gradient definitions from the design system.
abstract final class LoloGradients {
  /// Premium: Level-up celebrations, premium badges, paywall CTA
  static const LinearGradient premium = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LoloColors.colorPrimary, LoloColors.colorAccent],
  );

  /// SOS: SOS mode activation, urgent alerts, danger pulse
  static const LinearGradient sos = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LoloColors.colorError, LoloColors.colorWarning],
  );

  /// Achievement: Badge unlocks, milestone cards, gold accents
  static const LinearGradient achievement = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC9A96E), Color(0xFFE8D5A3)],
  );

  /// Cool: Background subtle depth, app bar fade, onboarding backgrounds
  static const LinearGradient cool = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF161B22), Color(0xFF0D1117)],
  );

  /// Success: Streak milestones, completion celebrations
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3FB950), Color(0xFF56D364)],
  );

  /// Card Shimmer: Loading skeleton animation
  static const LinearGradient shimmerDark = LinearGradient(
    colors: [Color(0xFF21262D), Color(0xFF30363D), Color(0xFF21262D)],
  );

  /// Card Shimmer (light mode)
  static const LinearGradient shimmerLight = LinearGradient(
    colors: [Color(0xFFEAEEF2), Color(0xFFF6F8FA), Color(0xFFEAEEF2)],
  );
}
