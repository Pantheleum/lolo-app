import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Time-based greeting header with user name and partner name.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    required this.userName,
    required this.partnerName,
    super.key,
  });

  final String userName;
  final String partnerName;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
        vertical: LoloSpacing.spaceMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_greeting, $userName',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: LoloSpacing.space2xs),
          Text(
            'Making $partnerName feel special today',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? LoloColors.darkTextSecondary
                  : LoloColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
