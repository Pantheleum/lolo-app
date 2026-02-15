import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 1: Welcome page with tagline, 3 benefit highlights, and CTA.
///
/// Visual treatment: gradient background, centered layout, staggered
/// fade-in animations for each benefit row.
class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _benefit1Fade;
  late final Animation<double> _benefit2Fade;
  late final Animation<double> _benefit3Fade;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _benefit1Fade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _benefit2Fade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    _benefit3Fade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(gradient: LoloGradients.cool),
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.space2xl,
      ),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Logo
          Image.asset('assets/images/logo/lolo_logo.png', height: 80),
          const SizedBox(height: LoloSpacing.spaceXl),

          // Tagline
          Text(
            l10n.onboarding_welcome_tagline,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: LoloColors.darkTextPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Benefit 1: Smart Reminders
          FadeTransition(
            opacity: _benefit1Fade,
            child: _BenefitRow(
              icon: Icons.notifications_active_outlined,
              title: l10n.onboarding_welcome_benefit1_title,
              subtitle: l10n.onboarding_welcome_benefit1_subtitle,
            ),
          ),
          const SizedBox(height: LoloSpacing.spaceLg),

          // Benefit 2: AI Messages
          FadeTransition(
            opacity: _benefit2Fade,
            child: _BenefitRow(
              icon: Icons.chat_bubble_outline,
              title: l10n.onboarding_welcome_benefit2_title,
              subtitle: l10n.onboarding_welcome_benefit2_subtitle,
            ),
          ),
          const SizedBox(height: LoloSpacing.spaceLg),

          // Benefit 3: SOS Mode
          FadeTransition(
            opacity: _benefit3Fade,
            child: _BenefitRow(
              icon: Icons.sos_outlined,
              title: l10n.onboarding_welcome_benefit3_title,
              subtitle: l10n.onboarding_welcome_benefit3_subtitle,
            ),
          ),

          const Spacer(),

          // CTA button
          LoloPrimaryButton(
            label: l10n.onboarding_welcome_button_start,
            onPressed: () {
              ref
                  .read(onboardingNotifierProvider.notifier)
                  .advanceToSignUp();
            },
          ),
          const SizedBox(height: LoloSpacing.spaceMd),

          // Login link
          TextButton(
            onPressed: () {
              // Navigate to login screen
            },
            child: Text(
              l10n.onboarding_welcome_link_login,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: LoloColors.colorPrimary,
              ),
            ),
          ),

          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: LoloColors.colorPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: LoloColors.colorPrimary),
          ),
          const SizedBox(width: LoloSpacing.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: LoloColors.darkTextSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      );
}
