import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

/// Welcome screen -- first screen shown to unauthenticated users.
///
/// Shows app logo, tagline, and Get Started / Login buttons.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                ),
                child: const Icon(
                  Icons.explore,
                  size: 56,
                  color: LoloColors.colorPrimary,
                ),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // App name
              Text(
                'LOLO',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: LoloColors.colorPrimary,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: LoloSpacing.spaceSm),

              // Tagline
              Text(
                'Your AI-powered relationship\nintelligence companion',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDark
                      ? LoloColors.darkTextSecondary
                      : LoloColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: LoloSpacing.space3xl),

              // Feature highlights
              _FeatureRow(
                icon: Icons.auto_awesome,
                text: 'AI-crafted messages for every moment',
              ),
              const SizedBox(height: LoloSpacing.spaceMd),
              _FeatureRow(
                icon: Icons.card_giftcard,
                text: 'Smart gift recommendations',
              ),
              const SizedBox(height: LoloSpacing.spaceMd),
              _FeatureRow(
                icon: Icons.notifications_active,
                text: 'Never forget an important date',
              ),

              const Spacer(flex: 3),

              // Get Started button
              LoloPrimaryButton(
                label: 'Get Started',
                onPressed: () => context.goNamed('onboarding'),
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? LoloColors.darkTextSecondary
                          : LoloColors.lightTextSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.goNamed('login'),
                    child: Text(
                      'Log In',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: LoloColors.colorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: LoloSpacing.space2xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LoloColors.colorAccent.withValues(alpha: 0.12),
          ),
          child: Icon(icon, color: LoloColors.colorAccent, size: 20),
        ),
        const SizedBox(width: LoloSpacing.spaceMd),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? LoloColors.darkTextPrimary
                  : LoloColors.lightTextPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
