import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';

/// A single mode card in the 2-column Mode Picker grid.
///
/// Shows the mode icon, localized name, and a short description.
/// Locked modes display a semi-transparent overlay with a lock icon.
class MessageModeCard extends StatelessWidget {
  const MessageModeCard({
    required this.mode,
    required this.onTap,
    this.isLocked = false,
    super.key,
  });

  final MessageMode mode;
  final bool isLocked;
  final VoidCallback onTap;

  /// Mode display names. In production these would come from
  /// AppLocalizations; hardcoded here for sprint velocity.
  String get _modeName => switch (mode) {
        MessageMode.romantic => 'Romantic',
        MessageMode.apology => 'Apology',
        MessageMode.appreciation => 'Appreciation',
        MessageMode.flirty => 'Flirty',
        MessageMode.encouragement => 'Encouragement',
        MessageMode.missYou => 'Miss You',
        MessageMode.goodMorning => 'Good Morning',
        MessageMode.goodNight => 'Good Night',
        MessageMode.anniversary => 'Anniversary',
        MessageMode.custom => 'Custom',
      };

  String get _modeDescription => switch (mode) {
        MessageMode.romantic => 'Express your deep love and affection',
        MessageMode.apology => 'Say sorry the right way',
        MessageMode.appreciation => 'Show her you notice and care',
        MessageMode.flirty => 'Playful messages to make her smile',
        MessageMode.encouragement => 'Lift her spirits when she needs it',
        MessageMode.missYou => 'Let her know she is on your mind',
        MessageMode.goodMorning => 'Start her day with warmth',
        MessageMode.goodNight => 'Sweet dreams messages',
        MessageMode.anniversary => 'Celebrate your milestones',
        MessageMode.custom => 'Write about anything you want',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: '$_modeName. $_modeDescription. ${isLocked ? "Premium feature." : ""}',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
            border: Border.all(color: borderColor, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Card content
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  LoloSpacing.cardInnerPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon container
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        mode.icon,
                        color: LoloColors.colorPrimary,
                        size: LoloSpacing.iconSizeMedium,
                      ),
                    ),
                    const SizedBox(height: LoloSpacing.spaceSm),

                    // Mode name
                    Text(
                      _modeName,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: LoloSpacing.space2xs),

                    // Description
                    Text(
                      _modeDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondaryText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Lock overlay for premium modes
              if (isLocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: (isDark
                              ? LoloColors.darkBgPrimary
                              : LoloColors.lightBgPrimary)
                          .withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(
                        LoloSpacing.cardBorderRadius,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: LoloColors.colorAccent.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: LoloColors.colorAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
