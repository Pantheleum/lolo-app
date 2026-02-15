import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

/// Full-screen or inline error state widget with icon, message, and retry CTA.
///
/// Displays an error icon, title, description, and an optional retry button.
/// Theme-aware with dark/light support. RTL-ready via directional padding.
class LoloErrorWidget extends StatelessWidget {
  const LoloErrorWidget({
    this.title = 'Something went wrong',
    this.description,
    this.onRetry,
    this.retryLabel = 'Try Again',
    this.icon,
    this.compact = false,
    this.semanticLabel,
    super.key,
  });

  /// Error title text.
  final String title;

  /// Optional error description or message.
  final String? description;

  /// Callback when the retry button is tapped.
  final VoidCallback? onRetry;

  /// Label for the retry button.
  final String retryLabel;

  /// Custom icon override. Defaults to error_outline.
  final IconData? icon;

  /// If true, renders a compact inline variant.
  final bool compact;

  /// Accessibility label override.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    if (compact) {
      return Semantics(
        label: semanticLabel ?? '$title. ${description ?? ""}',
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: Row(
            children: [
              Icon(icon ?? Icons.error_outline,
                  size: 24, color: LoloColors.colorError),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    if (description != null)
                      Text(description!,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: secondaryText)),
                  ],
                ),
              ),
              if (onRetry != null)
                TextButton(
                  onPressed: onRetry,
                  child: Text(retryLabel),
                ),
            ],
          ),
        ),
      );
    }

    return Semantics(
      label: semanticLabel ?? '$title. ${description ?? ""}',
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? Icons.error_outline,
                  size: 64, color: LoloColors.colorError),
              const SizedBox(height: 16),
              Text(title,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(description!,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: secondaryText),
                    textAlign: TextAlign.center,
                    maxLines: 3),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                LoloPrimaryButton(
                    label: retryLabel, onPressed: onRetry, fullWidth: false),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
