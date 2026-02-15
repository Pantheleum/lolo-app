/// All REST API endpoint paths as constants.
///
/// Base URL is configured in [AppConstants.baseUrl].
/// Total: 69 endpoints across 12 modules.
abstract final class ApiEndpoints {
  // === Module 1: Auth & Account (8 endpoints) ===
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authSocial = '/auth/social';
  static const String authRefreshToken = '/auth/refresh-token';
  static const String authDeleteAccount = '/auth/account';
  static const String authProfile = '/auth/profile';
  static const String authLanguage = '/auth/language';
  static const String authOnboarding = '/auth/onboarding';

  // === Module 2: Her Profile Engine (7 endpoints) ===
  static const String profiles = '/profiles';
  static String profileById(String id) => '/profiles/$id';
  static String profilePreferences(String id) => '/profiles/$id/preferences';
  static String profileCulturalContext(String id) =>
      '/profiles/$id/cultural-context';
  static String profileZodiacDefaults(String id) =>
      '/profiles/$id/zodiac-defaults';
  static String profileFamilyMembers(String id) =>
      '/profiles/$id/family-members';
  static String profileFamilyMember(String profileId, String memberId) =>
      '/profiles/$profileId/family-members/$memberId';

  // === Module 3: Smart Reminders (8 endpoints) ===
  static const String reminders = '/reminders';
  static String reminderById(String id) => '/reminders/$id';
  static String reminderSnooze(String id) => '/reminders/$id/snooze';
  static String reminderComplete(String id) => '/reminders/$id/complete';
  static const String remindersUpcoming = '/reminders/upcoming';
  static const String promises = '/reminders/promises';
  static String promiseById(String id) => '/reminders/promises/$id';
  static const String islamicHolidays = '/reminders/islamic-holidays';

  // === Module 4: AI Message Generator (6 endpoints) ===
  static const String aiMessagesGenerate = '/ai/messages/generate';
  static const String aiMessagesModes = '/ai/messages/modes';
  static const String aiMessagesHistory = '/ai/messages/history';
  static const String aiMessagesUsage = '/ai/messages/usage';
  static String aiMessageFavorite(String id) => '/ai/messages/$id/favorite';
  static String aiMessageFeedback(String id) => '/ai/messages/$id/feedback';

  // === Module 5: Gift Recommendation Engine (5 endpoints) ===
  static const String giftsRecommend = '/gifts/recommend';
  static const String giftsCategories = '/gifts/categories';
  static const String giftsHistory = '/gifts/history';
  static String giftFeedback(String id) => '/gifts/$id/feedback';
  static const String giftsWishlist = '/gifts/wishlist';

  // === Module 6: SOS Mode (5 endpoints) ===
  static const String sosActivate = '/sos/activate';
  static const String sosAssess = '/sos/assess';
  static const String sosCoach = '/sos/coach';
  static String sosSession(String id) => '/sos/$id';
  static String sosFollowup(String id) => '/sos/$id/followup';

  // === Module 7: Gamification (7 endpoints) ===
  static const String gamificationStats = '/gamification/stats';
  static const String gamificationStreak = '/gamification/streak';
  static const String gamificationStreakFreeze = '/gamification/streak/freeze';
  static const String gamificationBadges = '/gamification/badges';
  static const String gamificationLeaderboard = '/gamification/leaderboard';
  static const String gamificationWeeklySummary = '/gamification/weekly-summary';
  static const String gamificationXpHistory = '/gamification/xp-history';

  // === Module 8: Smart Action Cards (6 endpoints) ===
  static const String actionCardsToday = '/action-cards/today';
  static String actionCardById(String id) => '/action-cards/$id';
  static String actionCardComplete(String id) => '/action-cards/$id/complete';
  static String actionCardSkip(String id) => '/action-cards/$id/skip';
  static String actionCardSave(String id) => '/action-cards/$id/save';
  static const String actionCardsHistory = '/action-cards/history';

  // === Module 9: Memory Vault (7 endpoints) ===
  static const String memories = '/memories';
  static String memoryById(String id) => '/memories/$id';
  static const String memoriesSearch = '/memories/search';
  static const String wishlist = '/memories/wishlist';
  static String wishlistItemById(String id) => '/memories/wishlist/$id';
  static const String memoriesExport = '/memories/export';
  static const String memoriesTimeline = '/memories/timeline';

  // === Module 10: Settings & Subscriptions (5 endpoints) ===
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsPrivacy = '/settings/privacy';
  static const String settingsDataExport = '/settings/data-export';
  static const String subscriptionStatus = '/subscription/status';
  static const String subscriptionVerify = '/subscription/verify';

  // === Module 11: Notifications (5 endpoints) ===
  static const String notificationsRegisterDevice = '/notifications/device';
  static const String notificationsList = '/notifications';
  static String notificationMarkRead(String id) => '/notifications/$id/read';
  static const String notificationsMarkAllRead = '/notifications/read-all';
  static const String notificationsPreferences = '/notifications/preferences';
}
