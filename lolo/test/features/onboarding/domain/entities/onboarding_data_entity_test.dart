import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

void main() {
  group('OnboardingDataEntity', () {
    test('creates with default values', () {
      const entity = OnboardingDataEntity();
      expect(entity.language, 'en');
      expect(entity.currentStep, 0);
      expect(entity.isComplete, false);
      expect(entity.userName, isNull);
      expect(entity.partnerName, isNull);
      expect(entity.partnerZodiac, isNull);
      expect(entity.relationshipStatus, isNull);
      expect(entity.keyDate, isNull);
      expect(entity.keyDateType, isNull);
      expect(entity.email, isNull);
      expect(entity.authProvider, isNull);
      expect(entity.firebaseUid, isNull);
    });

    test('creates with all fields', () {
      final keyDate = DateTime(2020, 6, 15);
      final entity = OnboardingDataEntity(
        language: 'ar',
        userName: 'Ahmed',
        partnerName: 'Sara',
        partnerZodiac: 'scorpio',
        relationshipStatus: 'married',
        keyDate: keyDate,
        keyDateType: 'wedding_date',
        email: 'ahmed@test.com',
        authProvider: 'email',
        firebaseUid: 'uid123',
        currentStep: 7,
        isComplete: true,
      );
      expect(entity.language, 'ar');
      expect(entity.userName, 'Ahmed');
      expect(entity.partnerName, 'Sara');
      expect(entity.partnerZodiac, 'scorpio');
      expect(entity.relationshipStatus, 'married');
      expect(entity.keyDate, keyDate);
      expect(entity.keyDateType, 'wedding_date');
      expect(entity.email, 'ahmed@test.com');
      expect(entity.authProvider, 'email');
      expect(entity.firebaseUid, 'uid123');
      expect(entity.currentStep, 7);
      expect(entity.isComplete, true);
    });

    group('copyWith', () {
      test('copies with updated userName', () {
        const original = OnboardingDataEntity(userName: 'Ahmed');
        final copy = original.copyWith(userName: 'Mohamed');
        expect(copy.userName, 'Mohamed');
        expect(copy.language, 'en'); // other fields unchanged
      });

      test('copies with updated currentStep', () {
        const original = OnboardingDataEntity(currentStep: 2);
        final copy = original.copyWith(currentStep: 5);
        expect(copy.currentStep, 5);
      });

      test('copies with multiple fields', () {
        const original = OnboardingDataEntity();
        final copy = original.copyWith(
          userName: 'Ali',
          partnerName: 'Fatima',
          language: 'ar',
        );
        expect(copy.userName, 'Ali');
        expect(copy.partnerName, 'Fatima');
        expect(copy.language, 'ar');
      });
    });

    group('equality', () {
      test('two entities with same values are equal', () {
        const entity1 = OnboardingDataEntity(
          language: 'en',
          userName: 'Test',
        );
        const entity2 = OnboardingDataEntity(
          language: 'en',
          userName: 'Test',
        );
        expect(entity1, equals(entity2));
      });

      test('two entities with different values are not equal', () {
        const entity1 = OnboardingDataEntity(userName: 'Ahmed');
        const entity2 = OnboardingDataEntity(userName: 'Sara');
        expect(entity1, isNot(equals(entity2)));
      });
    });

    group('canComplete', () {
      test('returns false when firebaseUid is null', () {
        const entity = OnboardingDataEntity(
          userName: 'Ahmed',
          partnerName: 'Sara',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, false);
      });

      test('returns false when userName is null', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          partnerName: 'Sara',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, false);
      });

      test('returns false when userName is empty', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          userName: '',
          partnerName: 'Sara',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, false);
      });

      test('returns false when partnerName is null', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          userName: 'Ahmed',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, false);
      });

      test('returns false when partnerName is empty', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          userName: 'Ahmed',
          partnerName: '',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, false);
      });

      test('returns false when relationshipStatus is null', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          userName: 'Ahmed',
          partnerName: 'Sara',
        );
        expect(entity.canComplete, false);
      });

      test('returns true when all required fields are present', () {
        const entity = OnboardingDataEntity(
          firebaseUid: 'uid123',
          userName: 'Ahmed',
          partnerName: 'Sara',
          relationshipStatus: 'married',
        );
        expect(entity.canComplete, true);
      });
    });

    group('completionPercent', () {
      test('returns 0.0 when no optional fields filled', () {
        const entity = OnboardingDataEntity();
        expect(entity.completionPercent, 0.0);
      });

      test('returns correct percent with some fields filled', () {
        const entity = OnboardingDataEntity(
          userName: 'Ahmed',
          partnerName: 'Sara',
          partnerZodiac: 'scorpio',
        );
        // 3 out of 7 fields filled
        expect(entity.completionPercent, closeTo(3 / 7, 0.01));
      });

      test('returns 1.0 when all optional fields filled', () {
        final entity = OnboardingDataEntity(
          userName: 'Ahmed',
          partnerName: 'Sara',
          partnerZodiac: 'scorpio',
          relationshipStatus: 'married',
          keyDate: DateTime(2020, 6, 15),
          keyDateType: 'wedding_date',
          firebaseUid: 'uid123',
        );
        expect(entity.completionPercent, 1.0);
      });

      test('does not count empty userName', () {
        const entity = OnboardingDataEntity(userName: '');
        expect(entity.completionPercent, 0.0);
      });

      test('does not count empty partnerName', () {
        const entity = OnboardingDataEntity(partnerName: '');
        expect(entity.completionPercent, 0.0);
      });
    });
  });
}
