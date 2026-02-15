import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/domain/repositories/gift_repository.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';

part 'gift_provider.g.dart';

/// Manages the gift browse screen state with pagination and filters.
@riverpod
class GiftBrowseNotifier extends _$GiftBrowseNotifier {
  static const int _pageSize = 20;

  @override
  GiftBrowseState build() {
    Future.microtask(loadFirstPage);
    return const GiftBrowseState.initial();
  }

  Future<void> loadFirstPage() async {
    state = const GiftBrowseState.loading();

    final filter = ref.read(giftBrowseFilterProvider);
    final repository = ref.read(giftRepositoryProvider);

    final result = await repository.browseGifts(
      page: 1,
      pageSize: _pageSize,
      category: filter.category,
      searchQuery: filter.search,
      lowBudgetOnly: filter.lowBudget ? true : null,
    );

    state = result.fold(
      (failure) => GiftBrowseState.error(message: failure.message),
      (gifts) => GiftBrowseState.loaded(
        gifts: gifts,
        hasMore: gifts.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _BrowseLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(giftBrowseFilterProvider);
    final repository = ref.read(giftRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.browseGifts(
      page: nextPage,
      pageSize: _pageSize,
      category: filter.category,
      searchQuery: filter.search,
      lowBudgetOnly: filter.lowBudget ? true : null,
    );

    state = result.fold(
      (_) => current.copyWith(isLoadingMore: false),
      (gifts) => current.copyWith(
        gifts: [...current.gifts, ...gifts],
        hasMore: gifts.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }

  /// Toggle the saved status locally and remotely.
  Future<void> toggleSave(String giftId) async {
    final current = state;
    if (current is! _BrowseLoaded) return;

    // Optimistic update
    final updatedGifts = current.gifts.map((g) {
      if (g.id == giftId) return g.copyWith(isSaved: !g.isSaved);
      return g;
    }).toList();
    state = current.copyWith(gifts: updatedGifts);

    final repository = ref.read(giftRepositoryProvider);
    await repository.toggleSave(giftId);
  }
}

/// Manages the gift detail screen state.
@riverpod
class GiftDetailNotifier extends _$GiftDetailNotifier {
  @override
  GiftDetailState build(String giftId) {
    Future.microtask(() => _load(giftId));
    return const GiftDetailState.loading();
  }

  Future<void> _load(String giftId) async {
    final repository = ref.read(giftRepositoryProvider);

    final giftResult = await repository.getGiftById(giftId);
    final relatedResult = await repository.getRelatedGifts(giftId);

    giftResult.fold(
      (failure) =>
          state = GiftDetailState.error(message: failure.message),
      (gift) => state = GiftDetailState.loaded(
        gift: gift,
        relatedGifts: relatedResult.fold((_) => [], (r) => r),
      ),
    );
  }

  Future<void> toggleSave() async {
    final current = state;
    if (current is! _DetailLoaded) return;

    state = current.copyWith(
      gift: current.gift.copyWith(isSaved: !current.gift.isSaved),
    );

    final repository = ref.read(giftRepositoryProvider);
    await repository.toggleSave(current.gift.id);
  }

  Future<void> submitFeedback(bool liked) async {
    final current = state;
    if (current is! _DetailLoaded) return;

    state = current.copyWith(
      gift: current.gift.copyWith(feedback: liked),
    );

    final repository = ref.read(giftRepositoryProvider);
    await repository.submitFeedback(
      giftId: current.gift.id,
      liked: liked,
    );
  }
}

/// Manages gift history with pagination.
@riverpod
class GiftHistoryNotifier extends _$GiftHistoryNotifier {
  static const int _pageSize = 20;

  @override
  GiftHistoryState build() {
    Future.microtask(loadFirstPage);
    return const GiftHistoryState.initial();
  }

  Future<void> loadFirstPage() async {
    state = const GiftHistoryState.loading();

    final filter = ref.read(giftHistoryFilterProvider);
    final repository = ref.read(giftRepositoryProvider);

    final result = await repository.getGiftHistory(
      page: 1,
      pageSize: _pageSize,
      likedOnly: filter.likedOnly,
      dislikedOnly: filter.dislikedOnly,
    );

    state = result.fold(
      (failure) => GiftHistoryState.error(message: failure.message),
      (gifts) => GiftHistoryState.loaded(
        gifts: gifts,
        hasMore: gifts.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _HistLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(giftHistoryFilterProvider);
    final repository = ref.read(giftRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.getGiftHistory(
      page: nextPage,
      pageSize: _pageSize,
      likedOnly: filter.likedOnly,
      dislikedOnly: filter.dislikedOnly,
    );

    state = result.fold(
      (_) => current.copyWith(isLoadingMore: false),
      (gifts) => current.copyWith(
        gifts: [...current.gifts, ...gifts],
        hasMore: gifts.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }
}
