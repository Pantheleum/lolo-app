import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class SosCoachingScreen extends ConsumerStatefulWidget {
  const SosCoachingScreen({super.key});
  @override
  ConsumerState<SosCoachingScreen> createState() => _State();
}

class _State extends ConsumerState<SosCoachingScreen> {
  int _currentStep = 1;
  final _updateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sosSessionNotifierProvider.notifier).getCoaching(_currentStep);
    });
  }

  @override
  void dispose() {
    _updateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sosState = ref.watch(sosSessionNotifierProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.coaching),
      body: sosState.maybeWhen(
        coaching: (session, step) => _buildCoachingContent(theme, l10n, step),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildCoachingContent(ThemeData theme, AppLocalizations l10n, CoachingStep step) =>
      SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Step ${step.stepNumber}/${step.totalSteps}',
                    style: theme.textTheme.titleMedium),
                const Spacer(),
                if (!step.isLastStep)
                  Text(l10n.stepProgress,
                      style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: LoloSpacing.lg),
            // SAY THIS - green card
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFF48BB78).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF48BB78).withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.chat, color: Color(0xFF48BB78), size: 20),
                    const SizedBox(width: 8),
                    Text(l10n.sayThis, style: theme.textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF48BB78),
                    )),
                  ]),
                  const SizedBox(height: LoloSpacing.sm),
                  Text(step.sayThis, style: theme.textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                  )),
                  if (step.whyItWorks.isNotEmpty) ...[
                    const SizedBox(height: LoloSpacing.sm),
                    Text(step.whyItWorks, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
            const SizedBox(height: LoloSpacing.md),
            // DON'T SAY - red card
            if (step.doNotSay.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
                decoration: BoxDecoration(
                  color: LoloColors.colorError.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: LoloColors.colorError.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.block, color: LoloColors.colorError, size: 20),
                      const SizedBox(width: 8),
                      Text(l10n.dontSay, style: theme.textTheme.titleSmall?.copyWith(
                        color: LoloColors.colorError,
                      )),
                    ]),
                    const SizedBox(height: LoloSpacing.sm),
                    ...step.doNotSay.map((s) => Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022 ', style: TextStyle(color: LoloColors.colorError)),
                          Expanded(child: Text(s)),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            const SizedBox(height: LoloSpacing.md),
            // Body language tip
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
              decoration: BoxDecoration(
                color: LoloColors.colorPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.accessibility_new, color: LoloColors.colorPrimary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(step.bodyLanguageTip, style: theme.textTheme.bodyMedium)),
                ],
              ),
            ),
            const SizedBox(height: LoloSpacing.xl),
            if (!step.isLastStep) ...[
              if (step.nextStepPrompt != null)
                Text(step.nextStepPrompt!, style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                )),
              const SizedBox(height: LoloSpacing.sm),
              TextField(
                controller: _updateController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: l10n.whatHappened,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: LoloSpacing.md),
              LoloPrimaryButton(
                label: l10n.nextStep,
                onPressed: () {
                  setState(() => _currentStep++);
                  ref.read(sosSessionNotifierProvider.notifier)
                      .getCoaching(_currentStep, userUpdate: _updateController.text);
                  _updateController.clear();
                },
                isExpanded: true,
              ),
            ] else ...[
              LoloPrimaryButton(
                label: l10n.viewRecoveryPlan,
                onPressed: () => context.pushNamed(RouteNames.sosPlan),
                isExpanded: true,
              ),
            ],
          ],
        ),
      );
}
