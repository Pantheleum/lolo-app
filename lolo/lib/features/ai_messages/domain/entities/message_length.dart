/// Desired length for generated messages.
enum MessageLength {
  short,
  medium,
  long;

  String get displayName => switch (this) {
        MessageLength.short => 'Short',
        MessageLength.medium => 'Medium',
        MessageLength.long => 'Long',
      };
}
