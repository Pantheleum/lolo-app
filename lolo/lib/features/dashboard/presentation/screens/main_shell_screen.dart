import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/widgets/lolo_bottom_nav.dart';

/// Main shell screen with bottom navigation bar.
///
/// Wraps the active tab screen via [child] from GoRouter ShellRoute.
/// Uses [LoloBottomNav] for consistent styling across the app.
class MainShellScreen extends StatelessWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  static const _tabPaths = ['/', '/messages', '/gifts', '/memories', '/her', '/profile'];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = _tabPaths.length - 1; i >= 0; i--) {
      if (i == 0 && location == '/') return 0;
      if (i > 0 && location.startsWith(_tabPaths[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: LoloBottomNav(
        currentIndex: currentIndex,
        onTabChanged: (index) {
          if (index != currentIndex) {
            context.go(_tabPaths[index]);
          }
        },
      ),
    );
  }
}
