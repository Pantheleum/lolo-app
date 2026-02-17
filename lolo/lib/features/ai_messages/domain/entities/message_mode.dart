import 'package:flutter/material.dart';

/// Represents one of the 10 AI message generation modes.
///
/// Modes 0-2 are free tier; modes 3-9 require premium subscription.
/// Each mode has an icon, localized name key, and description key
/// used by the Mode Picker grid.
// TODO: Restore freeAccess restrictions before production launch
enum MessageMode {
  romantic(icon: Icons.favorite, freeAccess: true),
  apology(icon: Icons.healing, freeAccess: true),
  appreciation(icon: Icons.thumb_up, freeAccess: true),
  flirty(icon: Icons.local_fire_department, freeAccess: true),
  encouragement(icon: Icons.emoji_events, freeAccess: true),
  missYou(icon: Icons.flight_takeoff, freeAccess: true),
  goodMorning(icon: Icons.wb_sunny, freeAccess: true),
  goodNight(icon: Icons.nightlight_round, freeAccess: true),
  anniversary(icon: Icons.cake, freeAccess: true),
  custom(icon: Icons.auto_awesome, freeAccess: true);

  const MessageMode({required this.icon, required this.freeAccess});

  final IconData icon;
  final bool freeAccess;

  /// Index-based check matching the spec: modes 0-2 are free.
  bool get isLocked => !freeAccess;
}
