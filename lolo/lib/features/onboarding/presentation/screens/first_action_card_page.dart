import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/router/route_guards.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 7: First AI-generated action card with typewriter animation.
///
/// Shows a SAY card with content that types out character by character.
/// This is the "aha moment" -- demonstrating the app's core value
/// proposition before the user even reaches the home screen.
class FirstActionCardPage extends ConsumerStatefulWidget {
  const FirstActionCardPage({super.key});

  @override
  ConsumerState<FirstActionCardPage> createState() =>
      _FirstActionCardPageState();
}

class _FirstActionCardPageState extends ConsumerState<FirstActionCardPage> {
  String _displayedText = '';
  String _fullText = '';
  Timer? _typewriterTimer;
  bool _animationComplete = false;
  bool _isCompleting = false;

  static const _sampleCards = [
    'Tell her: "I\'ve been thinking about you all day. '
        'No reason, no occasion -- just wanted you to know '
        'that you make my ordinary days feel extraordinary."',
    'Send her this: "You know what I realized today? '
        'Every love song suddenly makes sense since I met you. '
        'Just thought you should know."',
    'Say this tonight: "I don\'t say it enough, but '
        'the way you laugh at my terrible jokes makes me '
        'feel like the luckiest person alive."',
    'Text her: "I was about to do something boring, '
        'but then I thought about your smile and suddenly '
        'my whole day got better. You have that power."',
    'Whisper this: "I love how you always know the right '
        'thing to say. But right now, I just want you to know '
        'that being with you is my favorite place to be."',
    'Tell her: "Do you know what my favorite moment of the '
        'day is? It\'s that second when I see your face and '
        'everything else just fades away."',
  ];

  @override
  void initState() {
    super.initState();
    _fullText = _sampleCards[Random().nextInt(_sampleCards.length)];
    _startTypewriterAnimation(_fullText);
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

  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);

    try {
      // Set synchronous override IMMEDIATELY to prevent route guard race condition
      ref.read(onboardingCompleteOverrideProvider.notifier).state = true;

      // Persist to SharedPreferences for next app launch
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', true);
      ref.invalidate(onboardingCompleteProvider);

      // Save profile data to Firestore (awaited so data persists)
      await ref
          .read(onboardingNotifierProvider.notifier)
          .completeAndShowFirstCard();

      if (mounted) {
        context.go('/');
      }
    } catch (_) {
      // Even if Firestore save fails, navigate to home
      if (mounted) {
        context.go('/');
      }
    }
  }

  void _copyMessage() {
    Clipboard.setData(ClipboardData(text: _fullText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied!'),
        duration: Duration(seconds: 2),
      ),
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
          GestureDetector(
            onLongPress: _animationComplete ? _copyMessage : null,
            child: Container(
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
                  // SAY badge + copy button
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              LoloColors.cardTypeSay.withValues(alpha: 0.15),
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
                      const Spacer(),
                      if (_animationComplete)
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          color: LoloColors.darkTextTertiary,
                          onPressed: _copyMessage,
                          tooltip: 'Copy message',
                        ),
                    ],
                  ),
                  const SizedBox(height: LoloSpacing.spaceMd),

                  // Typewriter text
                  SelectableText(
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
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          Text(
            'Personalized for $partnerName',
            style: theme.textTheme.bodySmall?.copyWith(
              color: LoloColors.darkTextTertiary,
            ),
          ),
          if (_animationComplete)
            Padding(
              padding: const EdgeInsets.only(top: LoloSpacing.spaceXs),
              child: Text(
                'Long press or tap copy to share',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.darkTextTertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          const Spacer(),

          // CTA
          LoloPrimaryButton(
            label: l10n.onboarding_welcome_button_start,
            isLoading: _isCompleting,
            onPressed: _animationComplete ? _completeOnboarding : null,
          ),
          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }
}
