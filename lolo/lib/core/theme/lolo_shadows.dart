import 'package:flutter/material.dart';

/// LOLO shadow definitions.
///
/// Dark mode relies on background layering for depth (minimal shadows).
/// Light mode uses traditional elevation shadows.
abstract final class LoloShadows {
  // Light mode shadows
  static List<BoxShadow> get elevation1Light => [
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation2Light => [
        const BoxShadow(
          color: Color(0x1A1F2328),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation3Light => [
        const BoxShadow(
          color: Color(0x261F2328),
          blurRadius: 12,
          offset: Offset(0, 8),
        ),
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ];

  // Dark mode shadows (subtle, used sparingly)
  static List<BoxShadow> get elevation1Dark => [
        const BoxShadow(
          color: Color(0x33000000),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation2Dark => [
        const BoxShadow(
          color: Color(0x40000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ];
}
