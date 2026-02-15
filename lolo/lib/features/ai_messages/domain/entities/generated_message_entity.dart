import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

part 'generated_message_entity.freezed.dart';

/// Immutable entity representing a generated AI message.
@freezed
class GeneratedMessageEntity with _$GeneratedMessageEntity {
  const factory GeneratedMessageEntity({
    required String id,
    required String content,
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    required DateTime createdAt,
    @Default(0) int rating,
    @Default(false) bool isFavorite,
    String? modelBadge,
    String? languageCode,
    String? context,
    @Default(false) bool includePartnerName,
  }) = _GeneratedMessageEntity;
}
