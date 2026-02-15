import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/domain/repositories/gift_repository.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';

/// Manages the gift browse screen state with pagination and filters.
class GiftBrowseNotifier extends Notifier<GiftBrowseState> {
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
    state.whenOrNull(
      loaded: (gifts, hasMore, currentPage, isLoadingMore) async {
        if (!hasMore || isLoadingMore) return;

        state = GiftBrowseState.loaded(
          gifts: gifts,
          hasMore: hasMore,
          currentPage: currentPage,
          isLoadingMore: true,
        );

        final filter = ref.read(giftBrowseFilterProvider);
        final repository = ref.read(giftRepositoryProvider);
        final nextPage = currentPage + 1;

        final result = await repository.browseGifts(
          page: nextPage,
          pageSize: _pageSize,
          category: filter.category,
          searchQuery: filter.search,
          lowBudgetOnly: filter.lowBudget ? true : null,
        );

        state = result.fold(
          (_) => GiftBrowseState.loaded(
            gifts: gifts,
            hasMore: hasMore,
            currentPage: currentPage,
            isLoadingMore: false,
          ),
          (newGifts) => GiftBrowseState.loaded(
            gifts: [...gifts, ...newGifts],
            hasMore: newGifts.length >= _pageSize,
            currentPage: nextPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  /// Toggle the saved status locally and remotely.
  Future<void> toggleSave(String giftId) async {
    state.whenOrNull(
      loaded: (gifts, hasMore, currentPage, isLoadingMore) async {
        // Optimistic update
        final updatedGifts = gifts.map((g) {
          if (g.id == giftId) return g.copyWith(isSaved: !g.isSaved);
          return g;
        }).toList();
        state = GiftBrowseState.loaded(
          gifts: updatedGifts,
          hasMore: hasMore,
          currentPage: currentPage,
          isLoadingMore: isLoadingMore,
        );

        final repository = ref.read(giftRepositoryProvider);
        await repository.toggleSave(giftId);
      },
    );
  }
}

final giftBrowseNotifierProvider =
    NotifierProvider<GiftBrowseNotifier, GiftBrowseState>(
  GiftBrowseNotifier.new,
);

/// Manages the gift detail screen state.
class GiftDetailNotifier extends FamilyNotifier<GiftDetailState, String> {
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
    state.whenOrNull(
      loaded: (gift, relatedGifts) async {
        state = GiftDetailState.loaded(
          gift: gift.copyWith(isSaved: !gift.isSaved),
          relatedGifts: relatedGifts,
        );

        final repository = ref.read(giftRepositoryProvider);
        await repository.toggleSave(gift.id);
      },
    );
  }

  Future<void> submitFeedback(bool liked) async {
    state.whenOrNull(
      loaded: (gift, relatedGifts) async {
        state = GiftDetailState.loaded(
          gift: gift.copyWith(feedback: liked),
          relatedGifts: relatedGifts,
        );

        final repository = ref.read(giftRepositoryProvider);
        await repository.submitFeedback(
          giftId: gift.id,
          liked: liked,
        );
      },
    );
  }
}

final giftDetailNotifierProvider =
    NotifierProvider.family<GiftDetailNotifier, GiftDetailState, String>(
  GiftDetailNotifier.new,
);

/// Manages gift history with pagination.
class GiftHistoryNotifier extends Notifier<GiftHistoryState> {
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
    state.whenOrNull(
      loaded: (gifts, hasMore, currentPage, isLoadingMore) async {
        if (!hasMore || isLoadingMore) return;

        state = GiftHistoryState.loaded(
          gifts: gifts,
          hasMore: hasMore,
          currentPage: currentPage,
          isLoadingMore: true,
        );

        final filter = ref.read(giftHistoryFilterProvider);
        final repository = ref.read(giftRepositoryProvider);
        final nextPage = currentPage + 1;

        final result = await repository.getGiftHistory(
          page: nextPage,
          pageSize: _pageSize,
          likedOnly: filter.likedOnly,
          dislikedOnly: filter.dislikedOnly,
        );

        state = result.fold(
          (_) => GiftHistoryState.loaded(
            gifts: gifts,
            hasMore: hasMore,
            currentPage: currentPage,
            isLoadingMore: false,
          ),
          (newGifts) => GiftHistoryState.loaded(
            gifts: [...gifts, ...newGifts],
            hasMore: newGifts.length >= _pageSize,
            currentPage: nextPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}

final giftHistoryNotifierProvider =
    NotifierProvider<GiftHistoryNotifier, GiftHistoryState>(
  GiftHistoryNotifier.new,
);
