import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';

/// Tracks the currently selected message mode across the
/// AI Messages flow. Set on the Mode Picker screen, consumed
/// by the Configuration screen.
class SelectedMessageMode extends Notifier<MessageMode?> {
  @override
  MessageMode? build() => null;

  void select(MessageMode mode) {
    state = mode;
  }

  void clear() {
    state = null;
  }
}

final selectedMessageModeProvider =
    NotifierProvider<SelectedMessageMode, MessageMode?>(
  SelectedMessageMode.new,
);
