import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_session.dart';

/// Grid of scenario cards for SOS activation.
///
/// Each card shows an icon and label for a relationship crisis scenario.
class ScenarioSelector extends StatelessWidget {
  const ScenarioSelector({
    required this.selectedScenario,
    required this.onScenarioSelected,
    super.key,
  });

  final SosScenario? selectedScenario;
  final ValueChanged<SosScenario> onScenarioSelected;

  static const _scenarioData = <SosScenario, ({IconData icon, String label})>{
    SosScenario.sheIsAngry: (icon: Icons.whatshot, label: "She's Angry"),
    SosScenario.sheIsCrying: (icon: Icons.water_drop, label: "She's Crying"),
    SosScenario.sheIsSilent: (icon: Icons.volume_off, label: "Silent Treatment"),
    SosScenario.caughtInLie: (icon: Icons.visibility_off, label: "Caught in a Lie"),
    SosScenario.forgotImportantDate: (icon: Icons.event_busy, label: "Forgot a Date"),
    SosScenario.saidWrongThing: (icon: Icons.chat_bubble_outline, label: "Said Wrong Thing"),
    SosScenario.sheWantsToTalk: (icon: Icons.forum, label: "She Wants to Talk"),
    SosScenario.herFamilyConflict: (icon: Icons.family_restroom, label: "Family Conflict"),
    SosScenario.jealousyIssue: (icon: Icons.heart_broken, label: "Jealousy Issue"),
    SosScenario.other: (icon: Icons.help_outline, label: "Other"),
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: LoloSpacing.spaceXs,
        crossAxisSpacing: LoloSpacing.spaceXs,
        childAspectRatio: 1.4,
      ),
      itemCount: SosScenario.values.length,
      itemBuilder: (context, index) {
        final scenario = SosScenario.values[index];
        final data = _scenarioData[scenario]!;
        final isSelected = selectedScenario == scenario;

        return Semantics(
          label: data.label,
          selected: isSelected,
          child: GestureDetector(
            onTap: () => onScenarioSelected(scenario),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected
                    ? LoloColors.colorError.withValues(alpha: 0.15)
                    : (isDark
                        ? LoloColors.darkSurfaceElevated1
                        : LoloColors.lightSurfaceElevated1),
                borderRadius:
                    BorderRadius.circular(LoloSpacing.cardBorderRadius),
                border: Border.all(
                  color: isSelected
                      ? LoloColors.colorError
                      : (isDark
                          ? LoloColors.darkBorderDefault
                          : LoloColors.lightBorderDefault),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    data.icon,
                    size: 28,
                    color: isSelected
                        ? LoloColors.colorError
                        : LoloColors.colorPrimary,
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Text(
                    data.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? LoloColors.colorError
                              : (isDark
                                  ? LoloColors.darkTextPrimary
                                  : LoloColors.lightTextPrimary),
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
