import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Notification service for FCM + local notification channels.
///
/// Handles:
/// - FCM token registration
/// - Local notification channel setup
/// - Notification display and routing
class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'lolo_reminders',
    'Reminders',
    description: 'Scheduled reminders for LOLO',
    importance: Importance.high,
  );

  static Future<void> init() async {
    // --- FCM setup ---
    final messaging = FirebaseMessaging.instance;

    // Request permission (required on iOS, no-op effectively on Android 12-)
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get and print FCM token for debugging
    final token = await messaging.getToken();
    // ignore: avoid_print
    print('[NotificationService] FCM token: $token');

    // Handle foreground messages by showing a local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    });

    // --- Local notifications setup ---
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(initSettings);

    // Create the Android notification channel
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);
    }
  }

  /// Cancel all notifications for a given reminder.
  Future<void> cancelReminder(String reminderId) async {
    await _localNotifications.cancel(reminderId.hashCode);
  }

  /// Schedule a local notification.
  ///
  /// If [scheduledDate] is in the future, the notification is delayed
  /// using [Future.delayed] and then shown. If it is in the past or now,
  /// the notification is shown immediately.
  Future<void> scheduleReminder({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final now = DateTime.now();
    final delay = scheduledDate.difference(now);

    if (delay.isNegative || delay == Duration.zero) {
      // Show immediately
      await _localNotifications.show(
        id.hashCode,
        title,
        body,
        notificationDetails,
      );
    } else {
      // Delay then show
      Future.delayed(delay, () async {
        await _localNotifications.show(
          id.hashCode,
          title,
          body,
          notificationDetails,
        );
      });
    }
  }
}
