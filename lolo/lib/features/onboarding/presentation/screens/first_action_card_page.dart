import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_state.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 7: First AI-generated action card with typewriter animation.
///
/// Shows a SAY card with AI-generated content that types out character
/// by character. This is the "aha moment" -- demonstrating the app's
/// core value proposition before the user even reaches the home screen.
class FirstActionCardPage extends ConsumerStatefulWidget {
  const FirstActionCardPage({super.key});

  @override
  ConsumerState<FirstActionCardPage> createState() =>
      _FirstActionCardPageState();
}

class _FirstActionCardPageState extends ConsumerState<FirstActionCardPage> {
  String _displayedText = '';
  Timer? _typewriterTimer;
  bool _animationComplete = false;

  // Placeholder content -- replaced by actual AI response
  static const _sampleCardText =
      'Tell her: "I\'ve been thinking about you all day. '
      'No reason, no occasion -- just wanted you to know '
      'that you make my ordinary days feel extraordinary."';

  @override
  void initState() {
    super.initState();
    _startTypewriterAnimation(_sampleCardText);
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    super.dispose();
  }

  void _startTypewriterAnimation(String fullText) {
    var charIndex = 0;
    _typewriterTimer = Timer.periodic(
      const Duration(milliseconds: 35),
      (timer) {
        if (charIndex < fullText.length) {
          setState(() {
            _displayedText = fullText.substring(0, charIndex + 1);
          });
          charIndex++;
        } else {
          timer.cancel();
          setState(() => _animationComplete = true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(onboardingNotifierProvider);

    final partnerName = state.maybeWhen(
      active: (data, _, __) => data.partnerName ?? '',
      generatingFirstCard: (name, _) => name,
      orElse: () => '',
    );

    return Container(
      decoration: const BoxDecoration(gradient: LoloGradients.cool),
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Column(
        children: [
          const Spacer(),

          // Title
          Text(
            l10n.onboarding_firstCard_title(partnerName),
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoloSpacing.space2xl),

          // SAY card with typewriter text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(LoloSpacing.spaceXl),
            decoration: BoxDecoration(
              color: LoloColors.darkSurfaceElevated1,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LoloColors.cardTypeSay.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SAY badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: LoloColors.cardTypeSay.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'SAY',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: LoloColors.cardTypeSay,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                // Typewriter text
                Text(
                  _displayedText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
                ),

                // Blinking cursor
                if (!_animationComplete)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 530),
                    builder: (context, value, _) => Opacity(
                      opacity: value > 0.5 ? 1 : 0,
                      child: Container(
                        width: 2,
                        height: 20,
                        color: LoloColors.colorPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          Text(
            'Personalized for $partnerName',
            style: theme.textTheme.bodySmall?.copyWith(
              color: LoloColors.darkTextTertiary,
            ),
          ),

          const Spacer(),

          // CTA
          LoloPrimaryButton(
            label: l10n.onboarding_welcome_button_start,
            onPressed: _animationComplete
                ? () {
                    ref
                        .read(onboardingNotifierProvider.notifier)
                        .completeAndShowFirstCard();
                  }
                : null,
          ),
          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }
}
