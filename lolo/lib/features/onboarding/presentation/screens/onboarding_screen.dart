import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Main onboarding screen with PageView for 5 onboarding steps.
///
/// Steps:
/// 1. Your Name / Age / Status
/// 2. Her Name / Zodiac
/// 3. Anniversary Date
/// 4. Privacy Assurance
/// 5. First Action Card Preview
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: LoloSpacing.screenHorizontalPadding,
                vertical: LoloSpacing.spaceXs,
              ),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 5,
                backgroundColor: LoloColors.darkBgTertiary,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  LoloColors.colorPrimary,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: const [
                  // TODO: Replace with actual step screens
                  Placeholder(), // Step 1: Name
                  Placeholder(), // Step 2: Partner
                  Placeholder(), // Step 3: Anniversary
                  Placeholder(), // Step 4: Privacy
                  Placeholder(), // Step 5: First Card
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToNextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
