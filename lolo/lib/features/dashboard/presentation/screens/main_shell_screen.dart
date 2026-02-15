import 'package:flutter/material.dart';

/// Main shell screen with bottom navigation bar.
///
/// Wraps the active tab screen via [child] from GoRouter ShellRoute.
class MainShellScreen extends StatelessWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Gifts'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'Memories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'More'),
        ],
      ),
    );
  }
}
