import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// LOLO 6-tab bottom navigation bar.
///
/// Persistent across all non-onboarding screens. Supports badge counts
/// for notification indicators. RTL tab order is handled automatically
/// by Flutter's [BottomNavigationBar] when [Directionality] is RTL.
///
/// Tabs: Home, Messages, Actions, Memories, Her, Profile.
class LoloBottomNav extends StatelessWidget {
  const LoloBottomNav({
    required this.currentIndex,
    required this.onTabChanged,
    this.badgeCounts = const {},
    super.key,
  });

  /// Currently active tab index (0-5).
  final int currentIndex;

  /// Callback when a tab is tapped.
  final ValueChanged<int> onTabChanged;

  /// Badge counts keyed by tab index. Only displayed when value > 0.
  final Map<int, int> badgeCounts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgSecondary
        : LoloColors.lightBgSecondary;
    final borderColor = isDark
        ? LoloColors.darkBorderMuted
        : LoloColors.lightBorderMuted;
    final inactiveColor = isDark
        ? LoloColors.darkTextTertiary
        : LoloColors.lightTextTertiary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTabChanged,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            selectedItemColor: LoloColors.colorPrimary,
            unselectedItemColor: inactiveColor,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.33,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.33,
            ),
            elevation: 0,
            items: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Messages',
                index: 1,
              ),
              _buildNavItem(
                context,
                icon: Icons.style_outlined,
                activeIcon: Icons.style,
                label: 'Actions',
                index: 2,
              ),
              _buildNavItem(
                context,
                icon: Icons.photo_album_outlined,
                activeIcon: Icons.photo_album,
                label: 'Memories',
                index: 3,
              ),
              _buildNavItem(
                context,
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                label: 'Her',
                index: 4,
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final count = badgeCounts[index] ?? 0;

    Widget iconWidget(IconData data) {
      if (count > 0) {
        return Badge(
          label: count > 99
              ? const Text('99+', style: TextStyle(fontSize: 10))
              : Text('$count', style: const TextStyle(fontSize: 10)),
          backgroundColor: LoloColors.colorError,
          child: Icon(data),
        );
      }
      return Icon(data);
    }

    return BottomNavigationBarItem(
      icon: iconWidget(icon),
      activeIcon: _ActiveIndicatorIcon(child: iconWidget(activeIcon)),
      label: label,
      tooltip: label,
    );
  }
}

/// Wraps the active icon with a pill-shaped indicator background.
///
/// Pill dimensions: 56w x 32h dp, colorPrimary at 12% opacity, radius 16dp.
class _ActiveIndicatorIcon extends StatelessWidget {
  const _ActiveIndicatorIcon({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          color: LoloColors.colorPrimary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: child,
      );
}
