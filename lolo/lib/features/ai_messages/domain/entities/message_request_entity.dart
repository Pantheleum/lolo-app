import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

part 'message_request_entity.freezed.dart';

/// Immutable entity encapsulating all parameters for a message
/// generation API request.
@freezed
class MessageRequestEntity with _$MessageRequestEntity {
  const factory MessageRequestEntity({
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    @Default(50) int humorLevel,
    @Default('en') String languageCode,
    @Default(true) bool includePartnerName,
    String? contextText,
  }) = _MessageRequestEntity;
}
