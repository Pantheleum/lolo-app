import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';

part 'message_mode_provider.g.dart';

/// Tracks the currently selected message mode across the
/// AI Messages flow. Set on the Mode Picker screen, consumed
/// by the Configuration screen.
@riverpod
class SelectedMessageMode extends _$SelectedMessageMode {
  @override
  MessageMode? build() => null;

  void select(MessageMode mode) {
    state = mode;
  }

  void clear() {
    state = null;
  }
}
