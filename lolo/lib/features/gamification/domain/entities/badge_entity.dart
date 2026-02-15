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
