import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

/// Empty state placeholder with illustration, title, subtitle, and optional CTA.
///
/// Centered vertically within available space. 32dp horizontal padding.
/// Illustration area: 120x120dp.
///
/// Accepts either an [illustration] widget or an [icon] shorthand (which
/// is wrapped in an Icon widget automatically). Similarly, the body text
/// can be provided via [description] or the alias [subtitle].
class LoloEmptyState extends StatelessWidget {
  const LoloEmptyState({
    this.illustration,
    this.icon,
    required this.title,
    this.description,
    this.subtitle,
    this.ctaLabel,
    this.onCtaTap,
    this.semanticLabel,
    super.key,
  }) : assert(
          illustration != null || icon != null,
          'Either illustration or icon must be provided',
        );

  /// Full widget illustration (takes priority over [icon]).
  final Widget? illustration;

  /// Shorthand: when no [illustration] is provided, this icon is
  /// displayed inside a 64dp Icon widget with muted color.
  final IconData? icon;

  final String title;

  /// Body text (takes priority over [subtitle]).
  final String? description;

  /// Alias for [description] for convenience.
  final String? subtitle;

  final String? ctaLabel;
  final VoidCallback? onCtaTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText =
        isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;
    final bodyText = description ?? subtitle ?? '';

    final effectiveIllustration = illustration ??
        Icon(
          icon!,
          size: 64,
          color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary,
        );

    return Semantics(
      label: semanticLabel ?? '$title. $bodyText.',
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(width: 120, height: 120, child: effectiveIllustration),
            const SizedBox(height: 24),
            Text(title,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
                maxLines: 2),
            const SizedBox(height: 8),
            Text(bodyText,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: secondaryText),
                textAlign: TextAlign.center,
                maxLines: 3),
            if (ctaLabel != null && onCtaTap != null) ...[
              const SizedBox(height: 16),
              LoloPrimaryButton(
                  label: ctaLabel!, onPressed: onCtaTap, fullWidth: false),
            ],
          ]),
        ),
      ),
    );
  }
}
