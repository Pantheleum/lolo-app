/// App-wide constants.
abstract final class AppConstants {
  // API
  static const String baseUrl =
      'https://us-central1-lolo-3228d.cloudfunctions.net/api/api/v1';
  static const String appVersion = '1.0.0';
  static const String platform = 'android'; // Resolved at runtime

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache durations (seconds)
  static const int cacheTtlShort = 60;
  static const int cacheTtlMedium = 300;
  static const int cacheTtlLong = 3600;
  static const int cacheTtlDay = 86400;

  // Animation durations (milliseconds)
  static const int animFast = 150;
  static const int animNormal = 300;
  static const int animSlow = 500;
  static const int typewriterCharDelay = 30;

  // Rate limits (client-side throttle)
  static const int apiThrottleMs = 500;

  // Subscription tiers
  static const int freeMessageLimit = 10;
  static const int proMessageLimit = 100;
  static const int freeSosLimit = 2;
  static const int proSosLimit = 10;
  static const int freeActionCardsPerDay = 3;
  static const int proActionCardsPerDay = 10;
}
