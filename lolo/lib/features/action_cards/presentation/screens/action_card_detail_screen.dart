import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class ActionCardDetailScreen extends ConsumerStatefulWidget {
  const ActionCardDetailScreen({required this.cardId, super.key});
  final String cardId;

  @override
  ConsumerState<ActionCardDetailScreen> createState() => _State();
}

class _State extends ConsumerState<ActionCardDetailScreen> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncCards = ref.watch(dailyCardsProvider);
    final theme = Theme.of(context);

    return asyncCards.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (summary) {
        final card = summary.cards.where((c) => c.id == widget.cardId).firstOrNull;
        if (card == null) {
          return Scaffold(
            appBar: LoloAppBar(title: l10n.actionCardsTitle),
            body: Center(child: Text(l10n.actionCard_cardNotFound)),
          );
        }

        final typeColor = switch (card.type) {
          ActionCardType.say => const Color(0xFF4A90D9),
          ActionCardType.do_ => const Color(0xFF48BB78),
          ActionCardType.buy => const Color(0xFFC9A96E),
          ActionCardType.go => const Color(0xFFED8936),
        };

        return Scaffold(
          appBar: LoloAppBar(title: card.type.name.toUpperCase()),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(LoloSpacing.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [typeColor.withValues(alpha: 0.2), Colors.transparent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.title, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: LoloSpacing.spaceXs),
                      Row(children: [
                        Icon(Icons.timer_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text('${card.estimatedMinutes} min', style: theme.textTheme.bodySmall),
                        const SizedBox(width: LoloSpacing.spaceMd),
                        const Icon(Icons.bolt, size: 16, color: LoloColors.colorAccent),
                        const SizedBox(width: 4),
                        Text('+${card.xpReward} XP', style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorAccent)),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceLg),
                Text(l10n.whatToDo, style: theme.textTheme.titleMedium),
                const SizedBox(height: LoloSpacing.spaceSm),
                Text(card.description, style: theme.textTheme.bodyLarge),
                if (card.personalizedDetail != null) ...[
                  const SizedBox(height: LoloSpacing.spaceLg),
                  Container(
                    padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                    decoration: BoxDecoration(
                      color: LoloColors.colorPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.auto_awesome, size: 18, color: LoloColors.colorPrimary),
                        const SizedBox(width: LoloSpacing.spaceSm),
                        Expanded(child: Text(card.personalizedDetail!, style: theme.textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: LoloSpacing.spaceXl),
                Text(l10n.howDidItGo, style: theme.textTheme.titleMedium),
                const SizedBox(height: LoloSpacing.spaceSm),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: l10n.optionalNotes,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceLg),
                LoloPrimaryButton(
                  label: l10n.markComplete,
                  onPressed: () {
                    ref.read(cardActionNotifierProvider.notifier)
                        .complete(widget.cardId, notes: _notesController.text);
                    Navigator.of(context).pop();
                  },
                  isExpanded: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
