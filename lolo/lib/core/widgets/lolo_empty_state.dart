import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

/// Empty state placeholder with illustration, title, subtitle, and optional CTA.
///
/// Centered vertically within available space. 32dp horizontal padding.
/// Illustration area: 120x120dp.
class LoloEmptyState extends StatelessWidget {
  const LoloEmptyState({
    required this.illustration,
    required this.title,
    required this.description,
    this.ctaLabel,
    this.onCtaTap,
    this.semanticLabel,
    super.key,
  });

  final Widget illustration;
  final String title;
  final String description;
  final String? ctaLabel;
  final VoidCallback? onCtaTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(label: semanticLabel ?? '$title. $description.',
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(width: 120, height: 120, child: illustration),
            const SizedBox(height: 24),
            Text(title, style: theme.textTheme.headlineSmall, textAlign: TextAlign.center, maxLines: 2),
            const SizedBox(height: 8),
            Text(description, style: theme.textTheme.bodyMedium?.copyWith(color: secondaryText),
              textAlign: TextAlign.center, maxLines: 3),
            if (ctaLabel != null && onCtaTap != null) ...[
              const SizedBox(height: 16),
              LoloPrimaryButton(label: ctaLabel!, onPressed: onCtaTap, fullWidth: false),
            ],
          ]),
        ),
      ));
  }
}
