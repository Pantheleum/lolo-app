/// Available tone options for message generation.
enum MessageTone {
  heartfelt,
  playful,
  direct,
  poetic;

  String get displayName => switch (this) {
        MessageTone.heartfelt => 'Heartfelt',
        MessageTone.playful => 'Playful',
        MessageTone.direct => 'Direct',
        MessageTone.poetic => 'Poetic',
      };
}
