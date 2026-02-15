import 'package:flutter/material.dart';

/// Gift categories for browsing and filtering.
enum GiftCategory {
  all(icon: Icons.apps, label: 'All'),
  flowers(icon: Icons.local_florist, label: 'Flowers'),
  jewelry(icon: Icons.diamond, label: 'Jewelry'),
  experience(icon: Icons.confirmation_number, label: 'Experience'),
  food(icon: Icons.restaurant, label: 'Food'),
  tech(icon: Icons.devices, label: 'Tech'),
  handmade(icon: Icons.handyman, label: 'Handmade');

  const GiftCategory({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
