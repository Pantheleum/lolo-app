import 'package:flutter/material.dart';

/// Represents one of the 10 AI message generation modes.
///
/// Modes 0-2 are free tier; modes 3-9 require premium subscription.
/// Each mode has an icon, localized name key, and description key
/// used by the Mode Picker grid.
enum MessageMode {
  romantic(icon: Icons.favorite, freeAccess: true),
  apology(icon: Icons.healing, freeAccess: true),
  appreciation(icon: Icons.thumb_up, freeAccess: true),
  flirty(icon: Icons.local_fire_department, freeAccess: false),
  encouragement(icon: Icons.emoji_events, freeAccess: false),
  missYou(icon: Icons.flight_takeoff, freeAccess: false),
  goodMorning(icon: Icons.wb_sunny, freeAccess: false),
  goodNight(icon: Icons.nightlight_round, freeAccess: false),
  anniversary(icon: Icons.cake, freeAccess: false),
  custom(icon: Icons.auto_awesome, freeAccess: false);

  const MessageMode({required this.icon, required this.freeAccess});

  final IconData icon;
  final bool freeAccess;

  /// Index-based check matching the spec: modes 0-2 are free.
  bool get isLocked => !freeAccess;
}
