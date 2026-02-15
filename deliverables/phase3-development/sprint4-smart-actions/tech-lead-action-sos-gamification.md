# LOLO Sprint 4 -- Action Cards, SOS Mode, Gamification & Paywall UI

**Task ID:** S4-01
**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 15, 2026
**Sprint:** Sprint 4 -- Smart Actions (Weeks 15-16)
**Dependencies:** S1-01, S1-02, S2-01, S3-01, API Contracts v1.0

---

## Module 7: Smart Action Cards (Screens 26-27)

### 7.1 Domain Layer

#### `lib/features/action_cards/domain/entities/action_card_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_card_entity.freezed.dart';

enum ActionCardType { say, do_, buy, go }

enum ActionCardDifficulty { easy, medium, challenging }

enum ActionCardStatus { pending, completed, skipped, saved }

@freezed
class ActionCardEntity with _$ActionCardEntity {
  const factory ActionCardEntity({
    required String id,
    required ActionCardType type,
    required String title,
    required String description,
    required ActionCardDifficulty difficulty,
    required int estimatedMinutes,
    required int xpReward,
    required ActionCardStatus status,
    @Default([]) List<String> contextTags,
    String? personalizedDetail,
    DateTime? expiresAt,
    DateTime? completedAt,
  }) = _ActionCardEntity;
}

@freezed
class DailyCardsSummary with _$DailyCardsSummary {
  const factory DailyCardsSummary({
    required List<ActionCardEntity> cards,
    required int totalCards,
    required int completedToday,
    required int totalXpAvailable,
  }) = _DailyCardsSummary;
}
```

### 7.2 Data Layer

#### `lib/features/action_cards/data/repositories/action_card_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'action_card_repository.g.dart';

abstract class ActionCardRepository {
  Future<Either<Failure, DailyCardsSummary>> getDailyCards({String? date});
  Future<Either<Failure, ActionCardEntity>> completeCard(String id, {String? notes});
  Future<Either<Failure, ActionCardEntity>> skipCard(String id, {String? reason});
  Future<Either<Failure, void>> saveCard(String id);
  Future<Either<Failure, List<ActionCardEntity>>> getSavedCards();
  Future<Either<Failure, List<ActionCardEntity>>> getHistory({String? status, int limit = 20});
}

@riverpod
ActionCardRepository actionCardRepository(ActionCardRepositoryRef ref) =>
    ActionCardRepositoryImpl(ref.watch(dioClientProvider));

class ActionCardRepositoryImpl implements ActionCardRepository {
  ActionCardRepositoryImpl(this._dio);
  final DioClient _dio;

  @override
  Future<Either<Failure, DailyCardsSummary>> getDailyCards({String? date}) async {
    try {
      final query = date != null ? {'date': date} : null;
      final res = await _dio.get('/action-cards', queryParameters: query);
      final data = res.data['data'] as Map<String, dynamic>;
      final cards = (data['cards'] as List).map((c) => _mapCard(c)).toList();
      final summary = data['summary'] as Map<String, dynamic>;
      return Right(DailyCardsSummary(
        cards: cards,
        totalCards: summary['totalCards'] as int,
        completedToday: summary['completedToday'] as int,
        totalXpAvailable: summary['totalXpAvailable'] as int,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionCardEntity>> completeCard(String id, {String? notes}) async {
    try {
      final res = await _dio.post('/action-cards/$id/complete', data: {'notes': notes});
      return Right(_mapCard(res.data['data']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionCardEntity>> skipCard(String id, {String? reason}) async {
    try {
      final res = await _dio.post('/action-cards/$id/skip', data: {'reason': reason});
      return Right(_mapCard(res.data['data']));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCard(String id) async {
    try {
      await _dio.post('/action-cards/$id/save');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActionCardEntity>>> getSavedCards() async {
    try {
      final res = await _dio.get('/action-cards/saved');
      final list = (res.data['data'] as List).map((c) => _mapCard(c)).toList();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActionCardEntity>>> getHistory({
    String? status,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get('/action-cards/history', queryParameters: {
        if (status != null) 'status': status,
        'limit': limit,
      });
      final list = (res.data['data'] as List).map((c) => _mapCard(c)).toList();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  ActionCardEntity _mapCard(Map<String, dynamic> m) => ActionCardEntity(
        id: m['id'] as String,
        type: ActionCardType.values.firstWhere(
          (t) => t.name == (m['type'] as String).replaceAll('do', 'do_'),
          orElse: () => ActionCardType.say,
        ),
        title: m['titleLocalized'] as String? ?? m['title'] as String,
        description: m['descriptionLocalized'] as String? ?? m['description'] as String,
        difficulty: ActionCardDifficulty.values.firstWhere(
          (d) => d.name == m['difficulty'],
          orElse: () => ActionCardDifficulty.easy,
        ),
        estimatedMinutes: int.tryParse('${m['estimatedTime']}'.replaceAll(RegExp(r'[^0-9]'), '')) ?? 5,
        xpReward: m['xpReward'] as int? ?? 0,
        status: ActionCardStatus.values.firstWhere(
          (s) => s.name == m['status'],
          orElse: () => ActionCardStatus.pending,
        ),
        contextTags: (m['contextTags'] as List?)?.cast<String>() ?? [],
        personalizedDetail: m['personalizedDetail'] as String?,
      );
}
```

### 7.3 Presentation -- Providers

#### `lib/features/action_cards/presentation/providers/action_card_providers.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';

part 'action_card_providers.g.dart';

@riverpod
Future<DailyCardsSummary> dailyCards(DailyCardsRef ref) async {
  final repo = ref.watch(actionCardRepositoryProvider);
  final result = await repo.getDailyCards();
  return result.fold((f) => throw Exception(f.message), (s) => s);
}

@riverpod
Future<List<ActionCardEntity>> cardHistory(CardHistoryRef ref) async {
  final repo = ref.watch(actionCardRepositoryProvider);
  final result = await repo.getHistory();
  return result.fold((f) => throw Exception(f.message), (l) => l);
}

@riverpod
class CardActionNotifier extends _$CardActionNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> complete(String id, {String? notes}) async {
    state = const AsyncLoading();
    final repo = ref.read(actionCardRepositoryProvider);
    final result = await repo.completeCard(id, notes: notes);
    state = result.fold(
      (f) => AsyncError(f.message, StackTrace.current),
      (_) {
        ref.invalidate(dailyCardsProvider);
        ref.invalidate(cardHistoryProvider);
        return const AsyncData(null);
      },
    );
  }

  Future<void> skip(String id, {String? reason}) async {
    state = const AsyncLoading();
    final repo = ref.read(actionCardRepositoryProvider);
    final result = await repo.skipCard(id, reason: reason);
    state = result.fold(
      (f) => AsyncError(f.message, StackTrace.current),
      (_) {
        ref.invalidate(dailyCardsProvider);
        return const AsyncData(null);
      },
    );
  }

  Future<void> save(String id) async {
    final repo = ref.read(actionCardRepositoryProvider);
    await repo.saveCard(id);
    ref.invalidate(dailyCardsProvider);
  }
}
```

### 7.4 Screen 26: Action Card Feed

#### `lib/features/action_cards/presentation/screens/action_card_feed_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
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
        loading: () => const Center(child: LoloSkeleton(type: SkeletonType.card)),
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
      padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
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
                    style: TextStyle(color: LoloColors.colorAccent)),
              ]),
            ],
          ),
          const SizedBox(height: LoloSpacing.xs),
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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: LoloSpacing.md),
      child: Stack(
        alignment: AlignmentDirectional.center,
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
        alignment: alignEnd
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
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
          padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
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
                    padding: const EdgeInsetsDirectional.all(8),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(typeIcon, color: typeColor, size: 20),
                  ),
                  const SizedBox(width: LoloSpacing.sm),
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
                    tooltip: 'Save',
                  ),
                ],
              ),
              const SizedBox(height: LoloSpacing.md),
              Text(card.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: LoloSpacing.xs),
              Text(card.description,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              if (card.contextTags.isNotEmpty) ...[
                const SizedBox(height: LoloSpacing.sm),
                Wrap(
                  spacing: 6,
                  children: card.contextTags.map((t) => Chip(
                    label: Text(t, style: const TextStyle(fontSize: 11)),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  )).toList(),
                ),
              ],
              const SizedBox(height: LoloSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onSkip,
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: LoloSpacing.sm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onComplete,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Done'),
                      style: FilledButton.styleFrom(
                        backgroundColor: typeColor,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: LoloSpacing.xs),
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
```

### 7.5 Screen 27: Action Card Detail

#### `lib/features/action_cards/presentation/screens/action_card_detail_screen.dart`

```dart
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
            body: const Center(child: Text('Card not found')),
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
            padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [typeColor.withValues(alpha: 0.2), Colors.transparent],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.title, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: LoloSpacing.xs),
                      Row(children: [
                        Icon(Icons.timer_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text('${card.estimatedMinutes} min', style: theme.textTheme.bodySmall),
                        const SizedBox(width: LoloSpacing.md),
                        Icon(Icons.bolt, size: 16, color: LoloColors.colorAccent),
                        const SizedBox(width: 4),
                        Text('+${card.xpReward} XP', style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorAccent)),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: LoloSpacing.lg),
                Text(l10n.whatToDo, style: theme.textTheme.titleMedium),
                const SizedBox(height: LoloSpacing.sm),
                Text(card.description, style: theme.textTheme.bodyLarge),
                if (card.personalizedDetail != null) ...[
                  const SizedBox(height: LoloSpacing.lg),
                  Container(
                    padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
                    decoration: BoxDecoration(
                      color: LoloColors.colorPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.auto_awesome, size: 18, color: LoloColors.colorPrimary),
                        const SizedBox(width: LoloSpacing.sm),
                        Expanded(child: Text(card.personalizedDetail!, style: theme.textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: LoloSpacing.xl),
                Text(l10n.howDidItGo, style: theme.textTheme.titleMedium),
                const SizedBox(height: LoloSpacing.sm),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: l10n.optionalNotes,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: LoloSpacing.lg),
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
```

---

## Module 8: SOS Mode (Screens 28-31)

### 8.1 Domain Entities

#### `lib/features/sos/domain/entities/sos_session.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_session.freezed.dart';

enum SosScenario {
  sheIsAngry, sheIsCrying, sheIsSilent, caughtInLie,
  forgotImportantDate, saidWrongThing, sheWantsToTalk,
  herFamilyConflict, jealousyIssue, other
}

enum SosUrgency { happeningNow, justHappened, brewing }

@freezed
class SosSession with _$SosSession {
  const factory SosSession({
    required String sessionId,
    required SosScenario scenario,
    required SosUrgency urgency,
    required SosImmediateAdvice immediateAdvice,
    required bool severityAssessmentRequired,
    required int estimatedResolutionSteps,
    required DateTime createdAt,
  }) = _SosSession;
}

@freezed
class SosImmediateAdvice with _$SosImmediateAdvice {
  const factory SosImmediateAdvice({
    required String doNow,
    required String doNotDo,
    required String bodyLanguage,
  }) = _SosImmediateAdvice;
}
```

#### `lib/features/sos/domain/entities/sos_assessment.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_assessment.freezed.dart';

@freezed
class SosAssessment with _$SosAssessment {
  const factory SosAssessment({
    required String sessionId,
    required int severityScore,
    required String severityLabel,
    required SosCoachingPlan coachingPlan,
  }) = _SosAssessment;
}

@freezed
class SosCoachingPlan with _$SosCoachingPlan {
  const factory SosCoachingPlan({
    required int totalSteps,
    required int estimatedMinutes,
    required String approach,
    required String keyInsight,
  }) = _SosCoachingPlan;
}
```

#### `lib/features/sos/domain/entities/coaching_step.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coaching_step.freezed.dart';

@freezed
class CoachingStep with _$CoachingStep {
  const factory CoachingStep({
    required String sessionId,
    required int stepNumber,
    required int totalSteps,
    required String sayThis,
    required String whyItWorks,
    required List<String> doNotSay,
    required String bodyLanguageTip,
    required String toneAdvice,
    String? waitFor,
    required bool isLastStep,
    String? nextStepPrompt,
  }) = _CoachingStep;
}
```

### 8.2 Data Layer

#### `lib/features/sos/data/repositories/sos_repository.dart`

```dart
import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sos_repository.g.dart';

abstract class SosRepository {
  Future<Either<Failure, SosSession>> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  });
  Future<Either<Failure, SosAssessment>> assess({
    required String sessionId,
    required Map<String, dynamic> answers,
  });
  Stream<CoachingStep> coachStream({
    required String sessionId,
    required int stepNumber,
    String? userUpdate,
  });
  Future<Either<Failure, void>> resolve({
    required String sessionId,
    required String outcome,
    int? rating,
  });
}

@riverpod
SosRepository sosRepository(SosRepositoryRef ref) =>
    SosRepositoryImpl(ref.watch(dioClientProvider));

class SosRepositoryImpl implements SosRepository {
  SosRepositoryImpl(this._dio);
  final DioClient _dio;

  @override
  Future<Either<Failure, SosSession>> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  }) async {
    try {
      final res = await _dio.post('/sos/activate', data: {
        'scenario': scenario,
        'urgency': urgency,
        if (briefContext != null) 'briefContext': briefContext,
      });
      final d = res.data['data'] as Map<String, dynamic>;
      final adv = d['immediateAdvice'] as Map<String, dynamic>;
      return Right(SosSession(
        sessionId: d['sessionId'] as String,
        scenario: SosScenario.values.firstWhere(
          (s) => s.name == _camelCase(d['scenario'] as String),
          orElse: () => SosScenario.other,
        ),
        urgency: SosUrgency.values.firstWhere(
          (u) => u.name == _camelCase(d['urgency'] as String),
          orElse: () => SosUrgency.happeningNow,
        ),
        immediateAdvice: SosImmediateAdvice(
          doNow: adv['doNow'] as String,
          doNotDo: adv['doNotDo'] as String,
          bodyLanguage: adv['bodyLanguage'] as String,
        ),
        severityAssessmentRequired: d['severityAssessmentRequired'] as bool,
        estimatedResolutionSteps: d['estimatedResolutionSteps'] as int,
        createdAt: DateTime.parse(d['createdAt'] as String),
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SosAssessment>> assess({
    required String sessionId,
    required Map<String, dynamic> answers,
  }) async {
    try {
      final res = await _dio.post('/sos/assess', data: {
        'sessionId': sessionId,
        'answers': answers,
      });
      final d = res.data['data'] as Map<String, dynamic>;
      final plan = d['coachingPlan'] as Map<String, dynamic>;
      return Right(SosAssessment(
        sessionId: d['sessionId'] as String,
        severityScore: d['severityScore'] as int,
        severityLabel: d['severityLabel'] as String,
        coachingPlan: SosCoachingPlan(
          totalSteps: plan['totalSteps'] as int,
          estimatedMinutes: plan['estimatedMinutes'] as int,
          approach: plan['approach'] as String,
          keyInsight: plan['keyInsight'] as String,
        ),
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<CoachingStep> coachStream({
    required String sessionId,
    required int stepNumber,
    String? userUpdate,
  }) async* {
    final res = await _dio.post(
      '/sos/coach',
      data: {
        'sessionId': sessionId,
        'stepNumber': stepNumber,
        'stream': true,
        if (userUpdate != null) 'userUpdate': userUpdate,
      },
      options: Options(
        headers: {'Accept': 'text/event-stream'},
        responseType: ResponseType.stream,
      ),
    );

    String sayThis = '';
    String bodyLang = '';
    List<String> doNotSay = [];
    bool isLast = false;
    String? nextPrompt;
    int totalSteps = stepNumber;

    await for (final chunk in (res.data as ResponseBody).stream) {
      final lines = utf8.decode(chunk).split('\n');
      for (final line in lines) {
        if (line.startsWith('data: ')) {
          final json = jsonDecode(line.substring(6)) as Map<String, dynamic>;
          if (json.containsKey('text')) sayThis += json['text'] as String;
          if (json.containsKey('phrases')) {
            doNotSay = (json['phrases'] as List).cast<String>();
          }
          if (json.containsKey('isLastStep')) {
            isLast = json['isLastStep'] as bool;
            nextPrompt = json['nextStepPrompt'] as String?;
          }
        }
      }
    }

    yield CoachingStep(
      sessionId: sessionId,
      stepNumber: stepNumber,
      totalSteps: totalSteps,
      sayThis: sayThis,
      whyItWorks: '',
      doNotSay: doNotSay,
      bodyLanguageTip: bodyLang,
      toneAdvice: 'calm',
      isLastStep: isLast,
      nextStepPrompt: nextPrompt,
    );
  }

  @override
  Future<Either<Failure, void>> resolve({
    required String sessionId,
    required String outcome,
    int? rating,
  }) async {
    try {
      await _dio.post('/sos/resolve', data: {
        'sessionId': sessionId,
        'outcome': outcome,
        if (rating != null) 'rating': rating,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _camelCase(String s) {
    final parts = s.split('_');
    return parts.first +
        parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
  }
}
```

### 8.3 Providers

#### `lib/features/sos/presentation/providers/sos_providers.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/sos/data/repositories/sos_repository.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';

part 'sos_providers.g.dart';
part 'sos_providers.freezed.dart';

@freezed
class SosFlowState with _$SosFlowState {
  const factory SosFlowState.idle() = _Idle;
  const factory SosFlowState.activating() = _Activating;
  const factory SosFlowState.activated(SosSession session) = _Activated;
  const factory SosFlowState.assessed(SosSession session, SosAssessment assessment) = _Assessed;
  const factory SosFlowState.coaching(SosSession session, CoachingStep step) = _Coaching;
  const factory SosFlowState.resolved() = _Resolved;
  const factory SosFlowState.error(String message) = _Error;
}

@riverpod
class SosSessionNotifier extends _$SosSessionNotifier {
  @override
  SosFlowState build() => const SosFlowState.idle();

  Future<void> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  }) async {
    state = const SosFlowState.activating();
    final repo = ref.read(sosRepositoryProvider);
    final result = await repo.activate(
      scenario: scenario,
      urgency: urgency,
      briefContext: briefContext,
    );
    state = result.fold(
      (f) => SosFlowState.error(f.message),
      (session) => SosFlowState.activated(session),
    );
  }

  Future<void> assess(Map<String, dynamic> answers) async {
    final current = state;
    if (current is! _Activated) return;
    final repo = ref.read(sosRepositoryProvider);
    final result = await repo.assess(
      sessionId: current.session.sessionId,
      answers: answers,
    );
    state = result.fold(
      (f) => SosFlowState.error(f.message),
      (assessment) => SosFlowState.assessed(current.session, assessment),
    );
  }

  Future<void> getCoaching(int stepNumber, {String? userUpdate}) async {
    SosSession? session;
    state.whenOrNull(
      activated: (s) => session = s,
      assessed: (s, _) => session = s,
      coaching: (s, _) => session = s,
    );
    if (session == null) return;

    final repo = ref.read(sosRepositoryProvider);
    await for (final step in repo.coachStream(
      sessionId: session!.sessionId,
      stepNumber: stepNumber,
      userUpdate: userUpdate,
    )) {
      state = SosFlowState.coaching(session!, step);
    }
  }

  Future<void> resolve(String outcome, {int? rating}) async {
    String? sessionId;
    state.whenOrNull(
      activated: (s) => sessionId = s.sessionId,
      assessed: (s, _) => sessionId = s.sessionId,
      coaching: (s, _) => sessionId = s.sessionId,
    );
    if (sessionId == null) return;
    final repo = ref.read(sosRepositoryProvider);
    await repo.resolve(sessionId: sessionId!, outcome: outcome, rating: rating);
    state = const SosFlowState.resolved();
  }
}
```

### 8.4 Screen 28: SOS Activation

#### `lib/features/sos/presentation/screens/sos_activation_screen.dart`

```dart
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
```

### 8.5 Screen 29: SOS Assessment

#### `lib/features/sos/presentation/screens/sos_assessment_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class SosAssessmentScreen extends ConsumerStatefulWidget {
  const SosAssessmentScreen({super.key});
  @override
  ConsumerState<SosAssessmentScreen> createState() => _State();
}

class _State extends ConsumerState<SosAssessmentScreen> {
  int _step = 0;
  final _answers = <String, dynamic>{};

  static const _questions = [
    ('howLongAgo', 'How long ago did this happen?', ['minutes', 'hours', 'today', 'yesterday']),
    ('herCurrentState', 'How is she right now?', ['calm', 'upset', 'very_upset', 'crying', 'furious', 'silent']),
    ('haveYouSpoken', 'Have you spoken to her?', ['yes', 'no']),
    ('isSheTalking', 'Is she talking to you?', ['yes', 'no']),
    ('yourFault', 'Is it your fault?', ['yes', 'no', 'partially', 'unsure']),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    ref.listen(sosSessionNotifierProvider, (_, next) {
      next.whenOrNull(
        assessed: (_, __) => context.pushNamed(RouteNames.sosCoaching),
      );
    });

    final q = _questions[_step];

    return Scaffold(
      appBar: LoloAppBar(title: l10n.assessment),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_step + 1) / _questions.length,
              backgroundColor: LoloColors.darkBorderMuted,
              valueColor: const AlwaysStoppedAnimation(LoloColors.colorError),
            ),
            const SizedBox(height: LoloSpacing.xl),
            Text('${_step + 1}/${_questions.length}',
                style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorError)),
            const SizedBox(height: LoloSpacing.sm),
            Text(q.$2, style: theme.textTheme.headlineSmall),
            const SizedBox(height: LoloSpacing.lg),
            Expanded(
              child: ListView.separated(
                itemCount: q.$3.length,
                separatorBuilder: (_, __) => const SizedBox(height: LoloSpacing.sm),
                itemBuilder: (_, i) {
                  final opt = q.$3[i];
                  final isSelected = _answers[q.$1]?.toString() == opt;
                  return Semantics(
                    label: opt.replaceAll('_', ' '),
                    selected: isSelected,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? LoloColors.colorError
                              : LoloColors.darkBorderMuted,
                        ),
                      ),
                      tileColor: isSelected
                          ? LoloColors.colorError.withValues(alpha: 0.1)
                          : null,
                      title: Text(opt.replaceAll('_', ' ').toUpperCase(),
                          style: const TextStyle(fontSize: 14)),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: LoloColors.colorError)
                          : null,
                      onTap: () {
                        setState(() {
                          if (q.$1 == 'haveYouSpoken' || q.$1 == 'isSheTalking') {
                            _answers[q.$1] = opt == 'yes';
                          } else {
                            _answers[q.$1] = opt;
                          }
                        });
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (_step < _questions.length - 1) {
                            setState(() => _step++);
                          } else {
                            ref.read(sosSessionNotifierProvider.notifier).assess(_answers);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (_step > 0)
              TextButton.icon(
                onPressed: () => setState(() => _step--),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: Text(l10n.back),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 8.6 Screen 30: SOS Coaching

#### `lib/features/sos/presentation/screens/sos_coaching_screen.dart`

```dart
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
```

### 8.7 Screen 31: SOS Recovery Plan

#### `lib/features/sos/presentation/screens/sos_plan_screen.dart`

```dart
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
    final theme = Theme.of(context);
    final sosState = ref.watch(sosSessionNotifierProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.recoveryPlan),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
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
            const SizedBox(height: LoloSpacing.xl),
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
          const SizedBox(width: LoloSpacing.sm),
          Text(title, style: theme.textTheme.titleMedium),
        ]),
        const SizedBox(height: LoloSpacing.sm),
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
        const SizedBox(height: LoloSpacing.sm),
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
        const SizedBox(height: LoloSpacing.md),
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
        const SizedBox(height: LoloSpacing.md),
        LoloPrimaryButton(
          label: l10n.done,
          onPressed: () => widget.onSelect(_outcome, _rating),
          isExpanded: true,
        ),
      ],
    );
  }
}
```

---

## Module 9: Gamification (Screen 32)

### 9.1 Domain Entities

#### `lib/features/gamification/domain/entities/gamification_profile.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamification_profile.freezed.dart';

@freezed
class GamificationProfile with _$GamificationProfile {
  const factory GamificationProfile({
    required int currentLevel,
    required String levelName,
    required int xpCurrent,
    required int xpForNextLevel,
    required double xpProgress,
    required int totalXpEarned,
    required int currentStreak,
    required int longestStreak,
    required int freezesAvailable,
    required int consistencyScore,
    required String consistencyLabel,
    required List<WeeklyXp> weeklyXp,
  }) = _GamificationProfile;
}

@freezed
class WeeklyXp with _$WeeklyXp {
  const factory WeeklyXp({
    required String day,
    required int xp,
  }) = _WeeklyXp;
}
```

#### `lib/features/gamification/domain/entities/badge_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_entity.freezed.dart';

@freezed
class BadgeEntity with _$BadgeEntity {
  const factory BadgeEntity({
    required String id,
    required String name,
    required String icon,
    required String description,
    required String category,
    required String rarity,
    DateTime? earnedAt,
    double? progress,
    String? progressDescription,
  }) = _BadgeEntity;

  const BadgeEntity._();
  bool get isEarned => earnedAt != null;
}
```

#### `lib/features/gamification/domain/entities/streak_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_entity.freezed.dart';

@freezed
class StreakEntity with _$StreakEntity {
  const factory StreakEntity({
    required int currentStreak,
    required int longestStreak,
    required bool isActiveToday,
    required int freezesAvailable,
    required int freezesUsedThisMonth,
    required List<StreakMilestone> milestones,
  }) = _StreakEntity;
}

@freezed
class StreakMilestone with _$StreakMilestone {
  const factory StreakMilestone({
    required int days,
    required bool reached,
    DateTime? reachedAt,
  }) = _StreakMilestone;
}
```

### 9.2 Data Layer

#### `lib/features/gamification/data/repositories/gamification_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/domain/entities/streak_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gamification_repository.g.dart';

abstract class GamificationRepository {
  Future<Either<Failure, GamificationProfile>> getProfile();
  Future<Either<Failure, ({List<BadgeEntity> earned, List<BadgeEntity> unearned})>> getBadges();
  Future<Either<Failure, StreakEntity>> getStreak();
}

@riverpod
GamificationRepository gamificationRepository(GamificationRepositoryRef ref) =>
    GamificationRepositoryImpl(ref.watch(dioClientProvider));

class GamificationRepositoryImpl implements GamificationRepository {
  GamificationRepositoryImpl(this._dio);
  final DioClient _dio;

  @override
  Future<Either<Failure, GamificationProfile>> getProfile() async {
    try {
      final res = await _dio.get('/gamification/profile');
      final d = res.data['data'] as Map<String, dynamic>;
      final level = d['level'] as Map<String, dynamic>;
      final streak = d['streak'] as Map<String, dynamic>;
      final cs = d['consistencyScore'] as Map<String, dynamic>;
      final weekly = (d['weeklyXp'] as List)
          .map((w) => WeeklyXp(day: w['day'] as String, xp: w['xp'] as int))
          .toList();
      return Right(GamificationProfile(
        currentLevel: level['current'] as int,
        levelName: level['name'] as String,
        xpCurrent: level['xpCurrent'] as int,
        xpForNextLevel: level['xpForNextLevel'] as int,
        xpProgress: (level['xpProgress'] as num).toDouble(),
        totalXpEarned: level['totalXpEarned'] as int,
        currentStreak: streak['currentDays'] as int,
        longestStreak: streak['longestDays'] as int,
        freezesAvailable: streak['freezesAvailable'] as int,
        consistencyScore: cs['score'] as int,
        consistencyLabel: cs['label'] as String,
        weeklyXp: weekly,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ({List<BadgeEntity> earned, List<BadgeEntity> unearned})>> getBadges() async {
    try {
      final res = await _dio.get('/gamification/badges');
      final d = res.data['data'] as Map<String, dynamic>;
      final earned = (d['earned'] as List).map((b) => _mapBadge(b)).toList();
      final unearned = (d['unearned'] as List).map((b) => _mapBadge(b)).toList();
      return Right((earned: earned, unearned: unearned));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreakEntity>> getStreak() async {
    try {
      final res = await _dio.get('/gamification/streak');
      final d = res.data['data'] as Map<String, dynamic>;
      final f = d['freezes'] as Map<String, dynamic>;
      final milestones = (d['milestones'] as List).map((m) => StreakMilestone(
        days: m['days'] as int,
        reached: m['reached'] as bool,
        reachedAt: m['reachedAt'] != null ? DateTime.parse(m['reachedAt'] as String) : null,
      )).toList();
      return Right(StreakEntity(
        currentStreak: d['currentStreak'] as int,
        longestStreak: d['longestStreak'] as int,
        isActiveToday: d['isActiveToday'] as bool,
        freezesAvailable: f['available'] as int,
        freezesUsedThisMonth: f['usedThisMonth'] as int,
        milestones: milestones,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  BadgeEntity _mapBadge(Map<String, dynamic> m) => BadgeEntity(
        id: m['id'] as String,
        name: m['nameLocalized'] as String? ?? m['name'] as String,
        icon: m['icon'] as String,
        description: m['descriptionLocalized'] as String? ?? m['description'] as String,
        category: m['category'] as String,
        rarity: m['rarity'] as String,
        earnedAt: m['earnedAt'] != null ? DateTime.parse(m['earnedAt'] as String) : null,
        progress: (m['progress'] as num?)?.toDouble(),
        progressDescription: m['progressDescription'] as String?,
      );
}
```

### 9.3 Providers

#### `lib/features/gamification/presentation/providers/gamification_providers.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/domain/entities/streak_entity.dart';

part 'gamification_providers.g.dart';

@riverpod
Future<GamificationProfile> gamificationProfile(GamificationProfileRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getProfile();
  return result.fold((f) => throw Exception(f.message), (p) => p);
}

@riverpod
Future<({List<BadgeEntity> earned, List<BadgeEntity> unearned})> badges(BadgesRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getBadges();
  return result.fold((f) => throw Exception(f.message), (b) => b);
}

@riverpod
Future<StreakEntity> streak(StreakRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getStreak();
  return result.fold((f) => throw Exception(f.message), (s) => s);
}
```

### 9.4 Screen 32: Gamification Hub

#### `lib/features/gamification/presentation/screens/gamification_hub_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class GamificationHubScreen extends ConsumerWidget {
  const GamificationHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncProfile = ref.watch(gamificationProfileProvider);
    final asyncBadges = ref.watch(badgesProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.gamification),
      body: asyncProfile.when(
        loading: () => const Center(child: LoloSkeleton(type: SkeletonType.card)),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LevelCard(profile: profile),
              const SizedBox(height: LoloSpacing.lg),
              _StreakCard(profile: profile),
              const SizedBox(height: LoloSpacing.lg),
              _XpChart(weeklyXp: profile.weeklyXp),
              const SizedBox(height: LoloSpacing.lg),
              asyncBadges.when(
                loading: () => const LoloSkeleton(type: SkeletonType.list),
                error: (e, _) => Text('$e'),
                data: (b) => _BadgeGrid(earned: b.earned, unearned: b.unearned),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.profile});
  final GamificationProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90D9), Color(0xFF2D5A8E)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                alignment: Alignment.center,
                child: Text('${profile.currentLevel}',
                    style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
              ),
              const SizedBox(width: LoloSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.levelName,
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                    Text('${profile.totalXpEarned} XP total',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: LoloSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: profile.xpProgress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(LoloColors.colorAccent),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: LoloSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${profile.xpCurrent} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text('${profile.xpForNextLevel} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.profile});
  final GamificationProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
      decoration: BoxDecoration(
        color: LoloColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text('\uD83D\uDD25', style: TextStyle(fontSize: 32)),
          const SizedBox(width: LoloSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${profile.currentStreak} day streak',
                    style: theme.textTheme.titleMedium),
                Text('Best: ${profile.longestStreak} days',
                    style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.ac_unit, color: LoloColors.colorPrimary, size: 20),
              Text('${profile.freezesAvailable}',
                  style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _XpChart extends StatelessWidget {
  const _XpChart({required this.weeklyXp});
  final List<WeeklyXp> weeklyXp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxXp = weeklyXp.fold<int>(1, (m, w) => w.xp > m ? w.xp : m);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Activity', style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.md),
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeklyXp.map((w) => Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${w.xp}', style: const TextStyle(fontSize: 10)),
                    const SizedBox(height: 4),
                    Flexible(
                      child: FractionallySizedBox(
                        heightFactor: w.xp / maxXp,
                        child: Container(
                          decoration: BoxDecoration(
                            color: LoloColors.colorPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(w.day, style: theme.textTheme.labelSmall),
                  ],
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _BadgeGrid extends StatelessWidget {
  const _BadgeGrid({required this.earned, required this.unearned});
  final List<BadgeEntity> earned;
  final List<BadgeEntity> unearned;

  Color _rarityColor(String rarity) => switch (rarity) {
        'common' => Colors.grey,
        'uncommon' => Colors.green,
        'rare' => const Color(0xFF4A90D9),
        'epic' => Colors.purple,
        'legendary' => const Color(0xFFC9A96E),
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.badges, style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: earned.length + unearned.length,
          itemBuilder: (_, i) {
            final badge = i < earned.length ? earned[i] : unearned[i - earned.length];
            return Semantics(
              label: '${badge.name} badge, ${badge.rarity}${badge.isEarned ? ", earned" : ""}',
              child: Tooltip(
                message: badge.name,
                child: Container(
                  decoration: BoxDecoration(
                    color: badge.isEarned
                        ? _rarityColor(badge.rarity).withValues(alpha: 0.15)
                        : LoloColors.darkBgSecondary,
                    borderRadius: BorderRadius.circular(12),
                    border: badge.isEarned
                        ? Border.all(color: _rarityColor(badge.rarity).withValues(alpha: 0.5))
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.military_tech,
                        size: 28,
                        color: badge.isEarned
                            ? _rarityColor(badge.rarity)
                            : Colors.white24,
                      ),
                      const SizedBox(height: 4),
                      if (!badge.isEarned && badge.progress != null)
                        SizedBox(
                          width: 32,
                          child: LinearProgressIndicator(
                            value: badge.progress!,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation(
                                _rarityColor(badge.rarity)),
                            minHeight: 3,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
```

---

## Module 10: RevenueCat Paywall (Screen 33)

### 10.1 Domain Entity

#### `lib/features/subscription/domain/entities/subscription_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart';

enum SubscriptionTier { free, pro, legend }

@freezed
class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    required SubscriptionTier tier,
    required String status,
    DateTime? currentPeriodEnd,
    DateTime? trialEndsAt,
    required bool autoRenew,
    required SubscriptionUsage usage,
  }) = _SubscriptionEntity;

  const SubscriptionEntity._();
  bool get isPremium => tier != SubscriptionTier.free;
  bool get isTrial => status == 'trial';
}

@freezed
class SubscriptionUsage with _$SubscriptionUsage {
  const factory SubscriptionUsage({
    required ({int used, int limit}) aiMessages,
    required ({int used, int limit}) sosSessions,
    required ({int used, int limit}) actionCardsPerDay,
    required ({int used, int limit}) memories,
  }) = _SubscriptionUsage;
}
```

### 10.2 RevenueCat Service

#### `lib/features/subscription/data/services/revenue_cat_service.dart`

```dart
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'revenue_cat_service.g.dart';

@riverpod
RevenueCatService revenueCatService(RevenueCatServiceRef ref) => RevenueCatService();

class RevenueCatService {
  static const _apiKey = String.fromEnvironment('REVENUECAT_API_KEY');

  Future<void> init(String userId) async {
    await Purchases.setLogLevel(LogLevel.debug);
    final config = PurchasesConfiguration(_apiKey)..appUserID = userId;
    await Purchases.configure(config);
  }

  Future<Offerings> getOfferings() async => Purchases.getOfferings();

  Future<CustomerInfo> purchase(Package package) async {
    final result = await Purchases.purchasePackage(package);
    return result;
  }

  Future<CustomerInfo> restore() async => Purchases.restorePurchases();

  Future<bool> checkEntitlement(String entitlementId) async {
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.containsKey(entitlementId);
  }

  Future<CustomerInfo> getCustomerInfo() async => Purchases.getCustomerInfo();
}
```

### 10.3 Providers

#### `lib/features/subscription/presentation/providers/subscription_providers.dart`

```dart
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/subscription/data/services/revenue_cat_service.dart';
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';

part 'subscription_providers.g.dart';

@riverpod
Future<SubscriptionTier> currentTier(CurrentTierRef ref) async {
  final svc = ref.watch(revenueCatServiceProvider);
  final isPro = await svc.checkEntitlement('pro');
  if (isPro) return SubscriptionTier.pro;
  final isLegend = await svc.checkEntitlement('legend');
  if (isLegend) return SubscriptionTier.legend;
  return SubscriptionTier.free;
}

@riverpod
Future<bool> isPremium(IsPremiumRef ref) async {
  final tier = await ref.watch(currentTierProvider.future);
  return tier != SubscriptionTier.free;
}

@riverpod
Future<Offerings> offerings(OfferingsRef ref) async {
  final svc = ref.watch(revenueCatServiceProvider);
  return svc.getOfferings();
}

@riverpod
class PurchaseNotifier extends _$PurchaseNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> purchase(Package package) async {
    state = const AsyncLoading();
    try {
      final svc = ref.read(revenueCatServiceProvider);
      await svc.purchase(package);
      ref.invalidate(currentTierProvider);
      ref.invalidate(isPremiumProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> restore() async {
    state = const AsyncLoading();
    try {
      final svc = ref.read(revenueCatServiceProvider);
      await svc.restore();
      ref.invalidate(currentTierProvider);
      ref.invalidate(isPremiumProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
```

### 10.4 Screen 33: Paywall

#### `lib/features/subscription/presentation/screens/paywall_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';
import 'package:lolo/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final asyncOfferings = ref.watch(offeringsProvider);
    final purchaseState = ref.watch(purchaseNotifierProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.upgradePlan),
      body: asyncOfferings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (offerings) {
          final current = offerings.current;
          if (current == null) return Center(child: Text(l10n.noPlansAvailable));
          final packages = current.availablePackages;

          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
            child: Column(
              children: [
                _HeroBanner(),
                const SizedBox(height: LoloSpacing.lg),
                _TierComparison(),
                const SizedBox(height: LoloSpacing.lg),
                ...packages.map((pkg) => Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: LoloSpacing.sm),
                  child: _PackageCard(
                    package: pkg,
                    isLoading: purchaseState is AsyncLoading,
                    onTap: () => ref.read(purchaseNotifierProvider.notifier).purchase(pkg),
                  ),
                )),
                const SizedBox(height: LoloSpacing.md),
                TextButton(
                  onPressed: purchaseState is AsyncLoading
                      ? null
                      : () => ref.read(purchaseNotifierProvider.notifier).restore(),
                  child: Text(l10n.restorePurchases),
                ),
                const SizedBox(height: LoloSpacing.sm),
                Text(l10n.subscriptionTerms,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.white38),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.xl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC9A96E), Color(0xFF8B6914)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium, size: 48, color: Colors.white),
          const SizedBox(height: LoloSpacing.sm),
          Text(l10n.unlockFullPotential,
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: LoloSpacing.xs),
          Text(l10n.paywallSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TierComparison extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    const features = [
      ('AI Messages', '5/mo', '100/mo', 'Unlimited'),
      ('Action Cards', '3/day', '10/day', 'Unlimited'),
      ('SOS Sessions', '2/mo', '10/mo', 'Unlimited'),
      ('Memories', '20', '200', 'Unlimited'),
      ('Message Modes', '3', '7', '10'),
      ('Streak Freezes', '1/mo', '3/mo', '5/mo'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: LoloColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
            child: Row(
              children: [
                const Expanded(flex: 3, child: SizedBox()),
                Expanded(flex: 2, child: Text('Free',
                    textAlign: TextAlign.center, style: theme.textTheme.labelMedium)),
                Expanded(flex: 2, child: Text('Pro',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorPrimary))),
                Expanded(flex: 2, child: Text('Legend',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorAccent))),
              ],
            ),
          ),
          const Divider(height: 1),
          ...features.map((f) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: LoloSpacing.md, vertical: LoloSpacing.sm),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(f.$1, style: theme.textTheme.bodySmall)),
                Expanded(flex: 2, child: Text(f.$2,
                    textAlign: TextAlign.center, style: theme.textTheme.bodySmall)),
                Expanded(flex: 2, child: Text(f.$3,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorPrimary))),
                Expanded(flex: 2, child: Text(f.$4,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorAccent))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.package,
    required this.isLoading,
    required this.onTap,
  });
  final Package package;
  final bool isLoading;
  final VoidCallback onTap;

  bool get _isPopular =>
      package.identifier.contains('pro') && package.identifier.contains('yearly');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final price = package.storeProduct.priceString;
    final title = package.storeProduct.title;
    final isLegend = package.identifier.contains('legend');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isPopular
                  ? LoloColors.colorPrimary
                  : isLegend
                      ? LoloColors.colorAccent
                      : LoloColors.darkBorderMuted,
              width: _isPopular ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleSmall),
                    Text(price, style: theme.textTheme.headlineSmall?.copyWith(
                      color: isLegend ? LoloColors.colorAccent : LoloColors.colorPrimary,
                    )),
                  ],
                ),
              ),
              FilledButton(
                onPressed: isLoading ? null : onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: isLegend ? LoloColors.colorAccent : LoloColors.colorPrimary,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Subscribe'),
              ),
            ],
          ),
        ),
        if (_isPopular)
          Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: LoloColors.colorPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('MOST POPULAR',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}
```

---

## Route Registration (Sprint 4)

### `lib/core/router/route_names.dart` (additions)

```dart
// Sprint 4 additions
static const String actionCards = 'action-cards';
static const String actionCardDetail = 'action-card-detail';
static const String sos = 'sos';
static const String sosAssessment = 'sos-assessment';
static const String sosCoaching = 'sos-coaching';
static const String sosPlan = 'sos-plan';
static const String gamification = 'gamification';
static const String paywall = 'paywall';
```

### `lib/core/router/app_router.dart` (Sprint 4 updates)

```dart
// === Sprint 4 Route Additions ===

// Action Cards (nested under Tab 3)
GoRoute(
  path: '/action-cards',
  name: RouteNames.actionCards,
  builder: (_, __) => const ActionCardFeedScreen(),
  routes: [
    GoRoute(
      path: 'detail/:id',
      name: RouteNames.actionCardDetail,
      builder: (_, state) {
        final id = state.pathParameters['id']!;
        return ActionCardDetailScreen(cardId: id);
      },
    ),
  ],
),

// SOS Mode (standalone flow)
GoRoute(
  path: '/sos',
  name: RouteNames.sos,
  builder: (_, __) => const SosActivationScreen(),
  routes: [
    GoRoute(
      path: 'assessment',
      name: RouteNames.sosAssessment,
      builder: (_, __) => const SosAssessmentScreen(),
    ),
    GoRoute(
      path: 'coaching',
      name: RouteNames.sosCoaching,
      builder: (_, __) => const SosCoachingScreen(),
    ),
    GoRoute(
      path: 'plan',
      name: RouteNames.sosPlan,
      builder: (_, __) => const SosPlanScreen(),
    ),
  ],
),

// Gamification Hub
GoRoute(
  path: '/gamification',
  name: RouteNames.gamification,
  builder: (_, __) => const GamificationHubScreen(),
),

// Paywall
GoRoute(
  path: '/paywall',
  name: RouteNames.paywall,
  builder: (_, __) => const PaywallScreen(),
),
```

### Required Imports

```dart
import 'package:lolo/features/action_cards/presentation/screens/action_card_feed_screen.dart';
import 'package:lolo/features/action_cards/presentation/screens/action_card_detail_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_activation_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_assessment_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_coaching_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_plan_screen.dart';
import 'package:lolo/features/gamification/presentation/screens/gamification_hub_screen.dart';
import 'package:lolo/features/subscription/presentation/screens/paywall_screen.dart';
```

---

## File Index

| # | File | Module |
|---|------|--------|
| 1 | `lib/features/action_cards/domain/entities/action_card_entity.dart` | Action Cards |
| 2 | `lib/features/action_cards/data/repositories/action_card_repository.dart` | Action Cards |
| 3 | `lib/features/action_cards/presentation/providers/action_card_providers.dart` | Action Cards |
| 4 | `lib/features/action_cards/presentation/screens/action_card_feed_screen.dart` | Screen 26 |
| 5 | `lib/features/action_cards/presentation/screens/action_card_detail_screen.dart` | Screen 27 |
| 6 | `lib/features/sos/domain/entities/sos_session.dart` | SOS |
| 7 | `lib/features/sos/domain/entities/sos_assessment.dart` | SOS |
| 8 | `lib/features/sos/domain/entities/coaching_step.dart` | SOS |
| 9 | `lib/features/sos/data/repositories/sos_repository.dart` | SOS |
| 10 | `lib/features/sos/presentation/providers/sos_providers.dart` | SOS |
| 11 | `lib/features/sos/presentation/screens/sos_activation_screen.dart` | Screen 28 |
| 12 | `lib/features/sos/presentation/screens/sos_assessment_screen.dart` | Screen 29 |
| 13 | `lib/features/sos/presentation/screens/sos_coaching_screen.dart` | Screen 30 |
| 14 | `lib/features/sos/presentation/screens/sos_plan_screen.dart` | Screen 31 |
| 15 | `lib/features/gamification/domain/entities/gamification_profile.dart` | Gamification |
| 16 | `lib/features/gamification/domain/entities/badge_entity.dart` | Gamification |
| 17 | `lib/features/gamification/domain/entities/streak_entity.dart` | Gamification |
| 18 | `lib/features/gamification/data/repositories/gamification_repository.dart` | Gamification |
| 19 | `lib/features/gamification/presentation/providers/gamification_providers.dart` | Gamification |
| 20 | `lib/features/gamification/presentation/screens/gamification_hub_screen.dart` | Screen 32 |
| 21 | `lib/features/subscription/domain/entities/subscription_entity.dart` | Subscription |
| 22 | `lib/features/subscription/data/services/revenue_cat_service.dart` | Subscription |
| 23 | `lib/features/subscription/presentation/providers/subscription_providers.dart` | Subscription |
| 24 | `lib/features/subscription/presentation/screens/paywall_screen.dart` | Screen 33 |

## pubspec.yaml additions

```yaml
dependencies:
  purchases_flutter: ^6.0.0  # RevenueCat SDK
```
