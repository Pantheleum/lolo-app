import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/notifications/domain/entities/notification_item_entity.dart';

/// Stream of all notifications for the current user, ordered newest-first.
final notificationsProvider =
    StreamProvider<List<NotificationItemEntity>>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('notifications')
      .orderBy('createdAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs
          .map(NotificationItemEntity.fromFirestore)
          .toList());
});

/// Unread notification count.
final unreadCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider).valueOrNull ?? [];
  return notifications.where((n) => !n.isRead).length;
});

/// Mark a single notification as read.
Future<void> markNotificationRead(String notificationId) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('notifications')
      .doc(notificationId)
      .update({'isRead': true});
}

/// Mark all notifications as read.
Future<void> markAllNotificationsRead() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  final batch = FirebaseFirestore.instance.batch();
  final snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('notifications')
      .where('isRead', isEqualTo: false)
      .get();
  for (final doc in snap.docs) {
    batch.update(doc.reference, {'isRead': true});
  }
  await batch.commit();
}
