import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Achievement badge display card for the gamification system.
///
/// Shows a badge icon, title, description, and earned/locked state.
/// Locked badges display a grayscale overlay with a lock icon.
/// Earned badges show the full-color icon with an optional earned date.
class BadgeCard extends StatelessWidget {
  const BadgeCard({
    required this.title,
    required this.description,
    this.icon,
    this.isEarned = false,
    this.earnedDate,
    this.badgeColor,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  /// Badge title text.
  final String title;

  /// Badge description or requirement text.
  final String description;

  /// Badge icon. Defaults to [Icons.military_tech].
  final IconData? icon;

  /// Whether the badge has been earned.
  final bool isEarned;

  /// Date the badge was earned, if applicable.
  final DateTime? earnedDate;

  /// Badge accent color. Defaults to colorAccent.
  final Color? badgeColor;

  /// Tap callback for viewing badge details.
  final VoidCallback? onTap;

  /// Accessibility label override.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg =
        isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor =
        isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final secondaryText =
        isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;
    final effectiveColor = badgeColor ?? LoloColors.colorAccent;
    final iconColor = isEarned
        ? effectiveColor
        : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary);

    return Semantics(
      label: semanticLabel ??
          '$title. ${isEarned ? "Earned" : "Locked"}. $description.',
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isEarned ? effectiveColor.withValues(alpha: 0.5) : borderColor,
              width: isEarned ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isEarned
                          ? effectiveColor.withValues(alpha: 0.12)
                          : (isDark
                              ? LoloColors.darkBorderDefault
                              : LoloColors.lightBorderMuted),
                    ),
                    child: Icon(
                      icon ?? Icons.military_tech,
                      size: 28,
                      color: iconColor,
                    ),
                  ),
                  if (!isEarned)
                    PositionedDirectional(
                      bottom: 0,
                      end: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? LoloColors.darkBgSecondary
                              : LoloColors.lightBgSecondary,
                        ),
                        child: Icon(
                          Icons.lock_outlined,
                          size: 12,
                          color: isDark
                              ? LoloColors.darkTextTertiary
                              : LoloColors.lightTextTertiary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isEarned ? null : secondaryText,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: secondaryText,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isEarned && earnedDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Earned ${earnedDate!.day}/${earnedDate!.month}/${earnedDate!.year}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: effectiveColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
