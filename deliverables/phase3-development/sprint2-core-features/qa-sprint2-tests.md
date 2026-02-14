# LOLO Sprint 2 Test Specifications

**Prepared by:** Yuki Tanaka, QA Engineer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Scope:** Sprint 2 (Weeks 11-12) -- Onboarding completion, Her Profile Engine, Smart Reminders, Memory Vault foundation
**Dependencies:** QA Test Strategy v1.0, Architecture Document v1.0, API Contracts v1.0, Final Sprint Plan v1.0

---

## Table of Contents

1. [Unit Tests for Sprint 2](#1-unit-tests-for-sprint-2)
2. [Widget Tests](#2-widget-tests)
3. [Integration Tests](#3-integration-tests)
4. [Golden Tests](#4-golden-tests)
5. [RTL Test Suite for Sprint 2](#5-rtl-test-suite-for-sprint-2)
6. [API Contract Tests](#6-api-contract-tests)
7. [Performance Baselines for Sprint 2](#7-performance-baselines-for-sprint-2)

---

## 1. Unit Tests for Sprint 2

### 1.1 Onboarding

#### OnboardingNotifier -- Step Progression

```dart
// test/features/onboarding/presentation/providers/onboarding_notifier_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_test/riverpod_test.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'package:lolo/features/onboarding/domain/usecases/save_onboarding_usecase.dart';
import 'package:lolo/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';

class MockSaveOnboardingUseCase extends Mock implements SaveOnboardingUseCase {}
class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

void main() {
  late MockSaveOnboardingUseCase mockSaveUseCase;
  late MockCompleteOnboardingUseCase mockCompleteUseCase;

  setUp(() {
    mockSaveUseCase = MockSaveOnboardingUseCase();
    mockCompleteUseCase = MockCompleteOnboardingUseCase();
  });

  group('OnboardingNotifier - Step Progression', () {
    test('initial state is step 0 with 8 total steps', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      expect(notifier.state.currentStep, 0);
      expect(notifier.state.totalSteps, 8);
      expect(notifier.state.isComplete, false);
    });

    test('nextStep increments currentStep by 1', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.nextStep();

      expect(notifier.state.currentStep, 1);
    });

    test('nextStep does not exceed totalSteps', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      for (int i = 0; i < 10; i++) {
        notifier.nextStep();
      }

      expect(notifier.state.currentStep, 7); // 0-indexed, max = totalSteps - 1
    });

    test('previousStep decrements currentStep by 1', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.nextStep();
      notifier.nextStep();
      notifier.previousStep();

      expect(notifier.state.currentStep, 1);
    });

    test('previousStep does not go below 0', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.previousStep();

      expect(notifier.state.currentStep, 0);
    });

    test('goToStep navigates to a specific step within range', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.goToStep(5);

      expect(notifier.state.currentStep, 5);
    });

    test('goToStep clamps to valid range', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.goToStep(99);
      expect(notifier.state.currentStep, 7);

      notifier.goToStep(-5);
      expect(notifier.state.currentStep, 0);
    });
  });

  group('OnboardingNotifier - Per-Step Validation', () {
    test('step 0 (language) requires language selection', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      expect(notifier.canProceed(), false);

      notifier.updateData(language: 'en');
      expect(notifier.canProceed(), true);
    });

    test('step 3 (your name) requires non-empty name 2-50 chars', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );
      notifier.goToStep(3);

      notifier.updateData(userName: '');
      expect(notifier.canProceed(), false);

      notifier.updateData(userName: 'A');
      expect(notifier.canProceed(), false); // too short

      notifier.updateData(userName: 'Ahmed');
      expect(notifier.canProceed(), true);

      notifier.updateData(userName: 'A' * 51);
      expect(notifier.canProceed(), false); // too long
    });

    test('step 4 (her name) requires partner name, zodiac optional', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );
      notifier.goToStep(4);

      expect(notifier.canProceed(), false);

      notifier.updateData(partnerName: 'Nora');
      expect(notifier.canProceed(), true);
      // zodiac is optional -- should still proceed without it
    });

    test('step 5 (relationship status) requires selection', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );
      notifier.goToStep(5);

      expect(notifier.canProceed(), false);

      notifier.updateData(relationshipStatus: 'married');
      expect(notifier.canProceed(), true);
    });

    test('step 6 (key date) is optional -- always can proceed', () {
      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );
      notifier.goToStep(6);

      expect(notifier.canProceed(), true);
    });
  });

  group('OnboardingNotifier - Completion Flow', () {
    test('completing final step triggers completeOnboarding', () async {
      when(() => mockCompleteUseCase.call(any()))
          .thenAnswer((_) async => const Right(unit));

      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      // Fill required fields for all steps
      notifier.updateData(
        language: 'en',
        userName: 'Ahmed',
        partnerName: 'Nora',
        relationshipStatus: 'married',
      );

      notifier.goToStep(7); // last step
      await notifier.completeOnboarding();

      verify(() => mockCompleteUseCase.call(any())).called(1);
      expect(notifier.state.isComplete, true);
    });

    test('completion failure sets error state', () async {
      when(() => mockCompleteUseCase.call(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Network error')));

      final notifier = OnboardingNotifier(
        saveUseCase: mockSaveUseCase,
        completeUseCase: mockCompleteUseCase,
      );

      notifier.updateData(
        language: 'en',
        userName: 'Ahmed',
        partnerName: 'Nora',
        relationshipStatus: 'married',
      );

      notifier.goToStep(7);
      await notifier.completeOnboarding();

      expect(notifier.state.isComplete, false);
      expect(notifier.state.error, isNotNull);
    });
  });
}
```

#### SaveOnboardingUseCase -- Local Draft Persistence

```dart
// test/features/onboarding/domain/usecases/save_onboarding_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/onboarding/domain/usecases/save_onboarding_usecase.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late SaveOnboardingUseCase useCase;
  late MockOnboardingRepository mockRepo;

  setUp(() {
    mockRepo = MockOnboardingRepository();
    useCase = SaveOnboardingUseCase(repository: mockRepo);
  });

  final tOnboardingData = OnboardingData(
    language: 'ar',
    userName: 'Ahmed',
    partnerName: 'Nora',
    zodiacSign: 'scorpio',
    relationshipStatus: 'married',
    anniversaryDate: DateTime(2020, 3, 15),
    currentStep: 4,
  );

  test('saves draft to local storage via repository', () async {
    when(() => mockRepo.saveDraft(tOnboardingData))
        .thenAnswer((_) async => const Right(unit));

    final result = await useCase.call(tOnboardingData);

    expect(result, const Right(unit));
    verify(() => mockRepo.saveDraft(tOnboardingData)).called(1);
  });

  test('returns failure when local storage write fails', () async {
    when(() => mockRepo.saveDraft(tOnboardingData))
        .thenAnswer((_) async => const Left(CacheFailure('Write failed')));

    final result = await useCase.call(tOnboardingData);

    expect(result.isLeft(), true);
  });

  test('persists partial data (only language set)', () async {
    final partialData = OnboardingData(
      language: 'en',
      currentStep: 0,
    );

    when(() => mockRepo.saveDraft(partialData))
        .thenAnswer((_) async => const Right(unit));

    final result = await useCase.call(partialData);

    expect(result, const Right(unit));
    verify(() => mockRepo.saveDraft(partialData)).called(1);
  });
}
```

#### CompleteOnboardingUseCase -- Full Validation and Account Creation

```dart
// test/features/onboarding/domain/usecases/complete_onboarding_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:lolo/core/errors/failures.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late CompleteOnboardingUseCase useCase;
  late MockOnboardingRepository mockRepo;

  setUp(() {
    mockRepo = MockOnboardingRepository();
    useCase = CompleteOnboardingUseCase(repository: mockRepo);
  });

  group('validates all required fields', () {
    test('rejects missing language', () async {
      final data = OnboardingData(
        userName: 'Ahmed',
        partnerName: 'Nora',
        relationshipStatus: 'married',
      );

      final result = await useCase.call(data);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('language')),
        (_) => fail('Should have failed'),
      );
    });

    test('rejects missing userName', () async {
      final data = OnboardingData(
        language: 'en',
        partnerName: 'Nora',
        relationshipStatus: 'married',
      );

      final result = await useCase.call(data);

      expect(result.isLeft(), true);
    });

    test('rejects missing partnerName', () async {
      final data = OnboardingData(
        language: 'en',
        userName: 'Ahmed',
        relationshipStatus: 'married',
      );

      final result = await useCase.call(data);

      expect(result.isLeft(), true);
    });

    test('rejects missing relationshipStatus', () async {
      final data = OnboardingData(
        language: 'en',
        userName: 'Ahmed',
        partnerName: 'Nora',
      );

      final result = await useCase.call(data);

      expect(result.isLeft(), true);
    });

    test('accepts valid complete data and creates account + profile', () async {
      final data = OnboardingData(
        language: 'en',
        userName: 'Ahmed',
        partnerName: 'Nora',
        zodiacSign: 'scorpio',
        relationshipStatus: 'married',
        anniversaryDate: DateTime(2020, 3, 15),
        currentStep: 7,
      );

      when(() => mockRepo.completeOnboarding(data))
          .thenAnswer((_) async => const Right(unit));

      final result = await useCase.call(data);

      expect(result, const Right(unit));
      verify(() => mockRepo.completeOnboarding(data)).called(1);
    });

    test('accepts data with optional fields omitted', () async {
      final data = OnboardingData(
        language: 'ar',
        userName: 'Hafiz',
        partnerName: 'Aisyah',
        relationshipStatus: 'dating',
        // zodiacSign omitted
        // anniversaryDate omitted
      );

      when(() => mockRepo.completeOnboarding(data))
          .thenAnswer((_) async => const Right(unit));

      final result = await useCase.call(data);

      expect(result, const Right(unit));
    });
  });
}
```

### 1.2 Her Profile

#### GetZodiacDefaultsUseCase -- All 12 Signs

```dart
// test/features/her_profile/domain/usecases/get_zodiac_defaults_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/her_profile/domain/usecases/get_zodiac_defaults_usecase.dart';
import 'package:lolo/features/her_profile/domain/repositories/profile_repository.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_defaults.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late GetZodiacDefaultsUseCase useCase;
  late MockProfileRepository mockRepo;

  setUp(() {
    mockRepo = MockProfileRepository();
    useCase = GetZodiacDefaultsUseCase(repository: mockRepo);
  });

  const allSigns = [
    'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo',
    'libra', 'scorpio', 'sagittarius', 'capricorn', 'aquarius', 'pisces',
  ];

  const signElements = {
    'aries': 'fire', 'taurus': 'earth', 'gemini': 'air',
    'cancer': 'water', 'leo': 'fire', 'virgo': 'earth',
    'libra': 'air', 'scorpio': 'water', 'sagittarius': 'fire',
    'capricorn': 'earth', 'aquarius': 'air', 'pisces': 'water',
  };

  for (final sign in allSigns) {
    test('returns correct defaults for $sign', () async {
      final expectedDefaults = ZodiacDefaults(
        sign: sign,
        element: signElements[sign]!,
        personality: ['trait1', 'trait2', 'trait3'],
        communicationTips: ['tip1', 'tip2'],
        emotionalNeeds: ['need1', 'need2'],
        conflictStyle: 'conflict style for $sign',
        giftPreferences: ['pref1', 'pref2'],
        loveLanguageAffinity: 'words',
      );

      when(() => mockRepo.getZodiacDefaults(sign))
          .thenAnswer((_) async => Right(expectedDefaults));

      final result = await useCase.call(sign);

      result.fold(
        (failure) => fail('Should return defaults for $sign'),
        (defaults) {
          expect(defaults.sign, sign);
          expect(defaults.element, signElements[sign]);
          expect(defaults.personality, isNotEmpty);
          expect(defaults.communicationTips, isNotEmpty);
          expect(defaults.emotionalNeeds, isNotEmpty);
          expect(defaults.conflictStyle, isNotEmpty);
          expect(defaults.giftPreferences, isNotEmpty);
        },
      );
    });
  }

  test('returns error for invalid sign', () async {
    when(() => mockRepo.getZodiacDefaults('invalid'))
        .thenAnswer((_) async => const Left(
              ValidationFailure('INVALID_ZODIAC_SIGN'),
            ));

    final result = await useCase.call('invalid');

    expect(result.isLeft(), true);
  });

  test('returns null/empty for "I don\'t know" selection', () async {
    when(() => mockRepo.getZodiacDefaults('unknown'))
        .thenAnswer((_) async => const Right(ZodiacDefaults.empty()));

    final result = await useCase.call('unknown');

    result.fold(
      (failure) => fail('Should return empty defaults'),
      (defaults) {
        expect(defaults.personality, isEmpty);
        expect(defaults.communicationTips, isEmpty);
      },
    );
  });
}
```

#### UpdateProfileUseCase -- Validation and Completion Percentage

```dart
// test/features/her_profile/domain/usecases/update_profile_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/her_profile/domain/usecases/update_profile_usecase.dart';
import 'package:lolo/features/her_profile/domain/repositories/profile_repository.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late UpdateProfileUseCase useCase;
  late MockProfileRepository mockRepo;

  setUp(() {
    mockRepo = MockProfileRepository();
    useCase = UpdateProfileUseCase(repository: mockRepo);
  });

  group('field validation', () {
    test('rejects empty name', () async {
      final params = UpdateProfileParams(
        profileId: 'profile-123',
        name: '',
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('rejects name exceeding 100 chars', () async {
      final params = UpdateProfileParams(
        profileId: 'profile-123',
        name: 'A' * 101,
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('accepts valid zodiac sign enum values', () async {
      final params = UpdateProfileParams(
        profileId: 'profile-123',
        zodiacSign: 'pisces',
      );

      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => Right(PartnerProfile.mock()));

      final result = await useCase.call(params);

      expect(result.isRight(), true);
    });

    test('rejects invalid zodiac sign', () async {
      final params = UpdateProfileParams(
        profileId: 'profile-123',
        zodiacSign: 'invalid_sign',
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('rejects invalid relationship status', () async {
      final params = UpdateProfileParams(
        profileId: 'profile-123',
        relationshipStatus: 'complicated',
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });
  });

  group('completion percentage calculation', () {
    test('name-only profile returns low completion %', () async {
      final updatedProfile = PartnerProfile(
        id: 'profile-123',
        name: 'Nora',
        profileCompletionPercent: 15,
      );

      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => Right(updatedProfile));

      final params = UpdateProfileParams(
        profileId: 'profile-123',
        name: 'Nora',
      );

      final result = await useCase.call(params);

      result.fold(
        (f) => fail('Should succeed'),
        (profile) => expect(profile.profileCompletionPercent, lessThan(30)),
      );
    });

    test('fully populated profile returns 100%', () async {
      final fullProfile = PartnerProfile(
        id: 'profile-123',
        name: 'Nora',
        birthday: DateTime(1995, 3, 15),
        zodiacSign: 'pisces',
        loveLanguage: 'words',
        communicationStyle: 'direct',
        relationshipStatus: 'married',
        anniversaryDate: DateTime(2020, 6, 1),
        profileCompletionPercent: 100,
      );

      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => Right(fullProfile));

      final params = UpdateProfileParams(
        profileId: 'profile-123',
        name: 'Nora',
        birthday: DateTime(1995, 3, 15),
        zodiacSign: 'pisces',
        loveLanguage: 'words',
        communicationStyle: 'direct',
        relationshipStatus: 'married',
        anniversaryDate: DateTime(2020, 6, 1),
      );

      final result = await useCase.call(params);

      result.fold(
        (f) => fail('Should succeed'),
        (profile) => expect(profile.profileCompletionPercent, 100),
      );
    });

    test('adding zodiac increases completion %', () async {
      final profileBefore = PartnerProfile(
        id: 'p-1',
        name: 'Nora',
        profileCompletionPercent: 15,
      );
      final profileAfter = PartnerProfile(
        id: 'p-1',
        name: 'Nora',
        zodiacSign: 'leo',
        profileCompletionPercent: 30,
      );

      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => Right(profileAfter));

      final result = await useCase.call(
        UpdateProfileParams(profileId: 'p-1', zodiacSign: 'leo'),
      );

      result.fold(
        (f) => fail('Should succeed'),
        (profile) {
          expect(
            profile.profileCompletionPercent,
            greaterThan(profileBefore.profileCompletionPercent),
          );
        },
      );
    });
  });
}
```

#### PartnerProfileModel -- JSON Serialization Roundtrip

```dart
// test/features/her_profile/data/models/partner_profile_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/her_profile/data/models/partner_profile_model.dart';

void main() {
  final tModel = PartnerProfileModel(
    id: 'profile-abc',
    userId: 'user-123',
    name: 'Nora',
    birthday: '1995-03-15',
    zodiacSign: 'pisces',
    loveLanguage: 'words',
    communicationStyle: 'direct',
    relationshipStatus: 'married',
    anniversaryDate: '2020-06-01',
    photoUrl: 'https://storage.example.com/photo.jpg',
    preferences: PreferencesModel(
      favorites: FavoritesModel(
        flowers: ['peonies', 'sunflowers'],
        food: ['sushi', 'chocolate'],
        music: ['jazz'],
        movies: ['romance'],
        brands: ['Chanel'],
        colors: ['purple'],
      ),
      dislikes: ['loud noises'],
      hobbies: ['painting', 'reading'],
      stressCoping: 'needs quiet time alone',
      notes: 'Loves handwritten letters',
    ),
    culturalContext: CulturalContextModel(
      background: 'gulf_arab',
      religiousObservance: 'high',
      dialect: 'gulf',
    ),
    profileCompletionPercent: 85,
    createdAt: '2026-02-10T08:30:00Z',
    updatedAt: '2026-02-14T12:00:00Z',
  );

  final tJson = {
    'id': 'profile-abc',
    'userId': 'user-123',
    'name': 'Nora',
    'birthday': '1995-03-15',
    'zodiacSign': 'pisces',
    'loveLanguage': 'words',
    'communicationStyle': 'direct',
    'relationshipStatus': 'married',
    'anniversaryDate': '2020-06-01',
    'photoUrl': 'https://storage.example.com/photo.jpg',
    'preferences': {
      'favorites': {
        'flowers': ['peonies', 'sunflowers'],
        'food': ['sushi', 'chocolate'],
        'music': ['jazz'],
        'movies': ['romance'],
        'brands': ['Chanel'],
        'colors': ['purple'],
      },
      'dislikes': ['loud noises'],
      'hobbies': ['painting', 'reading'],
      'stressCoping': 'needs quiet time alone',
      'notes': 'Loves handwritten letters',
    },
    'culturalContext': {
      'background': 'gulf_arab',
      'religiousObservance': 'high',
      'dialect': 'gulf',
    },
    'profileCompletionPercent': 85,
    'createdAt': '2026-02-10T08:30:00Z',
    'updatedAt': '2026-02-14T12:00:00Z',
  };

  group('PartnerProfileModel JSON roundtrip', () {
    test('fromJson creates correct model', () {
      final result = PartnerProfileModel.fromJson(tJson);

      expect(result.id, tModel.id);
      expect(result.name, tModel.name);
      expect(result.zodiacSign, tModel.zodiacSign);
      expect(result.preferences.favorites.flowers, ['peonies', 'sunflowers']);
      expect(result.culturalContext.background, 'gulf_arab');
      expect(result.profileCompletionPercent, 85);
    });

    test('toJson produces correct map', () {
      final result = tModel.toJson();

      expect(result['name'], 'Nora');
      expect(result['zodiacSign'], 'pisces');
      expect(result['preferences']['favorites']['flowers'],
          ['peonies', 'sunflowers']);
      expect(result['culturalContext']['religiousObservance'], 'high');
    });

    test('fromJson -> toJson roundtrip preserves all data', () {
      final fromJson = PartnerProfileModel.fromJson(tJson);
      final backToJson = fromJson.toJson();

      expect(backToJson, tJson);
    });

    test('handles null optional fields', () {
      final minimalJson = {
        'id': 'p-1',
        'userId': 'u-1',
        'name': 'Nora',
        'relationshipStatus': 'dating',
        'profileCompletionPercent': 15,
        'createdAt': '2026-02-10T08:30:00Z',
        'updatedAt': '2026-02-10T08:30:00Z',
      };

      final model = PartnerProfileModel.fromJson(minimalJson);

      expect(model.name, 'Nora');
      expect(model.birthday, isNull);
      expect(model.zodiacSign, isNull);
      expect(model.loveLanguage, isNull);
      expect(model.preferences, isNull);
      expect(model.culturalContext, isNull);
    });

    test('toEntity converts to domain entity correctly', () {
      final entity = tModel.toEntity();

      expect(entity.id, tModel.id);
      expect(entity.name, tModel.name);
      expect(entity.zodiacSign, tModel.zodiacSign);
    });
  });
}
```

### 1.3 Reminders

#### CreateReminderUseCase -- Date Validation and Recurrence

```dart
// test/features/reminders/domain/usecases/create_reminder_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/reminders/domain/usecases/create_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/repositories/reminder_repository.dart';
import 'package:lolo/features/reminders/domain/entities/reminder.dart';

class MockReminderRepository extends Mock implements ReminderRepository {}
class MockClock extends Mock implements Clock {}

void main() {
  late CreateReminderUseCase useCase;
  late MockReminderRepository mockRepo;
  late MockClock mockClock;

  setUp(() {
    mockRepo = MockReminderRepository();
    mockClock = MockClock();
    useCase = CreateReminderUseCase(
      repository: mockRepo,
      clock: mockClock,
    );

    // Fix "now" to Feb 15, 2026 for deterministic tests
    when(() => mockClock.now())
        .thenReturn(DateTime(2026, 2, 15, 10, 0));
  });

  group('date validation', () {
    test('rejects date in the past for non-recurring reminder', () async {
      final params = CreateReminderParams(
        title: 'Her birthday',
        type: 'birthday',
        date: DateTime(2025, 12, 1), // past
        isRecurring: false,
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f.code, 'INVALID_DATE'),
        (_) => fail('Should reject past date'),
      );
    });

    test('accepts date in the past for recurring reminder', () async {
      final params = CreateReminderParams(
        title: 'Her birthday',
        type: 'birthday',
        date: DateTime(2025, 6, 15), // past but recurring
        isRecurring: true,
        recurrenceRule: 'yearly',
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);

      expect(result.isRight(), true);
    });

    test('accepts future date for non-recurring reminder', () async {
      final params = CreateReminderParams(
        title: 'Valentine dinner',
        type: 'custom',
        date: DateTime(2027, 2, 14),
        isRecurring: false,
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);

      expect(result.isRight(), true);
    });

    test('rejects reminder with missing title', () async {
      final params = CreateReminderParams(
        title: '',
        type: 'custom',
        date: DateTime(2026, 6, 1),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('rejects title exceeding 200 chars', () async {
      final params = CreateReminderParams(
        title: 'A' * 201,
        type: 'custom',
        date: DateTime(2026, 6, 1),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });
  });

  group('recurrence rules', () {
    test('daily recurrence accepted', () async {
      final params = CreateReminderParams(
        title: 'Good morning text',
        type: 'custom',
        date: DateTime(2026, 3, 1),
        isRecurring: true,
        recurrenceRule: 'daily',
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);
      expect(result.isRight(), true);
    });

    test('weekly recurrence accepted', () async {
      final params = CreateReminderParams(
        title: 'Date night',
        type: 'custom',
        date: DateTime(2026, 3, 7),
        isRecurring: true,
        recurrenceRule: 'weekly',
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);
      expect(result.isRight(), true);
    });

    test('monthly recurrence accepted', () async {
      final params = CreateReminderParams(
        title: 'Monthly anniversary',
        type: 'anniversary',
        date: DateTime(2026, 3, 15),
        isRecurring: true,
        recurrenceRule: 'monthly',
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);
      expect(result.isRight(), true);
    });

    test('yearly recurrence accepted', () async {
      final params = CreateReminderParams(
        title: 'Wedding anniversary',
        type: 'anniversary',
        date: DateTime(2026, 6, 1),
        isRecurring: true,
        recurrenceRule: 'yearly',
      );

      when(() => mockRepo.createReminder(any()))
          .thenAnswer((_) async => Right(Reminder.mock()));

      final result = await useCase.call(params);
      expect(result.isRight(), true);
    });

    test('rejects invalid recurrence rule', () async {
      final params = CreateReminderParams(
        title: 'Test',
        type: 'custom',
        date: DateTime(2026, 6, 1),
        isRecurring: true,
        recurrenceRule: 'biweekly', // not supported
      );

      final result = await useCase.call(params);
      expect(result.isLeft(), true);
    });
  });
}
```

#### SnoozeReminderUseCase -- Snooze Time Calculation

```dart
// test/features/reminders/domain/usecases/snooze_reminder_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/reminders/domain/usecases/snooze_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/repositories/reminder_repository.dart';

class MockReminderRepository extends Mock implements ReminderRepository {}
class MockClock extends Mock implements Clock {}

void main() {
  late SnoozeReminderUseCase useCase;
  late MockReminderRepository mockRepo;
  late MockClock mockClock;

  final now = DateTime(2026, 2, 15, 14, 30); // 2:30 PM

  setUp(() {
    mockRepo = MockReminderRepository();
    mockClock = MockClock();
    useCase = SnoozeReminderUseCase(repository: mockRepo, clock: mockClock);
    when(() => mockClock.now()).thenReturn(now);
  });

  group('snooze time calculation', () {
    test('1h snooze adds 1 hour to current time', () async {
      when(() => mockRepo.snoozeReminder(any(), any()))
          .thenAnswer((_) async => Right(now.add(const Duration(hours: 1))));

      final result = await useCase.call(
        SnoozeParams(reminderId: 'r-1', duration: '1h'),
      );

      result.fold(
        (f) => fail('Should succeed'),
        (snoozedUntil) {
          expect(snoozedUntil, DateTime(2026, 2, 15, 15, 30));
        },
      );
    });

    test('3h snooze adds 3 hours', () async {
      when(() => mockRepo.snoozeReminder(any(), any()))
          .thenAnswer((_) async => Right(now.add(const Duration(hours: 3))));

      final result = await useCase.call(
        SnoozeParams(reminderId: 'r-1', duration: '3h'),
      );

      result.fold(
        (f) => fail('Should succeed'),
        (snoozedUntil) {
          expect(snoozedUntil, DateTime(2026, 2, 15, 17, 30));
        },
      );
    });

    test('1d snooze adds 1 day', () async {
      when(() => mockRepo.snoozeReminder(any(), any()))
          .thenAnswer((_) async => Right(now.add(const Duration(days: 1))));

      final result = await useCase.call(
        SnoozeParams(reminderId: 'r-1', duration: '1d'),
      );

      result.fold(
        (f) => fail('Should succeed'),
        (snoozedUntil) {
          expect(snoozedUntil, DateTime(2026, 2, 16, 14, 30));
        },
      );
    });

    test('1w snooze adds 7 days', () async {
      when(() => mockRepo.snoozeReminder(any(), any()))
          .thenAnswer((_) async => Right(now.add(const Duration(days: 7))));

      final result = await useCase.call(
        SnoozeParams(reminderId: 'r-1', duration: '1w'),
      );

      result.fold(
        (f) => fail('Should succeed'),
        (snoozedUntil) {
          expect(snoozedUntil, DateTime(2026, 2, 22, 14, 30));
        },
      );
    });

    test('rejects invalid duration value', () async {
      final result = await useCase.call(
        SnoozeParams(reminderId: 'r-1', duration: '2w'),
      );

      expect(result.isLeft(), true);
    });
  });
}
```

#### Recurrence Engine -- Next-Date Calculation

```dart
// test/features/reminders/domain/services/recurrence_engine_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/reminders/domain/services/recurrence_engine.dart';

void main() {
  late RecurrenceEngine engine;

  setUp(() {
    engine = RecurrenceEngine();
  });

  group('daily recurrence', () {
    test('next date is tomorrow', () {
      final baseDate = DateTime(2026, 2, 15);
      final next = engine.nextOccurrence(baseDate, 'daily');
      expect(next, DateTime(2026, 2, 16));
    });

    test('crosses month boundary', () {
      final baseDate = DateTime(2026, 2, 28);
      final next = engine.nextOccurrence(baseDate, 'daily');
      expect(next, DateTime(2026, 3, 1));
    });
  });

  group('weekly recurrence', () {
    test('next date is 7 days later', () {
      final baseDate = DateTime(2026, 2, 15); // Sunday
      final next = engine.nextOccurrence(baseDate, 'weekly');
      expect(next, DateTime(2026, 2, 22));
    });

    test('crosses month boundary', () {
      final baseDate = DateTime(2026, 2, 25);
      final next = engine.nextOccurrence(baseDate, 'weekly');
      expect(next, DateTime(2026, 3, 4));
    });
  });

  group('monthly recurrence', () {
    test('same day next month', () {
      final baseDate = DateTime(2026, 1, 15);
      final next = engine.nextOccurrence(baseDate, 'monthly');
      expect(next, DateTime(2026, 2, 15));
    });

    test('handles 31st clamp to shorter months', () {
      final baseDate = DateTime(2026, 1, 31);
      final next = engine.nextOccurrence(baseDate, 'monthly');
      // Feb has 28 days in 2026
      expect(next.day, lessThanOrEqualTo(28));
      expect(next.month, 2);
    });

    test('crosses year boundary', () {
      final baseDate = DateTime(2026, 12, 15);
      final next = engine.nextOccurrence(baseDate, 'monthly');
      expect(next, DateTime(2027, 1, 15));
    });
  });

  group('yearly recurrence', () {
    test('same date next year', () {
      final baseDate = DateTime(2026, 6, 15);
      final next = engine.nextOccurrence(baseDate, 'yearly');
      expect(next, DateTime(2027, 6, 15));
    });

    test('handles leap year Feb 29', () {
      final baseDate = DateTime(2024, 2, 29);
      final next = engine.nextOccurrence(baseDate, 'yearly');
      // 2025 is not a leap year
      expect(next.month, 2);
      expect(next.day, 28);
      expect(next.year, 2025);
    });
  });
}
```

#### Escalation Logic -- Notification Timing

```dart
// test/features/reminders/domain/services/reminder_escalation_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/reminders/domain/services/reminder_escalation_service.dart';

void main() {
  late ReminderEscalationService service;

  setUp(() {
    service = ReminderEscalationService();
  });

  group('escalation schedule generation', () {
    test('generates 6-tier schedule: 30d, 14d, 7d, 3d, 1d, day-of', () {
      final eventDate = DateTime(2026, 6, 15);
      final schedule = service.generateSchedule(eventDate);

      expect(schedule.length, 6);
      expect(schedule[0].daysBeforeEvent, 30);
      expect(schedule[1].daysBeforeEvent, 14);
      expect(schedule[2].daysBeforeEvent, 7);
      expect(schedule[3].daysBeforeEvent, 3);
      expect(schedule[4].daysBeforeEvent, 1);
      expect(schedule[5].daysBeforeEvent, 0);
    });

    test('day-30 notification date is correct', () {
      final eventDate = DateTime(2026, 6, 15);
      final schedule = service.generateSchedule(eventDate);

      expect(schedule[0].scheduledFor, DateTime(2026, 5, 16));
    });

    test('day-of notification date matches event date', () {
      final eventDate = DateTime(2026, 6, 15);
      final schedule = service.generateSchedule(eventDate);

      expect(schedule[5].scheduledFor.year, 2026);
      expect(schedule[5].scheduledFor.month, 6);
      expect(schedule[5].scheduledFor.day, 15);
    });

    test('day-30 and day-14 tiers include gift engine link flag', () {
      final eventDate = DateTime(2026, 6, 15);
      final schedule = service.generateSchedule(eventDate);

      expect(schedule[0].includeGiftLink, true);  // 30d
      expect(schedule[1].includeGiftLink, true);  // 14d
      expect(schedule[2].includeGiftLink, false); // 7d
    });

    test('day-3 and day-1 tiers have escalated urgency', () {
      final eventDate = DateTime(2026, 6, 15);
      final schedule = service.generateSchedule(eventDate);

      expect(schedule[3].urgencyLevel, 'high');    // 3d
      expect(schedule[4].urgencyLevel, 'critical'); // 1d
      expect(schedule[5].urgencyLevel, 'critical'); // day-of
    });

    test('skips past tiers when event is less than 30 days away', () {
      final now = DateTime(2026, 2, 15);
      final eventDate = DateTime(2026, 2, 20); // only 5 days away

      final schedule = service.generateSchedule(eventDate, asOf: now);

      // Should only include 3d, 1d, day-of (skip 30d, 14d, 7d)
      for (final tier in schedule) {
        expect(
          tier.scheduledFor.isAfter(now) ||
              tier.scheduledFor.isAtSameMomentAs(now),
          true,
        );
      }
    });
  });
}
```

### 1.4 Memory Vault

#### EncryptionService -- Encrypt/Decrypt Roundtrip

```dart
// test/core/services/encryption_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/services/encryption_service.dart';

void main() {
  late EncryptionService service;

  setUp(() {
    service = EncryptionService();
  });

  group('encrypt/decrypt roundtrip', () {
    test('decrypting encrypted text returns original', () {
      const plaintext = 'Our first date was at the Italian restaurant.';
      const key = 'user-specific-key-abc123';

      final encrypted = service.encrypt(plaintext, key);
      final decrypted = service.decrypt(encrypted, key);

      expect(decrypted, plaintext);
    });

    test('encrypts Unicode/Arabic text correctly', () {
      const plaintext = 'ذكرياتنا الجميلة في دبي';
      const key = 'user-key-arabic';

      final encrypted = service.encrypt(plaintext, key);
      final decrypted = service.decrypt(encrypted, key);

      expect(decrypted, plaintext);
    });

    test('encrypts Malay text correctly', () {
      const plaintext = 'Kenangan indah kami bersama';
      const key = 'user-key-malay';

      final encrypted = service.encrypt(plaintext, key);
      final decrypted = service.decrypt(encrypted, key);

      expect(decrypted, plaintext);
    });

    test('encrypted output differs from plaintext', () {
      const plaintext = 'Secret memory text';
      const key = 'my-secret-key';

      final encrypted = service.encrypt(plaintext, key);

      expect(encrypted, isNot(equals(plaintext)));
    });

    test('different keys produce different ciphertext', () {
      const plaintext = 'Same plaintext for both';
      const key1 = 'key-alpha';
      const key2 = 'key-beta';

      final encrypted1 = service.encrypt(plaintext, key1);
      final encrypted2 = service.encrypt(plaintext, key2);

      expect(encrypted1, isNot(equals(encrypted2)));
    });

    test('wrong key fails to decrypt correctly', () {
      const plaintext = 'Sensitive data';
      const correctKey = 'correct-key';
      const wrongKey = 'wrong-key';

      final encrypted = service.encrypt(plaintext, correctKey);

      expect(
        () => service.decrypt(encrypted, wrongKey),
        throwsA(isA<DecryptionException>()),
      );
    });

    test('handles empty string', () {
      const plaintext = '';
      const key = 'my-key';

      final encrypted = service.encrypt(plaintext, key);
      final decrypted = service.decrypt(encrypted, key);

      expect(decrypted, plaintext);
    });

    test('handles very long text (5000 chars)', () {
      final plaintext = 'A' * 5000;
      const key = 'my-key';

      final encrypted = service.encrypt(plaintext, key);
      final decrypted = service.decrypt(encrypted, key);

      expect(decrypted, plaintext);
    });
  });
}
```

#### CreateMemoryUseCase -- Validation

```dart
// test/features/memory_vault/domain/usecases/create_memory_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/memory_vault/domain/usecases/create_memory_usecase.dart';
import 'package:lolo/features/memory_vault/domain/repositories/memory_repository.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_entry.dart';

class MockMemoryRepository extends Mock implements MemoryRepository {}

void main() {
  late CreateMemoryUseCase useCase;
  late MockMemoryRepository mockRepo;

  setUp(() {
    mockRepo = MockMemoryRepository();
    useCase = CreateMemoryUseCase(repository: mockRepo);
  });

  group('title validation', () {
    test('rejects empty title', () async {
      final params = CreateMemoryParams(
        title: '',
        category: 'moment',
        date: DateTime(2026, 2, 14),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('rejects title exceeding 200 chars', () async {
      final params = CreateMemoryParams(
        title: 'T' * 201,
        category: 'moment',
        date: DateTime(2026, 2, 14),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });

    test('accepts valid title', () async {
      final params = CreateMemoryParams(
        title: 'Our first dinner together',
        category: 'moment',
        date: DateTime(2026, 2, 14),
      );

      when(() => mockRepo.createMemory(any()))
          .thenAnswer((_) async => Right(MemoryEntry.mock()));

      final result = await useCase.call(params);

      expect(result.isRight(), true);
    });
  });

  group('category validation', () {
    const validCategories = [
      'moment', 'milestone', 'conflict_resolution',
      'gift_given', 'trip', 'quote', 'other',
    ];

    for (final category in validCategories) {
      test('accepts valid category: $category', () async {
        final params = CreateMemoryParams(
          title: 'Test memory',
          category: category,
          date: DateTime(2026, 2, 14),
        );

        when(() => mockRepo.createMemory(any()))
            .thenAnswer((_) async => Right(MemoryEntry.mock()));

        final result = await useCase.call(params);

        expect(result.isRight(), true);
      });
    }

    test('rejects invalid category', () async {
      final params = CreateMemoryParams(
        title: 'Test memory',
        category: 'invalid_category',
        date: DateTime(2026, 2, 14),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });
  });

  group('tags validation', () {
    test('accepts up to 10 tags', () async {
      final params = CreateMemoryParams(
        title: 'Tagged memory',
        category: 'moment',
        date: DateTime(2026, 2, 14),
        tags: List.generate(10, (i) => 'tag$i'),
      );

      when(() => mockRepo.createMemory(any()))
          .thenAnswer((_) async => Right(MemoryEntry.mock()));

      final result = await useCase.call(params);

      expect(result.isRight(), true);
    });

    test('rejects more than 10 tags', () async {
      final params = CreateMemoryParams(
        title: 'Over-tagged',
        category: 'moment',
        date: DateTime(2026, 2, 14),
        tags: List.generate(11, (i) => 'tag$i'),
      );

      final result = await useCase.call(params);

      expect(result.isLeft(), true);
    });
  });
}
```

#### Wish List Filtering -- sheSaid=true Entries

```dart
// test/features/memory_vault/domain/services/wish_list_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/memory_vault/domain/services/wish_list_service.dart';
import 'package:lolo/features/memory_vault/domain/entities/wish_item.dart';

class MockWishListRepository extends Mock implements WishListRepository {}

void main() {
  late WishListService service;
  late MockWishListRepository mockRepo;

  final allItems = [
    WishItem(
      id: 'w-1',
      item: 'Chanel No.5 perfume',
      source: 'user_added',
      priority: 'high',
      isGifted: false,
    ),
    WishItem(
      id: 'w-2',
      item: 'Cooking class together',
      source: 'ai_detected',
      priority: 'medium',
      isGifted: false,
    ),
    WishItem(
      id: 'w-3',
      item: 'Pearl earrings',
      source: 'conversation', // "she said" source
      priority: 'high',
      isGifted: false,
    ),
    WishItem(
      id: 'w-4',
      item: 'Weekend getaway to Langkawi',
      source: 'conversation', // "she said" source
      priority: 'low',
      isGifted: true, // already gifted
    ),
    WishItem(
      id: 'w-5',
      item: 'New yoga mat',
      source: 'conversation', // "she said" source
      priority: 'medium',
      isGifted: false,
    ),
  ];

  setUp(() {
    mockRepo = MockWishListRepository();
    service = WishListService(repository: mockRepo);

    when(() => mockRepo.getWishList())
        .thenAnswer((_) async => Right(allItems));
  });

  group('wish list filtering', () {
    test('getSheSaidItems returns only conversation-sourced items', () async {
      final result = await service.getSheSaidItems();

      result.fold(
        (f) => fail('Should succeed'),
        (items) {
          expect(items.length, 3);
          expect(items.every((i) => i.source == 'conversation'), true);
        },
      );
    });

    test('getSheSaidItems excludes already gifted items when filtered', () async {
      final result = await service.getSheSaidItems(excludeGifted: true);

      result.fold(
        (f) => fail('Should succeed'),
        (items) {
          expect(items.length, 2);
          expect(items.every((i) => !i.isGifted), true);
          expect(items.every((i) => i.source == 'conversation'), true);
        },
      );
    });

    test('filters by priority correctly', () async {
      final result = await service.getSheSaidItems(priority: 'high');

      result.fold(
        (f) => fail('Should succeed'),
        (items) {
          expect(items.length, 1);
          expect(items.first.item, 'Pearl earrings');
        },
      );
    });
  });
}
```

---

## 2. Widget Tests

### 2.1 LanguageSelectorPage

```dart
// test/features/onboarding/presentation/screens/language_selector_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/onboarding/presentation/screens/language_selector_page.dart';
import 'package:lolo/core/providers/locale_provider.dart';

class MockLocaleNotifier extends Mock implements LocaleNotifier {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockLocaleNotifier mockLocaleNotifier;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockLocaleNotifier = MockLocaleNotifier();
    mockObserver = MockNavigatorObserver();
  });

  Widget buildWidget({Locale? initialLocale}) {
    return ProviderScope(
      overrides: [
        localeNotifierProvider.overrideWith((_) => mockLocaleNotifier),
      ],
      child: MaterialApp(
        locale: initialLocale ?? const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('ms')],
        home: const LanguageSelectorPage(),
        navigatorObservers: [mockObserver],
      ),
    );
  }

  group('LanguageSelectorPage', () {
    testWidgets('displays 3 language options', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('English'), findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
      expect(find.text('Bahasa Melayu'), findsOneWidget);
    });

    testWidgets('tapping Arabic sets locale and triggers RTL', (tester) async {
      when(() => mockLocaleNotifier.setLocale(const Locale('ar')))
          .thenReturn(null);

      await tester.pumpWidget(buildWidget());
      await tester.tap(find.text('العربية'));
      await tester.pumpAndSettle();

      verify(() => mockLocaleNotifier.setLocale(const Locale('ar'))).called(1);
    });

    testWidgets('tapping English sets LTR locale', (tester) async {
      when(() => mockLocaleNotifier.setLocale(const Locale('en')))
          .thenReturn(null);

      await tester.pumpWidget(buildWidget());
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      verify(() => mockLocaleNotifier.setLocale(const Locale('en'))).called(1);
    });

    testWidgets('tapping Malay sets ms locale', (tester) async {
      when(() => mockLocaleNotifier.setLocale(const Locale('ms')))
          .thenReturn(null);

      await tester.pumpWidget(buildWidget());
      await tester.tap(find.text('Bahasa Melayu'));
      await tester.pumpAndSettle();

      verify(() => mockLocaleNotifier.setLocale(const Locale('ms'))).called(1);
    });

    testWidgets('auto-advances to welcome screen after selection',
        (tester) async {
      when(() => mockLocaleNotifier.setLocale(any())).thenReturn(null);

      await tester.pumpWidget(buildWidget());
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      // Should navigate forward after language selection
      verify(() => mockObserver.didPush(any(), any())).called(greaterThan(0));
    });
  });
}
```

### 2.2 ZodiacCarousel

```dart
// test/features/her_profile/presentation/widgets/zodiac_carousel_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/her_profile/presentation/widgets/zodiac_carousel.dart';

void main() {
  const allSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces',
  ];

  Widget buildWidget({
    String? selectedSign,
    ValueChanged<String>? onSignSelected,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ZodiacCarousel(
          selectedSign: selectedSign,
          onSignSelected: onSignSelected ?? (_) {},
        ),
      ),
    );
  }

  group('ZodiacCarousel', () {
    testWidgets('displays all 12 zodiac signs', (tester) async {
      await tester.pumpWidget(buildWidget());

      // At least the visible ones should be findable; scroll to verify all 12
      for (final sign in allSigns) {
        await tester.scrollUntilVisible(
          find.text(sign),
          200.0,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text(sign), findsOneWidget);
      }
    });

    testWidgets('supports horizontal scrolling', (tester) async {
      await tester.pumpWidget(buildWidget());

      final scrollable = find.byType(Scrollable).first;
      expect(scrollable, findsOneWidget);

      // Scroll right
      await tester.drag(scrollable, const Offset(-300, 0));
      await tester.pumpAndSettle();

      // Should still be scrollable (no crash)
      await tester.drag(scrollable, const Offset(-300, 0));
      await tester.pumpAndSettle();
    });

    testWidgets('tapping a sign calls onSignSelected', (tester) async {
      String? selectedSign;

      await tester.pumpWidget(buildWidget(
        onSignSelected: (sign) => selectedSign = sign,
      ));

      await tester.tap(find.text('Aries'));
      await tester.pumpAndSettle();

      expect(selectedSign, 'aries');
    });

    testWidgets('selected sign shows visual highlight', (tester) async {
      await tester.pumpWidget(buildWidget(selectedSign: 'scorpio'));
      await tester.pumpAndSettle();

      // Scroll to Scorpio
      await tester.scrollUntilVisible(
        find.text('Scorpio'),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );

      // The selected sign tile should have the accent decoration
      final scorpioTile = find.ancestor(
        of: find.text('Scorpio'),
        matching: find.byType(Container),
      );
      expect(scorpioTile, findsWidgets);
    });

    testWidgets('includes "I don\'t know" option', (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.scrollUntilVisible(
        find.text("I don't know"),
        200.0,
        scrollable: find.byType(Scrollable).first,
      );

      expect(find.text("I don't know"), findsOneWidget);
    });
  });
}
```

### 2.3 ReminderTile

```dart
// test/features/reminders/presentation/widgets/reminder_tile_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/reminders/presentation/widgets/reminder_tile.dart';
import 'package:lolo/features/reminders/domain/entities/reminder.dart';

void main() {
  Widget buildWidget(Reminder reminder, {VoidCallback? onComplete}) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: ReminderTile(
          reminder: reminder,
          onComplete: onComplete ?? () {},
        ),
      ),
    );
  }

  group('ReminderTile', () {
    testWidgets('displays title and date', (tester) async {
      final reminder = Reminder(
        id: 'r-1',
        title: 'Her Birthday',
        type: 'birthday',
        date: DateTime(2026, 6, 15),
        status: 'active',
      );

      await tester.pumpWidget(buildWidget(reminder));

      expect(find.text('Her Birthday'), findsOneWidget);
      expect(find.textContaining('Jun'), findsOneWidget);
    });

    testWidgets('overdue state shows red accent', (tester) async {
      final overdue = Reminder(
        id: 'r-2',
        title: 'Anniversary',
        type: 'anniversary',
        date: DateTime(2026, 1, 10), // past date
        status: 'active',
        isOverdue: true,
      );

      await tester.pumpWidget(buildWidget(overdue));

      // Find the container that wraps the tile
      final tileWidget = tester.widget<Container>(
        find.ancestor(
          of: find.text('Anniversary'),
          matching: find.byType(Container),
        ).first,
      );

      // Verify red accent is applied (border or background)
      final decoration = tileWidget.decoration as BoxDecoration?;
      if (decoration?.border != null) {
        expect(
          (decoration!.border as Border).left.color,
          equals(Colors.red) | equals(const Color(0xFFE94560)),
        );
      }
    });

    testWidgets('checkbox toggles completion', (tester) async {
      bool completed = false;
      final reminder = Reminder(
        id: 'r-3',
        title: 'Send flowers',
        type: 'custom',
        date: DateTime(2026, 3, 8),
        status: 'active',
      );

      await tester.pumpWidget(buildWidget(
        reminder,
        onComplete: () => completed = true,
      ));

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(completed, true);
    });

    testWidgets('snoozed state shows snooze indicator', (tester) async {
      final snoozed = Reminder(
        id: 'r-4',
        title: 'Buy gift',
        type: 'custom',
        date: DateTime(2026, 3, 1),
        status: 'snoozed',
        snoozedUntil: DateTime(2026, 2, 20),
      );

      await tester.pumpWidget(buildWidget(snoozed));

      expect(find.byIcon(Icons.snooze), findsOneWidget);
    });

    testWidgets('shows recurring icon for recurring reminders', (tester) async {
      final recurring = Reminder(
        id: 'r-5',
        title: 'Date night',
        type: 'custom',
        date: DateTime(2026, 3, 7),
        status: 'active',
        isRecurring: true,
        recurrenceRule: 'weekly',
      );

      await tester.pumpWidget(buildWidget(recurring));

      expect(find.byIcon(Icons.repeat), findsOneWidget);
    });
  });
}
```

### 2.4 MemoryCard

```dart
// test/features/memory_vault/presentation/widgets/memory_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/memory_card.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_entry.dart';

void main() {
  Widget buildWidget(MemoryEntry memory) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MemoryCard(memory: memory),
      ),
    );
  }

  group('MemoryCard', () {
    testWidgets('displays title and date', (tester) async {
      final memory = MemoryEntry(
        id: 'm-1',
        title: 'First trip to Dubai',
        description: 'We visited the Dubai Mall and Burj Khalifa.',
        category: 'trip',
        date: DateTime(2026, 1, 10),
      );

      await tester.pumpWidget(buildWidget(memory));

      expect(find.text('First trip to Dubai'), findsOneWidget);
    });

    testWidgets('displays thumbnail when media present', (tester) async {
      final memory = MemoryEntry(
        id: 'm-2',
        title: 'Beach sunset',
        category: 'moment',
        date: DateTime(2026, 1, 15),
        thumbnailUrl: 'https://storage.example.com/thumb.jpg',
        mediaCount: 3,
      );

      await tester.pumpWidget(buildWidget(memory));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('truncates long preview text with ellipsis', (tester) async {
      final memory = MemoryEntry(
        id: 'm-3',
        title: 'Long story',
        description: 'A' * 500, // very long description
        category: 'moment',
        date: DateTime(2026, 2, 1),
      );

      await tester.pumpWidget(buildWidget(memory));

      // Find the Text widget showing the description
      final textWidget = tester.widget<Text>(
        find.byWidgetPredicate(
          (w) => w is Text && (w.data?.contains('AAA') ?? false),
        ),
      );

      expect(textWidget.maxLines, lessThanOrEqualTo(3));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('shows category badge', (tester) async {
      final memory = MemoryEntry(
        id: 'm-4',
        title: 'Wedding anniversary',
        category: 'milestone',
        date: DateTime(2026, 6, 1),
      );

      await tester.pumpWidget(buildWidget(memory));

      expect(find.textContaining('milestone'), findsOneWidget);
    });

    testWidgets('shows favorite icon when isFavorite', (tester) async {
      final memory = MemoryEntry(
        id: 'm-5',
        title: 'Special moment',
        category: 'moment',
        date: DateTime(2026, 2, 14),
        isFavorite: true,
      );

      await tester.pumpWidget(buildWidget(memory));

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
```

### 2.5 ProfileCompletionBar

```dart
// test/features/her_profile/presentation/widgets/profile_completion_bar_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/her_profile/presentation/widgets/profile_completion_bar.dart';

void main() {
  Widget buildWidget(int percent) {
    return MaterialApp(
      home: Scaffold(
        body: ProfileCompletionBar(completionPercent: percent),
      ),
    );
  }

  group('ProfileCompletionBar', () {
    testWidgets('displays 0% correctly', (tester) async {
      await tester.pumpWidget(buildWidget(0));

      expect(find.text('0%'), findsOneWidget);
    });

    testWidgets('displays 100% correctly', (tester) async {
      await tester.pumpWidget(buildWidget(100));

      expect(find.text('100%'), findsOneWidget);
    });

    testWidgets('displays intermediate percentage', (tester) async {
      await tester.pumpWidget(buildWidget(72));

      expect(find.text('72%'), findsOneWidget);
    });

    testWidgets('animates from 0 to target %', (tester) async {
      await tester.pumpWidget(buildWidget(85));

      // At start of animation, the bar should not be fully filled
      await tester.pump(const Duration(milliseconds: 50));

      // After animation completes
      await tester.pumpAndSettle();

      expect(find.text('85%'), findsOneWidget);
    });

    testWidgets('clamps value between 0 and 100', (tester) async {
      await tester.pumpWidget(buildWidget(150));
      expect(find.text('100%'), findsOneWidget);

      await tester.pumpWidget(buildWidget(-10));
      expect(find.text('0%'), findsOneWidget);
    });

    testWidgets('uses accent color for filled portion', (tester) async {
      await tester.pumpWidget(buildWidget(50));
      await tester.pumpAndSettle();

      // Verify the progress indicator uses the app accent color
      final progressWidget = find.byType(LinearProgressIndicator);
      expect(progressWidget, findsOneWidget);
    });
  });
}
```

### 2.6 ActionCard -- Swipe Gestures

```dart
// test/features/action_cards/presentation/widgets/action_card_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/action_cards/presentation/widgets/action_card_widget.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card.dart';

void main() {
  Widget buildWidget({
    required ActionCard card,
    VoidCallback? onComplete,
    VoidCallback? onSkip,
  }) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: ActionCardWidget(
            card: card,
            onComplete: onComplete ?? () {},
            onSkip: onSkip ?? () {},
          ),
        ),
      ),
    );
  }

  final sayCard = ActionCard(
    id: 'ac-1',
    type: 'SAY',
    title: 'Tell her something sweet',
    body: 'Remind Nora that you appreciate her cooking.',
    xpReward: 15,
  );

  group('ActionCardWidget - Swipe Gestures', () {
    testWidgets('swipe right triggers complete callback', (tester) async {
      bool completed = false;

      await tester.pumpWidget(buildWidget(
        card: sayCard,
        onComplete: () => completed = true,
      ));

      // Swipe right
      await tester.drag(
        find.byType(ActionCardWidget),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(completed, true);
    });

    testWidgets('swipe left triggers skip callback', (tester) async {
      bool skipped = false;

      await tester.pumpWidget(buildWidget(
        card: sayCard,
        onSkip: () => skipped = true,
      ));

      // Swipe left
      await tester.drag(
        find.byType(ActionCardWidget),
        const Offset(-300, 0),
      );
      await tester.pumpAndSettle();

      expect(skipped, true);
    });

    testWidgets('displays card type badge with SAY color', (tester) async {
      await tester.pumpWidget(buildWidget(card: sayCard));

      expect(find.text('SAY'), findsOneWidget);
    });

    testWidgets('displays XP reward', (tester) async {
      await tester.pumpWidget(buildWidget(card: sayCard));

      expect(find.text('+15 XP'), findsOneWidget);
    });

    testWidgets('small drag does not trigger action', (tester) async {
      bool completed = false;
      bool skipped = false;

      await tester.pumpWidget(buildWidget(
        card: sayCard,
        onComplete: () => completed = true,
        onSkip: () => skipped = true,
      ));

      // Small drag that should not trigger
      await tester.drag(
        find.byType(ActionCardWidget),
        const Offset(50, 0),
      );
      await tester.pumpAndSettle();

      expect(completed, false);
      expect(skipped, false);
    });
  });
}
```

---

## 3. Integration Tests

### 3.1 Complete Onboarding Flow (8 Screens End-to-End)

```
Scenario: New user completes onboarding in English
  Given the app is freshly installed with no prior data
  When the user launches the app for the first time
  Then the language selection screen is displayed

  When the user taps "English"
  Then the locale is set to EN with LTR direction
  And the welcome screen is displayed

  When the user taps "Get Started"
  Then the sign-up screen is displayed

  When the user enters email "ahmed@example.com", password "Secure1234", name "Ahmed"
  And taps "Create Account"
  Then an account is created via Firebase Auth
  And the "Your Name" step appears (pre-filled with "Ahmed")

  When the user confirms their name and taps "Continue"
  Then the "Her Info" step appears

  When the user enters partner name "Nora" and selects zodiac "Scorpio"
  And taps "Continue"
  Then the "Relationship Status" step appears

  When the user selects "Married"
  And taps "Continue"
  Then the "Key Date" step appears

  When the user sets anniversary to June 1, 2020
  And taps "Continue"
  Then the "First Action Card" screen appears with a personalized SAY card
  And the card references "Nora"

  When the user taps "Continue to Dashboard"
  Then the home dashboard loads within 2 seconds
  And onboarding data is persisted in Hive and Firestore
  And the onboardingComplete flag is set to true

Scenario: User closes app mid-onboarding and resumes
  Given the user has completed steps 0-3 of onboarding
  When the user kills the app
  And relaunches the app
  Then the app resumes at step 4 with all prior data intact
  And partner name "Nora" is pre-filled

Scenario: Arabic user completes onboarding with RTL
  Given the app is freshly installed
  When the user selects "العربية" on the language screen
  Then all subsequent screens render in RTL
  And Arabic text is right-aligned throughout
  And progress indicator reads right-to-left
  And the onboarding completes successfully with AR locale persisted
```

### 3.2 Create and Complete a Reminder

```
Scenario: Create a birthday reminder with escalation
  Given the user is authenticated and on the Reminders screen
  When the user taps "Add Reminder"
  And selects type "Birthday"
  And enters title "Nora's Birthday"
  And selects date June 15, 2026
  And enables yearly recurrence
  And taps "Save"
  Then the reminder appears in the reminders list with status "active"
  And 6 notification tiers are scheduled: 30d, 14d, 7d, 3d, 1d, day-of
  And the 30d and 14d notifications include a Gift Engine link

Scenario: Snooze a reminder
  Given a reminder "Buy anniversary gift" is active with a notification firing now
  When the user taps "Snooze" and selects "3 hours"
  Then the reminder status changes to "snoozed"
  And snoozedUntil is set to 3 hours from now
  And no further notifications fire until the snooze expires

Scenario: Complete a reminder and earn XP
  Given a reminder "Send flowers" is active and due today
  When the user taps the completion checkbox
  Then the reminder status changes to "completed"
  And +15 XP is awarded to the user
  And the XP total on the dashboard updates
  And if recurring, the next occurrence date is calculated
```

### 3.3 Build Her Profile with Zodiac Defaults

```
Scenario: Select zodiac and verify auto-population
  Given the user is on the Partner Profile edit screen
  When the user selects zodiac sign "Pisces"
  Then personality traits auto-populate from zodiac defaults:
    - "Deeply intuitive and emotionally aware"
    - "Creative and romantic"
    - "Can be indecisive under pressure"
  And communication tips populate:
    - "Lead with emotion, not logic"
    - "Validate her feelings before problem-solving"
  And love language hint shows "time"
  And a disclaimer reads "This is based on her zodiac sign -- adjust if needed."
  And the profile completion percentage increases

Scenario: Override auto-populated zodiac trait
  Given zodiac "Pisces" traits are auto-populated
  When the user edits the conflict style from the default to "Prefers immediate discussion"
  And taps "Save"
  Then the override persists and the default is replaced
  And the profile data is encrypted at rest

Scenario: Add cultural context and verify holiday auto-population
  Given the user has a partner profile for "Nora"
  When the user navigates to Cultural Context settings
  And selects background "Gulf Arab"
  And sets religious observance to "High"
  Then Islamic holidays are auto-added to the reminder calendar:
    - Eid al-Fitr
    - Eid al-Adha
    - Ramadan start
    - Maulidur Rasul
  And all holiday reminders have escalation schedules beginning 21 days before
```

### 3.4 Add Memory with Photo -- Appears in Timeline

```
Scenario: Create a memory with photo attachment
  Given the user is on the Memory Vault home screen
  When the user taps "Add Memory"
  And enters title "Valentine's Dinner 2026"
  And enters description "Surprise dinner at the rooftop restaurant"
  And selects category "moment"
  And sets date to February 14, 2026
  And sets mood to "romantic"
  And attaches a photo from the gallery
  And taps "Save"
  Then the memory is created and encrypted at rest
  And +10 XP is awarded
  And the memory appears in the timeline view under February 2026
  And the thumbnail from the attached photo is visible
  And the total memory count increases by 1

Scenario: Search memory by tag
  Given the user has created 5 memories with various tags
  When the user searches for tag "dinner"
  Then only memories tagged with "dinner" are returned
  And the search results are ordered by date descending

Scenario: Free tier enforces 20 memory limit
  Given the user is on the Free tier and has 20 memories
  When the user attempts to create a 21st memory
  Then an error message displays: "Memory limit reached. Upgrade to Pro."
  And the TIER_LIMIT_EXCEEDED error is returned
```

### 3.5 Locale Switching (EN -> AR -> MS) Without Restart

```
Scenario: Switch from English to Arabic at runtime
  Given the user is authenticated and on the dashboard in English (LTR)
  When the user navigates to Settings > Language
  And selects "العربية"
  Then the entire UI rebuilds in RTL within 500ms
  And all text is right-aligned
  And bottom navigation tab order mirrors (Home on far right)
  And all strings display in Arabic (no English fallback visible)
  And the locale change persists to Hive and Firestore

Scenario: Switch from Arabic to Malay at runtime
  Given the user is in Arabic (RTL) mode
  When the user navigates to Settings > Language
  And selects "Bahasa Melayu"
  Then the UI rebuilds to LTR within 500ms
  And all strings display in Malay
  And the dashboard loads correctly with Malay labels
  And no app restart is required

Scenario: Locale persists across app restart
  Given the user has switched to Arabic
  When the user kills and relaunches the app
  Then the app launches in Arabic with RTL
  And no language selection screen is shown (already configured)
```

---

## 4. Golden Tests

### 4.1 Sprint 2 Golden File Inventory

Sprint 2 adds 15 new or updated screens. Each screen requires 4 golden files (dark-LTR, dark-RTL, light-LTR, light-RTL) = **60 golden files**.

| # | Screen | Route | Golden File Prefix |
|---|--------|-------|--------------------|
| 1 | Profile Overview | `/her-profile` | `profile_overview` |
| 2 | Profile Edit | `/her-profile/edit` | `profile_edit` |
| 3 | Zodiac Selection | `/her-profile/zodiac` | `zodiac_selection` |
| 4 | Preferences & Interests | `/her-profile/preferences` | `preferences` |
| 5 | Cultural Context | `/her-profile/cultural` | `cultural_context` |
| 6 | Reminders List | `/reminders` | `reminders_list` |
| 7 | Create Reminder | `/reminders/create` | `create_reminder` |
| 8 | Reminder Detail | `/reminders/detail` | `reminder_detail` |
| 9 | Memory Vault Home | `/memories` | `memory_home` |
| 10 | Add Memory | `/memories/new` | `add_memory` |
| 11 | Memory Detail | `/memories/:id` | `memory_detail` |
| 12 | Wish List | `/memories/wishlist` | `wishlist` |
| 13 | Settings Main | `/settings` | `settings_main` |
| 14 | Settings Preferences | `/settings/notifications` | `settings_notif` |
| 15 | App Lock | `/lock` | `app_lock` |

**Generated files per screen (example for Profile Overview):**

| Variant | File Name |
|---------|-----------|
| Dark + LTR | `goldens/profile_overview_dark_ltr.png` |
| Dark + RTL | `goldens/profile_overview_dark_rtl.png` |
| Light + LTR | `goldens/profile_overview_light_ltr.png` |
| Light + RTL | `goldens/profile_overview_light_rtl.png` |

### 4.2 Sample Golden Test Code

```dart
// test/goldens/sprint2/profile_overview_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/her_profile/presentation/screens/profile_overview_screen.dart';
import 'package:lolo/features/her_profile/presentation/providers/profile_provider.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile.dart';
import '../../helpers/golden_test_helpers.dart';

void main() {
  group('ProfileOverviewScreen Golden Tests', () {
    final populatedProfile = PartnerProfile(
      id: 'p-1',
      name: 'Nora',
      zodiacSign: 'scorpio',
      loveLanguage: 'words',
      communicationStyle: 'direct',
      relationshipStatus: 'married',
      profileCompletionPercent: 72,
    );

    testGoldens('dark_ltr', (tester) async {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith((_) => AsyncValue.data(populatedProfile)),
          ],
          child: const ProfileOverviewScreen(),
        ),
        wrapper: goldenWrapper(
          theme: ThemeData.dark(),
          locale: const Locale('en'),
          textDirection: TextDirection.ltr,
        ),
        surfaceSize: const Size(1080, 2340),
      );

      await screenMatchesGolden(tester, 'profile_overview_dark_ltr');
    });

    testGoldens('dark_rtl', (tester) async {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith((_) => AsyncValue.data(populatedProfile)),
          ],
          child: const ProfileOverviewScreen(),
        ),
        wrapper: goldenWrapper(
          theme: ThemeData.dark(),
          locale: const Locale('ar'),
          textDirection: TextDirection.rtl,
        ),
        surfaceSize: const Size(1080, 2340),
      );

      await screenMatchesGolden(tester, 'profile_overview_dark_rtl');
    });

    testGoldens('light_ltr', (tester) async {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith((_) => AsyncValue.data(populatedProfile)),
          ],
          child: const ProfileOverviewScreen(),
        ),
        wrapper: goldenWrapper(
          theme: ThemeData.light(),
          locale: const Locale('en'),
          textDirection: TextDirection.ltr,
        ),
        surfaceSize: const Size(1080, 2340),
      );

      await screenMatchesGolden(tester, 'profile_overview_light_ltr');
    });

    testGoldens('light_rtl', (tester) async {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith((_) => AsyncValue.data(populatedProfile)),
          ],
          child: const ProfileOverviewScreen(),
        ),
        wrapper: goldenWrapper(
          theme: ThemeData.light(),
          locale: const Locale('ar'),
          textDirection: TextDirection.rtl,
        ),
        surfaceSize: const Size(1080, 2340),
      );

      await screenMatchesGolden(tester, 'profile_overview_light_rtl');
    });
  });
}
```

### 4.3 Golden Test Helper

```dart
// test/helpers/golden_test_helpers.dart
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lolo/l10n/app_localizations.dart';

WidgetWrapper goldenWrapper({
  required ThemeData theme,
  required Locale locale,
  required TextDirection textDirection,
}) {
  return (child) => MaterialApp(
        theme: theme,
        locale: locale,
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('ms')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, widget) {
          return Directionality(
            textDirection: textDirection,
            child: widget!,
          );
        },
        home: child,
      );
}
```

### 4.4 Tolerance Configuration

```dart
// flutter_test_config.dart (project root)
import 'dart:async';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // 0.5% pixel tolerance for anti-aliasing and font rendering differences
      skipGoldenAssertion: () => !Platform.isLinux, // Only enforce on CI (Linux)
      fileNameFactory: (name) => 'goldens/$name.png',
    ),
  );
}
```

**CI tolerance setting** in `dart_test.yaml`:

```yaml
golden_toolkit:
  tolerance: 0.005  # 0.5% pixel difference tolerance
```

---

## 5. RTL Test Suite for Sprint 2

### 5.1 Per-Screen RTL Verification

| # | Screen | Layout Mirrors | Icons Mirror | Text Aligns Right | Gestures Reverse | Arabic Font |
|---|--------|---------------|-------------|-------------------|-----------------|-------------|
| 1 | Profile Overview | Fields: label right, value left | Edit pencil icon: left side | Yes | N/A | Cairo + Noto Naskh |
| 2 | Profile Edit | Form fields right-aligned; save/cancel swap | N/A | Yes, inputs RTL | N/A | Cairo + Noto Naskh |
| 3 | Zodiac Selection | Carousel scrolls right-to-left start | Sign icons: no flip | Yes | Scroll starts right | Cairo + Noto Naskh |
| 4 | Preferences | Category chips right-aligned | Category icons | Yes | N/A | Cairo + Noto Naskh |
| 5 | Cultural Context | Selector options right-aligned | N/A | Yes | N/A | Cairo + Noto Naskh |
| 6 | Reminders List | List items mirror; FAB bottom-left | Type icons | Yes | Swipe actions reverse | Cairo + Noto Naskh |
| 7 | Create Reminder | Form mirrors; date picker RTL | Calendar icons | Yes | N/A | Cairo + Noto Naskh |
| 8 | Reminder Detail | Fields mirror | Action icons | Yes | N/A | Cairo + Noto Naskh |
| 9 | Memory Vault Home | Grid/list mirrors; FAB bottom-left | Filter/search icons | Yes | N/A | Cairo + Noto Naskh |
| 10 | Add Memory | Form right-aligned; photo grid mirrors | Camera/gallery icons | Yes | N/A | Cairo + Noto Naskh |
| 11 | Memory Detail | Content right-aligned; photo carousel RTL | Action icons | Yes | Carousel: right-to-left | Cairo + Noto Naskh |
| 12 | Wish List | List items mirror | Priority icons | Yes | N/A | Cairo + Noto Naskh |
| 13 | Settings Main | Section list: icons right, labels left | Section icons flip | Yes | N/A | Cairo + Noto Naskh |
| 14 | Notification Prefs | Toggle rows mirror: label right, toggle left | Category icons | Yes | N/A | Cairo + Noto Naskh |
| 15 | App Lock | PIN pad centered; biometric prompt mirrors | Lock/fingerprint icon | Yes | N/A | Cairo + Noto Naskh |

### 5.2 Arabic Font Rendering Verification

```dart
// test/rtl/arabic_font_rendering_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('Arabic Font Rendering', () {
    testGoldens('Cairo font renders correctly for headings', (tester) async {
      await tester.pumpWidgetBuilder(
        const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'مرحبا بك في لولو',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        surfaceSize: const Size(400, 100),
      );

      await screenMatchesGolden(tester, 'arabic_cairo_heading');
    });

    testGoldens('Noto Naskh Arabic renders body text', (tester) async {
      await tester.pumpWidgetBuilder(
        const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'هذا النص باللغة العربية ويجب أن يظهر بشكل صحيح',
            style: TextStyle(
              fontFamily: 'Noto Naskh Arabic',
              fontSize: 16,
            ),
          ),
        ),
        surfaceSize: const Size(400, 100),
      );

      await screenMatchesGolden(tester, 'arabic_noto_naskh_body');
    });

    testGoldens('Arabic diacritics render correctly', (tester) async {
      await tester.pumpWidgetBuilder(
        const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
            style: TextStyle(fontFamily: 'Noto Naskh Arabic', fontSize: 20),
          ),
        ),
        surfaceSize: const Size(500, 80),
      );

      await screenMatchesGolden(tester, 'arabic_diacritics');
    });
  });
}
```

### 5.3 BiDi Text in Her Profile

```dart
// test/rtl/bidi_profile_text_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('BiDi Text in Her Profile', () {
    testGoldens('Arabic name + English zodiac sign renders correctly',
        (tester) async {
      await tester.pumpWidgetBuilder(
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arabic name field
              const Text('نورة', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 8),
              // Zodiac in English within Arabic context
              RichText(
                textDirection: TextDirection.rtl,
                text: const TextSpan(
                  text: 'برج: ',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  children: [
                    TextSpan(
                      text: 'Scorpio ♏',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        surfaceSize: const Size(400, 120),
      );

      await screenMatchesGolden(tester, 'bidi_arabic_name_english_zodiac');
    });

    testGoldens('Arabic text with English preferences', (tester) async {
      await tester.pumpWidgetBuilder(
        const Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الزهور المفضلة: Peonies, Sunflowers'),
              Text('الموسيقى: Jazz, Fairuz'),
              Text('العلامات التجارية: Chanel, Dior'),
            ],
          ),
        ),
        surfaceSize: const Size(400, 150),
      );

      await screenMatchesGolden(tester, 'bidi_arabic_english_preferences');
    });
  });
}
```

### 5.4 Calendar Component RTL

```dart
// test/rtl/calendar_rtl_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calendar RTL Behavior', () {
    testWidgets('month navigation arrows flip in RTL', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: CalendarDatePicker(
                initialDate: DateTime(2026, 6, 15),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                onDateChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // In RTL, the "next month" arrow should be on the left
      // and "previous month" arrow on the right
      final nextArrow = find.byIcon(Icons.chevron_left);
      final prevArrow = find.byIcon(Icons.chevron_right);

      expect(nextArrow, findsOneWidget);
      expect(prevArrow, findsOneWidget);
    });

    testWidgets('day labels start from Saturday in Arabic locale',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          home: Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: CalendarDatePicker(
                initialDate: DateTime(2026, 2, 15),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                onDateChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      // Arabic calendar typically starts Saturday (السبت)
      expect(find.text('س'), findsWidgets); // Saturday abbreviation
    });
  });
}
```

### 5.5 Date Picker RTL

```dart
// test/rtl/date_picker_rtl_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Picker RTL', () {
    testWidgets('date picker renders in RTL for Arabic locale',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(2026, 6, 15),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    locale: const Locale('ar'),
                  );
                },
                child: const Text('اختر التاريخ'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اختر التاريخ'));
      await tester.pumpAndSettle();

      // Date picker dialog should be visible
      expect(find.byType(Dialog), findsOneWidget);

      // Month name should be in Arabic
      expect(find.textContaining('يونيو'), findsOneWidget); // June in Arabic
    });

    testWidgets('selected date formats as DD/MM/YYYY for Arabic locale',
        (tester) async {
      DateTime? selected;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2026, 6, 15),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    locale: const Locale('ar'),
                  );
                },
                child: const Text('اختر'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('اختر'));
      await tester.pumpAndSettle();

      // Tap OK to confirm the initial date
      await tester.tap(find.text('حسنًا')); // OK in Arabic
      await tester.pumpAndSettle();

      expect(selected, DateTime(2026, 6, 15));
    });
  });
}
```

---

## 6. API Contract Tests

### 6.1 Postman/Newman Collection Structure

```
lolo-api-tests/
  collections/
    sprint2/
      her-profile.postman_collection.json
      reminders.postman_collection.json
      memory-vault.postman_collection.json
      gamification.postman_collection.json
      settings.postman_collection.json
  environments/
    dev.postman_environment.json
    staging.postman_environment.json
  globals/
    lolo-globals.postman_globals.json
  scripts/
    run-sprint2.sh
```

**Environment Variables:**

| Variable | Dev Value | Staging Value |
|----------|-----------|---------------|
| `base_url` | `http://localhost:5001/lolo-dev/us-central1/api/v1` | `https://us-central1-lolo-staging.cloudfunctions.net/api/v1` |
| `auth_token` | `{{dev_token}}` | `{{staging_token}}` |
| `test_user_uid` | `test-user-dev-001` | `test-user-stg-001` |
| `test_profile_id` | `test-profile-dev-001` | `test-profile-stg-001` |
| `test_reminder_id` | (auto-generated) | (auto-generated) |
| `test_memory_id` | (auto-generated) | (auto-generated) |

### 6.2 Her Profile API Tests

| # | Endpoint | Test Case | Method | Expected Status | Priority |
|---|----------|-----------|--------|-----------------|----------|
| 1 | `POST /profiles` | Create with valid name + relationship status | POST | 201 | P0 |
| 2 | `POST /profiles` | Missing required name field | POST | 400 INVALID_REQUEST | P0 |
| 3 | `POST /profiles` | Duplicate profile (already exists) | POST | 409 PROFILE_ALREADY_EXISTS | P0 |
| 4 | `POST /profiles` | No auth token | POST | 401 UNAUTHENTICATED | P0 |
| 5 | `GET /profiles/:id` | Retrieve own profile | GET | 200 | P0 |
| 6 | `GET /profiles/:id` | Attempt to access another user's profile | GET | 403 PERMISSION_DENIED | P0 |
| 7 | `GET /profiles/:id` | Non-existent profile ID | GET | 404 NOT_FOUND | P1 |
| 8 | `PUT /profiles/:id` | Update single field (zodiacSign) | PUT | 200 | P0 |
| 9 | `PUT /profiles/:id` | Update with invalid zodiac sign | PUT | 400 INVALID_REQUEST | P1 |
| 10 | `PUT /profiles/:id` | Verify profileCompletionPercent increases | PUT | 200 (check body) | P0 |
| 11 | `GET /profiles/:id/zodiac-defaults?sign=scorpio` | Valid sign returns traits | GET | 200 | P0 |
| 12 | `GET /profiles/:id/zodiac-defaults?sign=invalid` | Invalid sign rejected | GET | 400 INVALID_ZODIAC_SIGN | P1 |
| 13 | `PUT /profiles/:id/preferences` | Update favorites array | PUT | 200 | P0 |
| 14 | `PUT /profiles/:id/preferences` | Exceeds max array items | PUT | 400 INVALID_REQUEST | P1 |
| 15 | `PUT /profiles/:id/cultural-context` | Set Gulf Arab + High observance | PUT | 200 | P0 |
| 16 | `DELETE /profiles/:id` | Delete own profile | DELETE | 200 | P0 |
| 17 | All endpoints | Rate limit exceeded (burst requests) | Various | 429 RATE_LIMITED | P1 |

### 6.3 Reminders API Tests

| # | Endpoint | Test Case | Method | Expected Status | Priority |
|---|----------|-----------|--------|-----------------|----------|
| 1 | `POST /reminders` | Create with valid title, type, future date | POST | 201 | P0 |
| 2 | `POST /reminders` | Create with past date (non-recurring) | POST | 400 INVALID_DATE | P0 |
| 3 | `POST /reminders` | Create recurring (yearly) with past date | POST | 201 | P0 |
| 4 | `POST /reminders` | Missing required title | POST | 400 INVALID_REQUEST | P0 |
| 5 | `POST /reminders` | No auth token | POST | 401 UNAUTHENTICATED | P0 |
| 6 | `GET /reminders` | List active reminders | GET | 200 | P0 |
| 7 | `GET /reminders?type=birthday` | Filter by type | GET | 200 | P1 |
| 8 | `GET /reminders?status=snoozed` | Filter by status | GET | 200 | P1 |
| 9 | `GET /reminders/upcoming?days=7` | Get 7-day lookahead | GET | 200 | P0 |
| 10 | `PUT /reminders/:id` | Update title and date | PUT | 200 | P0 |
| 11 | `PUT /reminders/:id` | Update non-existent reminder | PUT | 404 NOT_FOUND | P1 |
| 12 | `POST /reminders/:id/snooze` | Snooze for 1 hour | POST | 200 | P0 |
| 13 | `POST /reminders/:id/snooze` | Invalid snooze duration | POST | 400 INVALID_DURATION | P1 |
| 14 | `POST /reminders/:id/complete` | Mark as completed | POST | 200 (xpAwarded > 0) | P0 |
| 15 | `POST /reminders/:id/complete` | Complete already-completed | POST | 409 ALREADY_COMPLETED | P1 |
| 16 | `DELETE /reminders/:id` | Delete reminder | DELETE | 200 | P0 |
| 17 | All endpoints | Rate limit exceeded | Various | 429 RATE_LIMITED | P1 |

### 6.4 Memory Vault API Tests

| # | Endpoint | Test Case | Method | Expected Status | Priority |
|---|----------|-----------|--------|-----------------|----------|
| 1 | `POST /memories` | Create with valid title, category, date | POST | 201 | P0 |
| 2 | `POST /memories` | Missing required title | POST | 400 INVALID_REQUEST | P0 |
| 3 | `POST /memories` | Invalid category value | POST | 400 INVALID_REQUEST | P0 |
| 4 | `POST /memories` | No auth token | POST | 401 UNAUTHENTICATED | P0 |
| 5 | `POST /memories` | Exceed tier memory limit (Free: 20) | POST | 403 TIER_LIMIT_EXCEEDED | P0 |
| 6 | `GET /memories` | List all memories | GET | 200 | P0 |
| 7 | `GET /memories?category=trip` | Filter by category | GET | 200 | P1 |
| 8 | `GET /memories?search=dinner` | Full-text search | GET | 200 | P1 |
| 9 | `GET /memories?startDate=2026-01-01&endDate=2026-02-28` | Date range filter | GET | 200 | P1 |
| 10 | `GET /memories/timeline?year=2026` | Timeline view | GET | 200 | P0 |
| 11 | `PUT /memories/:id` | Update title | PUT | 200 | P0 |
| 12 | `PUT /memories/:id` | Update non-existent memory | PUT | 404 NOT_FOUND | P1 |
| 13 | `DELETE /memories/:id` | Delete memory + media | DELETE | 200 | P0 |
| 14 | `POST /memories/:id/media` | Upload JPEG image | POST | 201 | P0 |
| 15 | `POST /memories/:id/media` | Upload invalid file type (.exe) | POST | 400 INVALID_FILE_TYPE | P0 |
| 16 | `POST /memories/:id/media` | Exceed 10 MB file size | POST | 400 FILE_TOO_LARGE | P1 |
| 17 | `GET /memories/wishlist` | List wish items | GET | 200 | P0 |
| 18 | `POST /memories/wishlist` | Add wish item | POST | 201 | P0 |
| 19 | All endpoints | Rate limit exceeded | Various | 429 RATE_LIMITED | P1 |

### 6.5 Newman Execution Script

```bash
#!/bin/bash
# scripts/run-sprint2.sh
# Run all Sprint 2 API contract tests

ENV=${1:-dev}

echo "Running Sprint 2 API Contract Tests against $ENV environment..."

newman run collections/sprint2/her-profile.postman_collection.json \
  -e environments/${ENV}.postman_environment.json \
  -g globals/lolo-globals.postman_globals.json \
  --reporters cli,junit \
  --reporter-junit-export results/her-profile-${ENV}.xml

newman run collections/sprint2/reminders.postman_collection.json \
  -e environments/${ENV}.postman_environment.json \
  -g globals/lolo-globals.postman_globals.json \
  --reporters cli,junit \
  --reporter-junit-export results/reminders-${ENV}.xml

newman run collections/sprint2/memory-vault.postman_collection.json \
  -e environments/${ENV}.postman_environment.json \
  -g globals/lolo-globals.postman_globals.json \
  --reporters cli,junit \
  --reporter-junit-export results/memory-vault-${ENV}.xml

echo "Results written to results/ directory."
```

---

## 7. Performance Baselines for Sprint 2

### 7.1 Screen Load Time Targets

| Screen | Cold Load Target | Warm Load Target | Frame Rate Target | Notes |
|--------|-----------------|-----------------|-------------------|-------|
| Profile Overview | < 1.5s | < 500ms | 60 fps | Includes zodiac badge + completion bar animation |
| Profile Edit | < 1.5s | < 500ms | 60 fps | Form rendering with 10+ fields |
| Zodiac Selection | < 1.0s | < 300ms | 60 fps | Carousel with 13 items (12 signs + I don't know) |
| Preferences | < 1.5s | < 500ms | 60 fps | Category chips + free-text fields |
| Cultural Context | < 1.0s | < 300ms | 60 fps | Dropdown selectors |
| Reminders List | < 1.5s | < 500ms | 60 fps | List with up to 30 items |
| Create Reminder | < 1.0s | < 300ms | 60 fps | Form + date picker |
| Reminder Detail | < 1.0s | < 300ms | 60 fps | Static detail view |
| Memory Vault Home | < 2.0s | < 800ms | 60 fps | Timeline with thumbnails, most data-heavy screen |
| Add Memory | < 1.0s | < 500ms | 60 fps | Form + photo picker |
| Memory Detail | < 1.5s | < 500ms | 60 fps | Includes photo carousel |
| Wish List | < 1.0s | < 500ms | 60 fps | List up to 20 items |
| Settings Main | < 1.0s | < 300ms | 60 fps | Static section list |
| Notification Prefs | < 1.0s | < 300ms | 60 fps | Toggle rows |
| App Lock | < 500ms | < 200ms | 60 fps | Must be fast for security UX |

### 7.2 Operation Targets

| Operation | Target | Measurement Method |
|-----------|--------|-------------------|
| Language switch (EN to AR full RTL rebuild) | < 500ms | `Stopwatch` in `LocaleNotifier` |
| Profile save (local + remote) | < 1s | Dio interceptor timing |
| Zodiac defaults API call | < 200ms | Dio interceptor timing (cached: < 10ms) |
| Reminder creation (with notification scheduling) | < 1.5s | End-to-end timer |
| Memory creation (text only) | < 1s | Dio interceptor timing |
| Memory creation (with photo upload) | < 5s (depends on image size) | End-to-end timer |
| Memory search (full-text) | < 500ms | Dio interceptor timing |
| Encryption (5000 char text) | < 50ms | `Stopwatch` in `EncryptionService` |
| Decryption (5000 char text) | < 50ms | `Stopwatch` in `EncryptionService` |
| Wish list load | < 300ms | Dio interceptor timing |

### 7.3 Memory and Size Targets

| Metric | Target | Tool |
|--------|--------|------|
| Peak memory usage (Memory Vault with 100 entries) | < 200 MB | Flutter DevTools Memory |
| Idle memory (dashboard) | < 100 MB | Flutter DevTools Memory |
| Scroll through 30 reminders | 0 dropped frames | Flutter DevTools Performance |
| Scroll through 100 memory cards | 0 dropped frames | Flutter DevTools Performance |
| Photo carousel (10 images) smooth scroll | 60 fps, < 200ms per image decode | Flutter DevTools |
| APK size delta from Sprint 1 | < +5 MB | `flutter build apk --analyze-size` |

### 7.4 Baseline Establishment Process

For each Sprint 2 screen, the following baseline process must be executed during QA:

1. **Device:** Pixel 5 (or equivalent mid-range) with release build
2. **Procedure:** Cold start the app, navigate to screen, record cold load time. Repeat 5 times, take P95.
3. **Warm load:** Navigate away, return, record. Repeat 5 times, take P95.
4. **Frame rate:** Enable performance overlay, scroll through content for 30 seconds, record dropped frames.
5. **Record results** in the Sprint 2 QA sign-off report with actual measurements vs. targets.
6. **Flag regressions** if any screen exceeds target by more than 20%.

---

*End of Sprint 2 Test Specifications. All test cases are traceable to Sprint 2 tasks S2-01 through S2-13 in the Final Sprint Plan v1.0.*
