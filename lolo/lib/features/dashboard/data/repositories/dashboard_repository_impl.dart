import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:lolo/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Firestore-backed implementation of [DashboardRepository].
class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        return const Left(AuthFailure(message: 'User not authenticated'));
      }

      final userDoc = await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data() ?? {};

      final remindersSnap = await _firestore
          .collection('users')
          .doc(uid)
          .collection('reminders')
          .where('date', isGreaterThanOrEqualTo: Timestamp.now())
          .orderBy('date')
          .limit(3)
          .get();

      final reminders = remindersSnap.docs.map((doc) {
        final d = doc.data();
        return DashboardReminder(
          id: doc.id,
          title: d['title'] as String? ?? '',
          date: (d['date'] as Timestamp).toDate(),
          category: d['category'] as String? ?? 'custom',
        );
      }).toList();

      final cardsSnap = await _firestore
          .collection('users')
          .doc(uid)
          .collection('dailyCards')
          .where('status', isEqualTo: 'pending')
          .limit(5)
          .get();

      final cards = cardsSnap.docs.map((doc) {
        final d = doc.data();
        return DashboardActionCard(
          id: doc.id,
          type: d['type'] as String? ?? 'say',
          title: d['title'] as String? ?? '',
          body: d['body'] as String? ?? '',
          difficulty: d['difficulty'] as int? ?? 1,
          xpValue: d['xpValue'] as int? ?? 10,
        );
      }).toList();

      return Right(DashboardData(
        userName: userData['displayName'] as String? ?? 'King',
        partnerName: userData['partnerName'] as String? ?? 'Her',
        streak: userData['streak'] as int? ?? 0,
        level: userData['level'] as int? ?? 1,
        xp: userData['xp'] as int? ?? 0,
        xpToNextLevel: userData['xpToNextLevel'] as int? ?? 100,
        activeDays: List<bool>.from(userData['activeDays'] as List? ?? []),
        upcomingReminders: reminders,
        dailyCards: cards,
      ));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardData>> refreshDashboardData() =>
      getDashboardData();
}
