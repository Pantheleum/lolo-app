import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_card_entity.freezed.dart';

enum ActionCardType { say, do_, buy, go }

enum ActionCardDifficulty { easy, medium, challenging }

enum ActionCardStatus { pending, completed, skipped, saved }

@freezed
class ActionCardEntity with _$ActionCardEntity {
  const factory ActionCardEntity({
    required String id,
    required ActionCardType type,
    required String title,
    required String description,
    required ActionCardDifficulty difficulty,
    required int estimatedMinutes,
    required int xpReward,
    required ActionCardStatus status,
    @Default([]) List<String> contextTags,
    String? personalizedDetail,
    DateTime? expiresAt,
    DateTime? completedAt,
  }) = _ActionCardEntity;
}

@freezed
class DailyCardsSummary with _$DailyCardsSummary {
  const factory DailyCardsSummary({
    required List<ActionCardEntity> cards,
    required int totalCards,
    required int completedToday,
    required int totalXpAvailable,
  }) = _DailyCardsSummary;
}
