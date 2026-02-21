import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/core/constants/app_constants.dart';

/// Top-level background message handler (must be top-level function).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase is auto-initialized by FlutterFire.
  // Background messages with a `notification` payload are shown automatically
  // by the system tray. Data-only messages can be handled here if needed.
}

/// Notification service for FCM + local notification channels.
///
/// Handles:
/// - FCM token registration with backend
/// - Token refresh listening
/// - Local notification channel setup
/// - Foreground & background notification display
class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
      AndroidNotificationChannel(
    'lolo_reminders',
    'Reminders',
    description: 'Scheduled reminders for LOLO',
    importance: Importance.high,
  );

  /// Cached token so we can unregister on logout.
  static String? _currentToken;

  static Future<void> init() async {
    // --- Background handler (must be set before any other FCM calls) ---
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // --- FCM setup ---
    final messaging = FirebaseMessaging.instance;

    // Request permission (required on iOS, no-op effectively on Android 12-)
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    _currentToken = await messaging.getToken();

    // Listen for token refresh and re-register with backend
    messaging.onTokenRefresh.listen((newToken) {
      _currentToken = newToken;
      _registerTokenWithBackend(newToken);
    });

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

  /// Register the current FCM token with the backend.
  /// Call this after successful login/signup.
  static Future<void> registerDevice() async {
    final token = _currentToken ?? await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    _currentToken = token;
    await _registerTokenWithBackend(token);
  }

  /// Unregister the current device token from backend.
  /// Call this before signing out.
  static Future<void> unregisterDevice() async {
    if (_currentToken == null) return;
    try {
      final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (idToken == null) return;

      final dio = Dio(BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      ));

      await dio.delete<dynamic>(
        ApiEndpoints.notificationsRegisterDevice,
        data: {'token': _currentToken},
      );
    } catch (_) {
      // Best-effort: don't block sign-out if this fails
    }
  }

  static Future<void> _registerTokenWithBackend(String token) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final idToken = await user.getIdToken();
      if (idToken == null) return;

      final dio = Dio(BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
      ));

      await dio.post<dynamic>(
        ApiEndpoints.notificationsRegisterDevice,
        data: {
          'token': token,
          'platform': Platform.isIOS ? 'ios' : 'android',
        },
      );
    } catch (_) {
      // Silent failure: will retry on next token refresh or app restart
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
