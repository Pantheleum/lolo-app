import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';

/// Filter state for the Gift Browse screen.
class GiftBrowseFilter
    extends Notifier<({GiftCategory? category, String? search, bool lowBudget})> {
  @override
  ({GiftCategory? category, String? search, bool lowBudget}) build() =>
      (category: null, search: null, lowBudget: false);

  void setCategory(GiftCategory? category) {
    // 'All' category maps to null (no filter)
    final effective = category == GiftCategory.all ? null : category;
    state = (
      category: effective,
      search: state.search,
      lowBudget: state.lowBudget,
    );
  }

  void setSearch(String? query) {
    state = (
      category: state.category,
      search: query?.isEmpty == true ? null : query,
      lowBudget: state.lowBudget,
    );
  }

  void toggleLowBudget() {
    state = (
      category: state.category,
      search: state.search,
      lowBudget: !state.lowBudget,
    );
  }
}

final giftBrowseFilterProvider = NotifierProvider<GiftBrowseFilter,
    ({GiftCategory? category, String? search, bool lowBudget})>(
  GiftBrowseFilter.new,
);

/// Filter for the Gift History screen.
class GiftHistoryFilter
    extends Notifier<({bool? likedOnly, bool? dislikedOnly})> {
  @override
  ({bool? likedOnly, bool? dislikedOnly}) build() =>
      (likedOnly: null, dislikedOnly: null);

  void setAll() {
    state = (likedOnly: null, dislikedOnly: null);
  }

  void setLikedOnly() {
    state = (likedOnly: true, dislikedOnly: null);
  }

  void setDislikedOnly() {
    state = (likedOnly: null, dislikedOnly: true);
  }
}

final giftHistoryFilterProvider = NotifierProvider<GiftHistoryFilter,
    ({bool? likedOnly, bool? dislikedOnly})>(
  GiftHistoryFilter.new,
);
