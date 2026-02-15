import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/repositories/message_repository.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';

part 'message_history_provider.g.dart';

/// Filter state for the message history screen.
@riverpod
class MessageHistoryFilter extends _$MessageHistoryFilter {
  @override
  ({bool? favoritesOnly, MessageMode? mode, String? search}) build() =>
      (favoritesOnly: null, mode: null, search: null);

  void setFavoritesOnly(bool? value) {
    state = (favoritesOnly: value, mode: state.mode, search: state.search);
  }

  void setModeFilter(MessageMode? mode) {
    state = (favoritesOnly: state.favoritesOnly, mode: mode, search: state.search);
  }

  void setSearch(String? query) {
    state = (
      favoritesOnly: state.favoritesOnly,
      mode: state.mode,
      search: query?.isEmpty == true ? null : query,
    );
  }

  void clearAll() {
    state = (favoritesOnly: null, mode: null, search: null);
  }
}

/// Manages paginated message history with filter support.
@riverpod
class MessageHistoryNotifier extends _$MessageHistoryNotifier {
  static const int _pageSize = 20;

  @override
  MessageHistoryState build() {
    // Auto-load first page when the provider is first read
    Future.microtask(loadFirstPage);
    return const MessageHistoryState.initial();
  }

  /// Load (or reload) the first page.
  Future<void> loadFirstPage() async {
    state = const MessageHistoryState.loading();

    final filter = ref.read(messageHistoryFilterProvider);
    final repository = ref.read(messageRepositoryProvider);

    final result = await repository.getMessageHistory(
      page: 1,
      pageSize: _pageSize,
      favoritesOnly: filter.favoritesOnly,
      modeFilter: filter.mode,
      searchQuery: filter.search,
    );

    state = result.fold(
      (failure) => MessageHistoryState.error(message: failure.message),
      (messages) => MessageHistoryState.loaded(
        messages: messages,
        hasMore: messages.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  /// Load the next page (infinite scroll).
  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _HistoryLoaded || !current.hasMore || current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(messageHistoryFilterProvider);
    final repository = ref.read(messageRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.getMessageHistory(
      page: nextPage,
      pageSize: _pageSize,
      favoritesOnly: filter.favoritesOnly,
      modeFilter: filter.mode,
      searchQuery: filter.search,
    );

    state = result.fold(
      (failure) => current.copyWith(isLoadingMore: false),
      (messages) => current.copyWith(
        messages: [...current.messages, ...messages],
        hasMore: messages.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }
}
