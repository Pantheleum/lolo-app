import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_preferences_entity.freezed.dart';

/// Her preferences: favorites, dislikes, hobbies, and notes.
///
/// Used by the Gift Engine for recommendations and by Action Cards
/// for personalized suggestions.
@freezed
class PartnerPreferencesEntity with _$PartnerPreferencesEntity {
  const factory PartnerPreferencesEntity({
    @Default({}) Map<String, List<String>> favorites,
    @Default([]) List<String> dislikes,
    @Default([]) List<String> hobbies,
    String? stressCoping,
    String? notes,
  }) = _PartnerPreferencesEntity;

  const PartnerPreferencesEntity._();

  /// Total number of preference items filled in.
  int get filledCount {
    var count = 0;
    for (final list in favorites.values) {
      count += list.length;
    }
    count += dislikes.length;
    count += hobbies.length;
    if (stressCoping != null) count++;
    if (notes != null) count++;
    return count;
  }
}
