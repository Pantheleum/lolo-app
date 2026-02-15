import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 0: Language selection.
///
/// Shows 3 large tappable tiles for English, Arabic, and Malay.
/// Auto-advances to the welcome page on tap -- no "Continue" button needed.
/// The tile shows the language name in its native script plus a flag emoji.
class LanguageSelectorPage extends ConsumerWidget {
  const LanguageSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(gradient: LoloGradients.cool),
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.space2xl,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
            'assets/images/logo/lolo_wordmark.png',
            height: 48,
          ),
          const SizedBox(height: LoloSpacing.space3xl),

          Text(
            l10n.onboarding_language_title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoloSpacing.space2xl),

          // English tile
          _LanguageTile(
            label: 'English',
            nativeLabel: 'English',
            flagEmoji: '\u{1F1FA}\u{1F1F8}',
            onTap: () {
              ref.read(onboardingNotifierProvider.notifier).setLanguage('en');
            },
          ),
          const SizedBox(height: LoloSpacing.spaceMd),

          // Arabic tile
          _LanguageTile(
            label: 'Arabic',
            nativeLabel: '\u0627\u0644\u0639\u0631\u0628\u064A\u0629',
            flagEmoji: '\u{1F1F8}\u{1F1E6}',
            onTap: () {
              ref.read(onboardingNotifierProvider.notifier).setLanguage('ar');
            },
          ),
          const SizedBox(height: LoloSpacing.spaceMd),

          // Malay tile
          _LanguageTile(
            label: 'Malay',
            nativeLabel: 'Bahasa Melayu',
            flagEmoji: '\u{1F1F2}\u{1F1FE}',
            onTap: () {
              ref.read(onboardingNotifierProvider.notifier).setLanguage('ms');
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.nativeLabel,
    required this.flagEmoji,
    required this.onTap,
  });

  final String label;
  final String nativeLabel;
  final String flagEmoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark
          ? LoloColors.darkSurfaceElevated1
          : LoloColors.lightSurfaceElevated1,
      borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.spaceXl,
            vertical: LoloSpacing.spaceLg,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
            border: Border.all(
              color: isDark
                  ? LoloColors.darkBorderDefault
                  : LoloColors.lightBorderDefault,
            ),
          ),
          child: Row(
            children: [
              Text(flagEmoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: LoloSpacing.spaceMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nativeLabel,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (label != nativeLabel)
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? LoloColors.darkTextSecondary
                                : LoloColors.lightTextSecondary,
                          ),
                    ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: LoloSpacing.iconSizeSmall,
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
