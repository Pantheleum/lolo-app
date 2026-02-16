import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class SosPlanScreen extends ConsumerWidget {
  const SosPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.recoveryPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimelineSection(
              icon: Icons.flash_on,
              color: LoloColors.colorError,
              title: l10n.immediate,
              items: [l10n.immediateStep1, l10n.immediateStep2, l10n.immediateStep3],
            ),
            _TimelineDivider(),
            _TimelineSection(
              icon: Icons.schedule,
              color: LoloColors.colorAccent,
              title: l10n.shortTerm,
              items: [l10n.shortTermStep1, l10n.shortTermStep2],
            ),
            _TimelineDivider(),
            _TimelineSection(
              icon: Icons.calendar_month,
              color: LoloColors.colorPrimary,
              title: l10n.longTerm,
              items: [l10n.longTermStep1, l10n.longTermStep2],
            ),
            const SizedBox(height: LoloSpacing.spaceXl),
            _OutcomeSelector(
              onSelect: (outcome, rating) {
                ref.read(sosSessionNotifierProvider.notifier)
                    .resolve(outcome, rating: rating);
                context.pop();
                context.pop();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection({
    required this.icon,
    required this.color,
    required this.title,
    required this.items,
  });
  final IconData icon;
  final Color color;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsetsDirectional.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: LoloSpacing.spaceSm),
          Text(title, style: theme.textTheme.titleMedium),
        ]),
        const SizedBox(height: LoloSpacing.spaceSm),
        ...items.map((item) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 44, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6, height: 6,
                margin: const EdgeInsetsDirectional.only(top: 6),
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(item)),
            ],
          ),
        )),
      ],
    );
  }
}

class _TimelineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20, top: 4, bottom: 4),
        child: Container(width: 2, height: 24, color: LoloColors.darkBorderMuted),
      );
}

class _OutcomeSelector extends StatefulWidget {
  const _OutcomeSelector({required this.onSelect});
  final void Function(String outcome, int rating) onSelect;
  @override
  State<_OutcomeSelector> createState() => _OutcomeSelectorState();
}

class _OutcomeSelectorState extends State<_OutcomeSelector> {
  String _outcome = 'resolved_well';
  int _rating = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.howDidItGo, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.spaceSm),
        Wrap(
          spacing: 8,
          children: ['resolved_well', 'partially_resolved', 'still_ongoing', 'got_worse']
              .map((o) => ChoiceChip(
                    label: Text(o.replaceAll('_', ' ')),
                    selected: _outcome == o,
                    onSelected: (_) => setState(() => _outcome = o),
                  ))
              .toList(),
        ),
        const SizedBox(height: LoloSpacing.spaceMd),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) => IconButton(
            icon: Icon(
              i < _rating ? Icons.star : Icons.star_border,
              color: LoloColors.colorAccent,
            ),
            onPressed: () => setState(() => _rating = i + 1),
          )),
        ),
        const SizedBox(height: LoloSpacing.spaceMd),
        LoloPrimaryButton(
          label: l10n.done,
          onPressed: () => widget.onSelect(_outcome, _rating),
          isExpanded: true,
        ),
      ],
    );
  }
}
