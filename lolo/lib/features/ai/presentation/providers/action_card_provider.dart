// FILE: lib/features/ai/presentation/providers/action_card_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';

part 'action_card_provider.freezed.dart';
part 'action_card_provider.g.dart';

@freezed
class ActionCardsState with _$ActionCardsState {
  const factory ActionCardsState.loading() = _CardsLoading;
  const factory ActionCardsState.loaded({
    required List<ActionCard> cards,
    required ActionCardSummary summary,
  }) = _CardsLoaded;
  const factory ActionCardsState.error(String message) = _CardsError;
}

@riverpod
class ActionCardsNotifier extends _$ActionCardsNotifier {
  @override
  ActionCardsState build() {
    _loadCards();
    return const ActionCardsState.loading();
  }

  Future<void> _loadCards({bool forceRefresh = false}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getDailyCards(forceRefresh: forceRefresh);

    state = result.fold(
      (f) => ActionCardsState.error(f.message),
      (data) => ActionCardsState.loaded(
        cards: data.cards,
        summary: data.summary,
      ),
    );
  }

  Future<void> refresh({bool force = false}) async {
    state = const ActionCardsState.loading();
    await _loadCards(forceRefresh: force);
  }

  Future<CardCompleteResponse?> completeCard(String cardId, {String? notes}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.completeCard(cardId, notes: notes);

    return result.fold(
      (_) => null,
      (response) {
        _updateCardStatus(cardId, CardStatus.completed);
        return response;
      },
    );
  }

  Future<ActionCard?> skipCard(String cardId, {String? reason}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.skipCard(cardId, reason: reason);

    return result.fold(
      (_) => null,
      (replacement) {
        final current = state;
        if (current is _CardsLoaded) {
          final updatedCards = current.cards.where((c) => c.id != cardId).toList();
          if (replacement != null) {
            updatedCards.add(replacement);
          }
          state = current.copyWith(cards: updatedCards);
        }
        return replacement;
      },
    );
  }

  Future<void> saveCard(String cardId) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.saveCard(cardId);
    result.fold(
      (_) {},
      (_) => _updateCardStatus(cardId, CardStatus.saved),
    );
  }

  void _updateCardStatus(String cardId, CardStatus status) {
    final current = state;
    if (current is _CardsLoaded) {
      final updatedCards = current.cards.map((c) {
        if (c.id == cardId) return c.copyWith(status: status);
        return c;
      }).toList();
      final completedCount = updatedCards.where((c) => c.status == CardStatus.completed).length;
      state = current.copyWith(
        cards: updatedCards,
        summary: current.summary.copyWith(completedToday: completedCount),
      );
    }
  }
}
