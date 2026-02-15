import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Chat bubble for AI coach and user messages in the SOS coaching flow.
///
/// AI messages appear on the start edge with primary color accent.
/// User messages appear on the end edge with accent gold.
class CoachingMessageBubble extends StatelessWidget {
  const CoachingMessageBubble({
    required this.message,
    required this.isAi,
    this.subtitle,
    this.timestamp,
    super.key,
  });

  final String message;
  final bool isAi;
  final String? subtitle;
  final String? timestamp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isAi
        ? (isDark
            ? LoloColors.colorPrimary.withValues(alpha: 0.15)
            : LoloColors.colorPrimary.withValues(alpha: 0.08))
        : (isDark
            ? LoloColors.colorAccent.withValues(alpha: 0.15)
            : LoloColors.colorAccent.withValues(alpha: 0.08));

    final borderColor = isAi ? LoloColors.colorPrimary : LoloColors.colorAccent;

    return Align(
      alignment:
          isAi ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
        padding: const EdgeInsets.all(LoloSpacing.spaceMd),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          border: BorderDirectional(
            start: isAi
                ? BorderSide(width: 3, color: borderColor)
                : BorderSide.none,
            end: isAi
                ? BorderSide.none
                : BorderSide(width: 3, color: borderColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAi)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.psychology, size: 16, color: borderColor),
                    const SizedBox(width: 4),
                    Text(
                      'LOLO Coach',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: borderColor,
                      ),
                    ),
                  ],
                ),
              ),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? LoloColors.darkTextPrimary
                    : LoloColors.lightTextPrimary,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: LoloSpacing.space2xs),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: isDark
                      ? LoloColors.darkTextSecondary
                      : LoloColors.lightTextSecondary,
                ),
              ),
            ],
            if (timestamp != null) ...[
              const SizedBox(height: LoloSpacing.space2xs),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  timestamp!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
