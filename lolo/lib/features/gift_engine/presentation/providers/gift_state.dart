import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';

part 'gift_state.freezed.dart';

/// States for the gift browse screen.
@freezed
class GiftBrowseState with _$GiftBrowseState {
  const factory GiftBrowseState.initial() = _BrowseInitial;
  const factory GiftBrowseState.loading() = _BrowseLoading;
  const factory GiftBrowseState.loaded({
    required List<GiftRecommendationEntity> gifts,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _BrowseLoaded;
  const factory GiftBrowseState.error({required String message}) =
      _BrowseError;
}

/// States for the gift detail screen.
@freezed
class GiftDetailState with _$GiftDetailState {
  const factory GiftDetailState.loading() = _DetailLoading;
  const factory GiftDetailState.loaded({
    required GiftRecommendationEntity gift,
    required List<GiftRecommendationEntity> relatedGifts,
  }) = _DetailLoaded;
  const factory GiftDetailState.error({required String message}) =
      _DetailError;
}

/// States for the gift history screen.
@freezed
class GiftHistoryState with _$GiftHistoryState {
  const factory GiftHistoryState.initial() = _HistInitial;
  const factory GiftHistoryState.loading() = _HistLoading;
  const factory GiftHistoryState.loaded({
    required List<GiftRecommendationEntity> gifts,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _HistLoaded;
  const factory GiftHistoryState.error({required String message}) =
      _HistError;
}
