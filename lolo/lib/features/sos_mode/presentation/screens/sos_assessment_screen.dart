import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/sos_coaching_card.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos_mode/presentation/providers/sos_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Quick assessment questions before AI coaching begins.
///
/// Gathers context: how long ago, her current state, fault, what happened.
class SosAssessmentScreen extends ConsumerStatefulWidget {
  const SosAssessmentScreen({super.key});

  @override
  ConsumerState<SosAssessmentScreen> createState() =>
      _SosAssessmentScreenState();
}

class _SosAssessmentScreenState extends ConsumerState<SosAssessmentScreen> {
  String? _howLongAgo;
  String? _herCurrentState;
  bool _isYourFault = false;
  final _whatHappenedController = TextEditingController();

  static List<String> _timeOptions(AppLocalizations l10n) => [
    l10n.sos_time_rightNow,
    l10n.sos_time_fewMinutes,
    l10n.sos_time_withinHour,
    l10n.sos_time_earlierToday,
    l10n.sos_time_yesterday,
  ];

  static List<String> _stateOptions(AppLocalizations l10n) => [
    l10n.sos_state_yelling,
    l10n.sos_state_crying,
    l10n.sos_state_coldSilent,
    l10n.sos_state_disappointed,
    l10n.sos_state_confused,
    l10n.sos_state_hurt,
    l10n.sos_state_calmUpset,
  ];

  @override
  void dispose() {
    _whatHappenedController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _howLongAgo != null &&
      _herCurrentState != null &&
      _whatHappenedController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final sosState = ref.watch(sosNotifierProvider);
    final session = sosState.session;

    ref.listen<SosState>(sosNotifierProvider, (prev, next) {
      if (next.assessment != null && prev?.assessment == null) {
        context.go('/sos/coaching');
      }
    });

    return Scaffold(
      appBar: LoloAppBar(title: l10n.sos_assessmentTitle, showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LoloSpacing.spaceMd),

            // Immediate advice from activation
            if (session != null) ...[
              SOSCoachingCard(
                variant: SOSCardVariant.doThis,
                header: l10n.sos_doThisRightNow,
                content: session.immediateAdvice.doNow,
              ),
              const SizedBox(height: LoloSpacing.spaceXs),
              SOSCoachingCard(
                variant: SOSCardVariant.dontSay,
                header: l10n.sos_dontDoThis,
                content: session.immediateAdvice.doNotDo,
              ),
              const SizedBox(height: LoloSpacing.spaceXl),
            ],

            // How long ago
            Text(
              l10n.sos_howLongAgo,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _timeOptions(l10n).map((opt) {
                final isSelected = _howLongAgo == opt;
                return _SelectableChip(
                  label: opt,
                  isSelected: isSelected,
                  onTap: () => setState(() => _howLongAgo = opt),
                );
              }).toList(),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Her current state
            Text(
              l10n.sos_herCurrentState,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _stateOptions(l10n).map((opt) {
                final isSelected = _herCurrentState == opt;
                return _SelectableChip(
                  label: opt,
                  isSelected: isSelected,
                  onTap: () => setState(() => _herCurrentState = opt),
                );
              }).toList(),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Is it your fault?
            GestureDetector(
              onTap: () => setState(() => _isYourFault = !_isYourFault),
              child: Row(
                children: [
                  Checkbox(
                    value: _isYourFault,
                    onChanged: (v) =>
                        setState(() => _isYourFault = v ?? false),
                    activeColor: LoloColors.colorPrimary,
                  ),
                  Expanded(
                    child: Text(
                      l10n.sos_myFault,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceMd),

            // What happened
            Text(
              l10n.sos_brieflyWhatHappened,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            TextField(
              controller: _whatHappenedController,
              maxLines: 3,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: l10n.sos_whatHappenedHint,
                filled: true,
                fillColor: isDark
                    ? LoloColors.darkBgTertiary
                    : LoloColors.lightBgTertiary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark
                        ? LoloColors.darkBorderDefault
                        : LoloColors.lightBorderDefault,
                  ),
                ),
              ),
            ),
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

            LoloPrimaryButton(
              label: l10n.sos_startCoaching,
              icon: Icons.psychology,
              isLoading: sosState.isLoading,
              isEnabled: _canSubmit,
              onPressed: !_canSubmit
                  ? null
                  : () {
                      ref.read(sosNotifierProvider.notifier).submitAssessment(
                            SosAssessmentAnswers(
                              howLongAgo: _howLongAgo!,
                              herCurrentState: _herCurrentState!,
                              isYourFault: _isYourFault,
                              whatHappened:
                                  _whatHappenedController.text.trim(),
                            ),
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

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? LoloColors.colorPrimary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? LoloColors.colorPrimary
                : (isDark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected
                ? LoloColors.colorPrimary
                : (isDark
                    ? LoloColors.darkTextSecondary
                    : LoloColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }
}
