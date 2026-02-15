import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';

final dailyCardsProvider = FutureProvider<DailyCardsSummary>((ref) async {
  final repo = ref.watch(actionCardRepositoryProvider);
  final result = await repo.getDailyCards();
  return result.fold((f) => throw Exception(f.message), (s) => s);
});

final cardHistoryProvider =
    FutureProvider<List<ActionCardEntity>>((ref) async {
  final repo = ref.watch(actionCardRepositoryProvider);
  final result = await repo.getHistory();
  return result.fold((f) => throw Exception(f.message), (l) => l);
});

class CardActionNotifier extends Notifier<AsyncValue<void>> {
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

final cardActionNotifierProvider =
    NotifierProvider<CardActionNotifier, AsyncValue<void>>(
  CardActionNotifier.new,
);
