import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Concrete implementation of [OnboardingRepository].
///
/// Strategy: save locally after every step, write directly to Firestore on complete.
/// Local draft uses Hive (fast, no schema needed).
/// Completion writes user profile to Firestore `users/{uid}` document.
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;
  final OnboardingRemoteDataSource _remoteDataSource;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OnboardingRepositoryImpl({
    required OnboardingLocalDataSource localDataSource,
    required OnboardingRemoteDataSource remoteDataSource,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<Either<Failure, void>> saveDraft(OnboardingDataEntity data) async {
    try {
      final model = OnboardingDataModel.fromEntity(data);
      await _localDataSource.saveDraft(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OnboardingDataEntity?>> loadDraft() async {
    try {
      final model = await _localDataSource.loadDraft();
      return Right(model?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearDraft() async {
    try {
      await _localDataSource.clearDraft();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding(
    OnboardingDataEntity data,
  ) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        return const Left(AuthFailure(message: 'User not authenticated'));
      }

      // Write user profile directly to Firestore
      // Fields match the Firestore rules requirements for users/{uid}
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': data.email ?? _auth.currentUser?.email ?? '',
        'displayName': data.userName ?? _auth.currentUser?.displayName ?? '',
        'language': data.language,
        'tier': 'free',
        'onboardingComplete': true,
        'settings': {
          'notificationsEnabled': true,
          'dailyCardTime': '09:00',
          'theme': 'system',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'lastActiveAt': FieldValue.serverTimestamp(),
        // Additional profile fields
        'partnerName': data.partnerName ?? '',
        if (data.partnerNickname != null && data.partnerNickname!.isNotEmpty)
          'partnerNickname': data.partnerNickname,
        if (data.partnerZodiac != null) 'partnerZodiac': data.partnerZodiac,
        'relationshipStatus': data.relationshipStatus ?? 'dating',
        if (data.keyDate != null)
          'keyDate': Timestamp.fromDate(data.keyDate!),
        if (data.keyDateType != null) 'keyDateType': data.keyDateType,
        'authProvider': data.authProvider ?? 'email',
        'streak': 0,
        'level': 1,
        'xp': 0,
        'xpToNextLevel': 100,
        'activeDays': <bool>[],
      }, SetOptions(merge: true));

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to save profile'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
