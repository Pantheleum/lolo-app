/// Categories for Memory Vault entries.
enum MemoryCategory {
  moment,
  milestone,
  lesson,
  wishlist;

  String get label => switch (this) {
        MemoryCategory.moment => 'Moment',
        MemoryCategory.milestone => 'Milestone',
        MemoryCategory.lesson => 'Lesson',
        MemoryCategory.wishlist => 'Wishlist',
      };

  String get emoji => switch (this) {
        MemoryCategory.moment => '\u{1F4F8}',
        MemoryCategory.milestone => '\u{1F3C6}',
        MemoryCategory.lesson => '\u{1F4D6}',
        MemoryCategory.wishlist => '\u{2B50}',
      };
}
