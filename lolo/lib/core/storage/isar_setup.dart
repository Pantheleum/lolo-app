/// Isar local database initialization.
///
/// Currently a no-op. Structured local storage will use Hive for now.
/// Isar/Drift integration deferred until offline-first features are prioritized.
abstract final class IsarSetup {
  static Future<void> init() async {
    // No-op: Using Hive for local storage in MVP.
    // Will initialize Isar/Drift when offline query features are needed.
  }
}
