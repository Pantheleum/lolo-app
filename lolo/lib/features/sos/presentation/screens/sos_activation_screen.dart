import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class SosActivationScreen extends ConsumerStatefulWidget {
  const SosActivationScreen({super.key});
  @override
  ConsumerState<SosActivationScreen> createState() => _State();
}

class _State extends ConsumerState<SosActivationScreen> {
  SosScenario? _selected;
  SosUrgency _urgency = SosUrgency.happeningNow;

  static const _scenarios = [
    (SosScenario.sheIsAngry, Icons.whatshot, 'She\'s angry'),
    (SosScenario.sheIsCrying, Icons.water_drop, 'She\'s crying'),
    (SosScenario.sheIsSilent, Icons.volume_off, 'Silent treatment'),
    (SosScenario.caughtInLie, Icons.visibility_off, 'Caught in a lie'),
    (SosScenario.forgotImportantDate, Icons.event_busy, 'Forgot a date'),
    (SosScenario.saidWrongThing, Icons.chat_bubble_outline, 'Said wrong thing'),
    (SosScenario.sheWantsToTalk, Icons.question_answer, 'She wants to talk'),
    (SosScenario.herFamilyConflict, Icons.family_restroom, 'Her family issue'),
    (SosScenario.jealousyIssue, Icons.heart_broken, 'Jealousy'),
    (SosScenario.other, Icons.more_horiz, 'Other'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sosState = ref.watch(sosSessionNotifierProvider);

    ref.listen(sosSessionNotifierProvider, (_, next) {
      next.whenOrNull(
        activated: (_) => context.pushNamed(RouteNames.sosAssessment),
        error: (msg) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg))),
      );
    });

    final isLoading = sosState is AsyncLoading ||
        sosState.whenOrNull(activating: () => true) == true;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0000),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: LoloSpacing.lg),
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LoloColors.colorError,
                  boxShadow: [
                    BoxShadow(
                      color: LoloColors.colorError.withValues(alpha: 0.4),
                      blurRadius: 24, spreadRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.sos, color: Colors.white, size: 40),
              ),
              const SizedBox(height: LoloSpacing.md),
              Text(l10n.sosTitle, style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              )),
              const SizedBox(height: LoloSpacing.xs),
              Text(l10n.sosSubtitle, style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              )),
              const SizedBox(height: LoloSpacing.lg),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: LoloSpacing.sm,
                  crossAxisSpacing: LoloSpacing.sm,
                  childAspectRatio: 2.2,
                  children: _scenarios.map((s) => _ScenarioChip(
                    scenario: s.$1,
                    icon: s.$2,
                    label: s.$3,
                    selected: _selected == s.$1,
                    onTap: () => setState(() => _selected = s.$1),
                  )).toList(),
                ),
              ),
              const SizedBox(height: LoloSpacing.md),
              SegmentedButton<SosUrgency>(
                segments: const [
                  ButtonSegment(value: SosUrgency.happeningNow, label: Text('NOW')),
                  ButtonSegment(value: SosUrgency.justHappened, label: Text('Just now')),
                  ButtonSegment(value: SosUrgency.brewing, label: Text('Brewing')),
                ],
                selected: {_urgency},
                onSelectionChanged: (v) => setState(() => _urgency = v.first),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
              ),
              const SizedBox(height: LoloSpacing.lg),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _selected == null || isLoading
                      ? null
                      : () => ref.read(sosSessionNotifierProvider.notifier).activate(
                            scenario: _selected!.name,
                            urgency: _urgency.name,
                          ),
                  style: FilledButton.styleFrom(
                    backgroundColor: LoloColors.colorError,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24, height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.getHelp, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScenarioChip extends StatelessWidget {
  const _ScenarioChip({
    required this.scenario,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final SosScenario scenario;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        label: label,
        selected: selected,
        child: Material(
          color: selected
              ? LoloColors.colorError.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: selected ? LoloColors.colorError : Colors.white54),
                  const SizedBox(width: 8),
                  Expanded(child: Text(label,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.white70,
                        fontSize: 13,
                      ))),
                ],
              ),
            ),
          ),
        ),
      );
}
