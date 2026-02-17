import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_state.dart';
import 'package:lolo/features/onboarding/presentation/screens/language_selector_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/welcome_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/sign_up_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/your_name_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/her_name_zodiac_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/relationship_status_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/key_date_page.dart';
import 'package:lolo/features/onboarding/presentation/screens/first_action_card_page.dart';

/// Main onboarding screen with PageView for 8 onboarding steps.
///
/// Steps:
/// 0. Language selector (auto-advance on tap)
/// 1. Welcome page (tagline + benefits + CTA)
/// 2. Sign-up page (email / Google / Apple)
/// 3. Your name
/// 4. Her name + zodiac
/// 5. Relationship status
/// 6. Key date (anniversary / wedding)
/// 7. First AI action card (typewriter animation)
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingNotifierProvider);

    // Listen to state changes and navigate the PageView accordingly
    ref.listen<OnboardingState>(onboardingNotifierProvider, (previous, next) {
      next.whenOrNull(
        active: (data, currentStep, totalSteps) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != currentStep) {
            _pageController.animateToPage(
              currentStep,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        completed: () {
          // Navigate to home screen
          if (mounted) {
            context.go('/');
          }
        },
      );
    });

    final currentStep = state.maybeWhen(
      active: (_, step, __) => step,
      orElse: () => 0,
    );

    // Hide progress bar on language selector (step 0) and welcome page (step 1)
    final showProgress = currentStep >= 2;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator (hidden on first 2 steps)
            if (showProgress)
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: LoloSpacing.screenHorizontalPadding,
                  vertical: LoloSpacing.spaceXs,
                ),
                child: LinearProgressIndicator(
                  value: (currentStep - 1) / 6, // steps 2-7 mapped to 0-1
                  backgroundColor: LoloColors.darkBgTertiary,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    LoloColors.colorPrimary,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

            // Back button (shown from step 2 onwards)
            if (currentStep >= 2)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: LoloSpacing.spaceXs,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      ref
                          .read(onboardingNotifierProvider.notifier)
                          .goBack();
                    },
                  ),
                ),
              ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  LanguageSelectorPage(),   // Step 0
                  WelcomePage(),            // Step 1
                  SignUpPage(),             // Step 2
                  YourNamePage(),           // Step 3
                  HerNameZodiacPage(),      // Step 4
                  RelationshipStatusPage(), // Step 5
                  KeyDatePage(),            // Step 6
                  FirstActionCardPage(),    // Step 7
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
