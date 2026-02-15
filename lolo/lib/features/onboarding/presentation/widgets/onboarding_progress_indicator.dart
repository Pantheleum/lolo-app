import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Custom segmented progress indicator for onboarding steps 3-6.
///
/// Displays 4 segments: the current step is animated with a growing bar,
/// completed steps are filled, and future steps are empty.
class OnboardingProgressIndicator extends StatelessWidget {
  const OnboardingProgressIndicator({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final emptyColor =
        isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;

    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: index < totalSteps - 1 ? LoloSpacing.spaceXs : 0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? LoloColors.colorPrimary
                    : emptyColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }),
    );
  }
}
