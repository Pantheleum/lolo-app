import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lolo/features/onboarding/domain/usecases/save_onboarding_step_usecase.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late SaveOnboardingStepUseCase useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = SaveOnboardingStepUseCase(mockRepository);
  });

  group('SaveOnboardingStepUseCase', () {
    const testData = OnboardingDataEntity(
      language: 'en',
      userName: 'Ahmed',
      currentStep: 3,
    );

    test('calls repository.saveDraft with the provided data', () async {
      when(() => mockRepository.saveDraft(testData))
          .thenAnswer((_) async => const Right(null));

      await useCase(testData);

      verify(() => mockRepository.saveDraft(testData)).called(1);
    });

    test('returns Right(void) on success', () async {
      when(() => mockRepository.saveDraft(testData))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(testData);

      expect(result, const Right<Failure, void>(null));
    });

    test('returns Left(Failure) when repository fails', () async {
      const failure = CacheFailure(message: 'Failed to save draft');
      when(() => mockRepository.saveDraft(testData))
          .thenAnswer((_) async => const Left(failure));

      final result = await useCase(testData);

      result.fold(
        (f) => expect(f.message, 'Failed to save draft'),
        (_) => fail('Expected failure'),
      );
    });

    test('passes full onboarding data to repository', () async {
      final fullData = OnboardingDataEntity(
        language: 'ar',
        userName: 'Ahmed',
        partnerName: 'Sara',
        partnerZodiac: 'scorpio',
        relationshipStatus: 'married',
        keyDate: DateTime(2020, 6, 15),
        keyDateType: 'wedding_date',
        email: 'ahmed@test.com',
        authProvider: 'google',
        firebaseUid: 'uid123',
        currentStep: 7,
        isComplete: false,
      );

      when(() => mockRepository.saveDraft(fullData))
          .thenAnswer((_) async => const Right(null));

      await useCase(fullData);

      verify(() => mockRepository.saveDraft(fullData)).called(1);
    });

    test('passes default onboarding data to repository', () async {
      const defaultData = OnboardingDataEntity();

      when(() => mockRepository.saveDraft(defaultData))
          .thenAnswer((_) async => const Right(null));

      await useCase(defaultData);

      verify(() => mockRepository.saveDraft(defaultData)).called(1);
    });
  });
}
