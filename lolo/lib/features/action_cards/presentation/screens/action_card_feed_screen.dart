import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class ActionCardFeedScreen extends ConsumerStatefulWidget {
  const ActionCardFeedScreen({super.key});

  @override
  ConsumerState<ActionCardFeedScreen> createState() => _ActionCardFeedScreenState();
}

class _ActionCardFeedScreenState extends ConsumerState<ActionCardFeedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncCards = ref.watch(dailyCardsProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.actionCardsTitle),
      body: asyncCards.when(
        loading: () => const Center(child: LoloSkeleton.card()),
        error: (e, _) => Center(child: Text('$e')),
        data: (summary) {
          final pending = summary.cards
              .where((c) => c.status == ActionCardStatus.pending)
              .toList();
          if (pending.isEmpty) {
            return LoloEmptyState(
              icon: Icons.check_circle_outline,
              title: l10n.allCardsDone,
              subtitle: l10n.allCardsDoneSubtitle,
            );
          }
          return Column(
            children: [
              _ProgressHeader(
                completed: summary.completedToday,
                total: summary.totalCards,
                xp: summary.totalXpAvailable,
              ),
              Expanded(
                child: _SwipeableCardStack(
                  cards: pending,
                  currentIndex: _currentIndex,
                  onComplete: (card) => _handleComplete(card),
                  onSkip: (card) => _handleSkip(card),
                  onSave: (card) => _handleSave(card),
                  onTap: (card) => context.pushNamed(
                    RouteNames.actionCardDetail,
                    pathParameters: {'id': card.id},
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleComplete(ActionCardEntity card) {
    ref.read(cardActionNotifierProvider.notifier).complete(card.id);
  }

  void _handleSkip(ActionCardEntity card) {
    ref.read(cardActionNotifierProvider.notifier).skip(card.id);
  }

  void _handleSave(ActionCardEntity card) {
    ref.read(cardActionNotifierProvider.notifier).save(card.id);
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.completed,
    required this.total,
    required this.xp,
  });
  final int completed;
  final int total;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? completed / total : 0.0;
    return Padding(
      padding: const EdgeInsets.all(LoloSpacing.spaceMd),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$completed/$total',
                  style: Theme.of(context).textTheme.titleMedium),
              Row(children: [
                const Icon(Icons.bolt, color: LoloColors.colorAccent, size: 18),
                const SizedBox(width: 4),
                Text('$xp XP',
                    style: const TextStyle(color: LoloColors.colorAccent)),
              ]),
            ],
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: LoloColors.darkBorderMuted,
              valueColor:
                  const AlwaysStoppedAnimation(LoloColors.colorPrimary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeableCardStack extends StatelessWidget {
  const _SwipeableCardStack({
    required this.cards,
    required this.currentIndex,
    required this.onComplete,
    required this.onSkip,
    required this.onSave,
    required this.onTap,
  });
  final List<ActionCardEntity> cards;
  final int currentIndex;
  final ValueChanged<ActionCardEntity> onComplete;
  final ValueChanged<ActionCardEntity> onSkip;
  final ValueChanged<ActionCardEntity> onSave;
  final ValueChanged<ActionCardEntity> onTap;

  Color _typeColor(ActionCardType type) => switch (type) {
        ActionCardType.say => const Color(0xFF4A90D9),
        ActionCardType.do_ => const Color(0xFF48BB78),
        ActionCardType.buy => const Color(0xFFC9A96E),
        ActionCardType.go => const Color(0xFFED8936),
      };

  IconData _typeIcon(ActionCardType type) => switch (type) {
        ActionCardType.say => Icons.chat_bubble_outline,
        ActionCardType.do_ => Icons.favorite_outline,
        ActionCardType.buy => Icons.card_giftcard,
        ActionCardType.go => Icons.place_outlined,
      };

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LoloSpacing.spaceMd),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = (cards.length - 1).clamp(0, 2); i >= 0; i--)
            Transform.translate(
              offset: Offset(0, -i * 8.0),
              child: Transform.scale(
                scale: 1 - (i * 0.05),
                child: i == 0
                    ? Dismissible(
                        key: ValueKey(cards[i].id),
                        direction: DismissDirection.horizontal,
                        onDismissed: (dir) {
                          if (dir == DismissDirection.endToStart) {
                            onSkip(cards[i]);
                          } else {
                            onComplete(cards[i]);
                          }
                        },
                        background: _SwipeBg(
                          color: LoloColors.colorSuccess,
                          icon: Icons.check,
                          alignEnd: false,
                        ),
                        secondaryBackground: _SwipeBg(
                          color: LoloColors.colorError,
                          icon: Icons.close,
                          alignEnd: true,
                        ),
                        child: _CardContent(
                          card: cards[i],
                          typeColor: _typeColor(cards[i].type),
                          typeIcon: _typeIcon(cards[i].type),
                          onTap: () => onTap(cards[i]),
                          onSave: () => onSave(cards[i]),
                          onComplete: () => onComplete(cards[i]),
                          onSkip: () => onSkip(cards[i]),
                        ),
                      )
                    : _CardContent(
                        card: cards[i],
                        typeColor: _typeColor(cards[i].type),
                        typeIcon: _typeIcon(cards[i].type),
                        onTap: () {},
                        onSave: () {},
                        onComplete: () {},
                        onSkip: () {},
                      ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SwipeBg extends StatelessWidget {
  const _SwipeBg({required this.color, required this.icon, required this.alignEnd});
  final Color color;
  final IconData icon;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) => Container(
        alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: 32),
      );
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.card,
    required this.typeColor,
    required this.typeIcon,
    required this.onTap,
    required this.onSave,
    required this.onComplete,
    required this.onSkip,
  });
  final ActionCardEntity card;
  final Color typeColor;
  final IconData typeIcon;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final VoidCallback onComplete;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        label: '${card.type.name} card: ${card.title}',
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(LoloSpacing.spaceLg),
          decoration: BoxDecoration(
            color: LoloColors.darkBgSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: typeColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(typeIcon, color: typeColor, size: 20),
                  ),
                  const SizedBox(width: LoloSpacing.spaceSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(card.type.name.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: typeColor, letterSpacing: 1.2)),
                        Text('${card.difficulty.name} \u2022 ${card.estimatedMinutes} min',
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border, size: 20),
                    onPressed: onSave,
                    tooltip: AppLocalizations.of(context).actionCard_save,
                  ),
                ],
              ),
              const SizedBox(height: LoloSpacing.spaceMd),
              Text(card.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: LoloSpacing.spaceXs),
              Text(card.description,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              if (card.contextTags.isNotEmpty) ...[
                const SizedBox(height: LoloSpacing.spaceSm),
                Wrap(
                  spacing: 6,
                  children: card.contextTags.map((t) => Chip(
                    label: Text(t, style: const TextStyle(fontSize: 11)),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  )).toList(),
                ),
              ],
              const SizedBox(height: LoloSpacing.spaceLg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSkip,
                      icon: const Icon(Icons.close, size: 18),
                      label: Text(AppLocalizations.of(context).actionCard_skip),
                    ),
                  ),
                  const SizedBox(width: LoloSpacing.spaceSm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onComplete,
                      icon: const Icon(Icons.check, size: 18),
                      label: Text(AppLocalizations.of(context).common_button_done),
                      style: FilledButton.styleFrom(
                        backgroundColor: typeColor,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: LoloSpacing.spaceXs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt, size: 14, color: LoloColors.colorAccent),
                      const SizedBox(width: 2),
                      Text('+${card.xpReward} XP',
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: LoloColors.colorAccent)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
