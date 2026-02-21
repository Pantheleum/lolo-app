import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/core/storage/hive_setup.dart';
import 'package:lolo/core/storage/isar_setup.dart';
import 'package:lolo/core/services/notification_service.dart';

/// Initializes all app-level services before the widget tree is built.
///
/// Order matters:
/// 1. Firebase (auth, firestore, messaging depend on it)
/// 2. Hive (local key-value cache for settings, drafts)
/// 3. Isar (structured local DB for memories, reminders)
/// 4. Notifications (FCM + local notification channels)
/// 5. Register FCM token if user is already signed in
Future<void> bootstrap() async {
  // 1. Firebase
  await Firebase.initializeApp();

  // 2. Hive (key-value storage)
  await Hive.initFlutter();
  await HiveSetup.init();

  // 3. Isar (local database)
  await IsarSetup.init();

  // 4. Notification channels
  await NotificationService.init();

  // 5. Register FCM token if user is already logged in (app restart)
  if (FirebaseAuth.instance.currentUser != null) {
    NotificationService.registerDevice();
  }
}
