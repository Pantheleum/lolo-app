import 'package:cloud_firestore/cloud_firestore.dart';

/// Notification types matching the API spec.
enum NotificationType {
  reminder,
  gamification,
  system,
  actionCard,
  subscription,
  message,
  streak,
  gift,
  sos,
}

/// A single in-app notification item.
class NotificationItemEntity {
  const NotificationItemEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.imageUrl,
    this.actionType = 'none',
    this.actionTarget,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String? imageUrl;
  final String actionType; // route, external, none
  final String? actionTarget;
  final DateTime createdAt;
  final bool isRead;

  /// Create from Firestore document.
  factory NotificationItemEntity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return NotificationItemEntity(
      id: doc.id,
      type: _parseType(data['type'] as String? ?? 'system'),
      title: data['title'] as String? ?? '',
      body: data['body'] as String? ?? '',
      imageUrl: data['imageUrl'] as String?,
      actionType: data['actionType'] as String? ?? 'none',
      actionTarget: data['actionTarget'] as String?,
      createdAt: _parseDate(data['createdAt']),
      isRead: data['isRead'] as bool? ?? false,
    );
  }

  NotificationItemEntity copyWith({bool? isRead}) => NotificationItemEntity(
        id: id,
        type: type,
        title: title,
        body: body,
        imageUrl: imageUrl,
        actionType: actionType,
        actionTarget: actionTarget,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
      );

  static NotificationType _parseType(String raw) => switch (raw) {
        'reminder' => NotificationType.reminder,
        'gamification' => NotificationType.gamification,
        'action_card' => NotificationType.actionCard,
        'subscription' => NotificationType.subscription,
        'message' => NotificationType.message,
        'streak' => NotificationType.streak,
        'gift' => NotificationType.gift,
        'sos' => NotificationType.sos,
        _ => NotificationType.system,
      };

  static DateTime _parseDate(dynamic val) {
    if (val is Timestamp) return val.toDate();
    if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
    return DateTime.now();
  }
}
