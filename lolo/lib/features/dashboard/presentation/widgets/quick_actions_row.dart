import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Row of quick action buttons: SOS, AI Message, Gift Ideas.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({
    required this.onSos,
    required this.onAiMessage,
    required this.onGiftIdeas,
    super.key,
  });

  final VoidCallback onSos;
  final VoidCallback onAiMessage;
  final VoidCallback onGiftIdeas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionButton(
              icon: Icons.sos,
              label: 'SOS',
              color: LoloColors.colorError,
              onTap: onSos,
            ),
          ),
          const SizedBox(width: LoloSpacing.spaceSm),
          Expanded(
            child: _QuickActionButton(
              icon: Icons.auto_awesome,
              label: 'AI Message',
              color: LoloColors.colorPrimary,
              onTap: onAiMessage,
            ),
          ),
          const SizedBox(width: LoloSpacing.spaceSm),
          Expanded(
            child: _QuickActionButton(
              icon: Icons.card_giftcard,
              label: 'Gift Ideas',
              color: LoloColors.colorAccent,
              onTap: onGiftIdeas,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      label: label,
      button: true,
      child: Material(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: LoloSpacing.spaceXs,
              vertical: LoloSpacing.spaceSm,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: LoloSpacing.iconSizeLarge),
                const SizedBox(height: LoloSpacing.space2xs),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextPrimary
                        : LoloColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
