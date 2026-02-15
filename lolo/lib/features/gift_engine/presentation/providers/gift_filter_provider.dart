import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';

part 'gift_filter_provider.g.dart';

/// Filter state for the Gift Browse screen.
@riverpod
class GiftBrowseFilter extends _$GiftBrowseFilter {
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

/// Filter for the Gift History screen.
@riverpod
class GiftHistoryFilter extends _$GiftHistoryFilter {
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
