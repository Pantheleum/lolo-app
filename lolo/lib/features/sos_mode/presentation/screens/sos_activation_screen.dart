import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_session.dart';
import 'package:lolo/features/sos_mode/presentation/providers/sos_provider.dart';
import 'package:lolo/features/sos_mode/presentation/widgets/scenario_selector.dart';

/// SOS activation screen: scenario selection and urgency level.
///
/// First step of the SOS flow. User selects what happened and how urgent it is.
class SosActivationScreen extends ConsumerStatefulWidget {
  const SosActivationScreen({super.key});

  @override
  ConsumerState<SosActivationScreen> createState() =>
      _SosActivationScreenState();
}

class _SosActivationScreenState extends ConsumerState<SosActivationScreen> {
  SosScenario? _selectedScenario;
  SosUrgency _urgency = SosUrgency.happeningNow;

  static const _urgencyLabels = {
    SosUrgency.happeningNow: 'Happening NOW',
    SosUrgency.justHappened: 'Just Happened',
    SosUrgency.brewing: 'Brewing / Building Up',
  };

  @override
  void initState() {
    super.initState();
    // Reset SOS state so a new session can be started
    Future.microtask(() => ref.read(sosNotifierProvider.notifier).reset());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sosState = ref.watch(sosNotifierProvider);

    ref.listen<SosState>(sosNotifierProvider, (prev, next) {
      if (next.session != null && prev?.session == null) {
        context.push('/sos/assessment');
      }
    });

    return Scaffold(
      appBar: LoloAppBar(
        title: 'SOS Mode',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LoloSpacing.spaceMd),

            // Emergency header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(LoloSpacing.spaceMd),
              decoration: BoxDecoration(
                color: LoloColors.colorError.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(LoloSpacing.cardBorderRadius),
                border: Border.all(
                  color: LoloColors.colorError.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.emergency,
                    color: LoloColors.colorError,
                    size: 28,
                  ),
                  const SizedBox(width: LoloSpacing.spaceSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What happened?',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: LoloColors.colorError,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Select the scenario that best describes the situation',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? LoloColors.darkTextSecondary
                                : LoloColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Scenario grid
            ScenarioSelector(
              selectedScenario: _selectedScenario,
              onScenarioSelected: (s) => setState(() => _selectedScenario = s),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Urgency selection
            Text(
              'How urgent is this?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceSm),
            ...SosUrgency.values.map((urgency) {
              final isSelected = _urgency == urgency;
              return Padding(
                padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
                child: GestureDetector(
                  onTap: () => setState(() => _urgency = urgency),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? LoloColors.colorPrimary.withValues(alpha: 0.12)
                          : (isDark
                              ? LoloColors.darkSurfaceElevated1
                              : LoloColors.lightSurfaceElevated1),
                      borderRadius:
                          BorderRadius.circular(LoloSpacing.cardBorderRadius),
                      border: Border.all(
                        color: isSelected
                            ? LoloColors.colorPrimary
                            : (isDark
                                ? LoloColors.darkBorderDefault
                                : LoloColors.lightBorderDefault),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected
                              ? LoloColors.colorPrimary
                              : (isDark
                                  ? LoloColors.darkTextTertiary
                                  : LoloColors.lightTextTertiary),
                        ),
                        const SizedBox(width: LoloSpacing.spaceSm),
                        Text(
                          _urgencyLabels[urgency]!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: LoloSpacing.space2xl),

            // Error display
            if (sosState.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: LoloSpacing.spaceMd),
                child: Text(
                  sosState.error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: LoloColors.colorError,
                  ),
                ),
              ),

            // Activate button
            LoloPrimaryButton(
              label: 'Get Help Now',
              icon: Icons.flash_on,
              isLoading: sosState.isLoading,
              isEnabled: _selectedScenario != null,
              onPressed: _selectedScenario == null
                  ? null
                  : () {
                      ref.read(sosNotifierProvider.notifier).activateSession(
                            scenario: _selectedScenario!,
                            urgency: _urgency,
                          );
                    },
            ),
            const SizedBox(height: LoloSpacing.screenBottomPaddingNoNav),
          ],
        ),
      ),
    );
  }
}
