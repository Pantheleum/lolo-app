import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';

void main() {
  final now = DateTime.now();

  PartnerProfileEntity createProfile({
    String? zodiacSign,
    String? loveLanguage,
    PartnerPreferencesEntity? preferences,
    String? photoUrl,
  }) {
    return PartnerProfileEntity(
      id: 'profile-1',
      userId: 'user-1',
      name: 'Sara',
      zodiacSign: zodiacSign,
      loveLanguage: loveLanguage,
      preferences: preferences,
      photoUrl: photoUrl,
      relationshipStatus: 'married',
      createdAt: now,
      updatedAt: now,
    );
  }

  group('PartnerProfileEntity creation', () {
    test('creates with required fields only', () {
      final profile = createProfile();
      expect(profile.id, 'profile-1');
      expect(profile.userId, 'user-1');
      expect(profile.name, 'Sara');
      expect(profile.relationshipStatus, 'married');
      expect(profile.createdAt, now);
      expect(profile.updatedAt, now);
    });

    test('has null defaults for optional fields', () {
      final profile = createProfile();
      expect(profile.birthday, isNull);
      expect(profile.zodiacSign, isNull);
      expect(profile.zodiacTraits, isNull);
      expect(profile.loveLanguage, isNull);
      expect(profile.communicationStyle, isNull);
      expect(profile.anniversaryDate, isNull);
      expect(profile.photoUrl, isNull);
      expect(profile.preferences, isNull);
      expect(profile.culturalContext, isNull);
    });

    test('has default profileCompletionPercent of 0', () {
      final profile = createProfile();
      expect(profile.profileCompletionPercent, 0);
    });

    test('creates with all fields', () {
      final birthday = DateTime(1995, 8, 20);
      final anniversary = DateTime(2020, 6, 15);
      const zodiacTraits = ZodiacProfileEntity(
        sign: 'scorpio',
        element: 'water',
        modality: 'fixed',
        rulingPlanet: 'Pluto',
      );
      const prefs = PartnerPreferencesEntity(
        hobbies: ['reading', 'cooking'],
      );
      const cultural = CulturalContextEntity(
        background: 'Arab',
        religiousObservance: 'moderate',
      );

      final profile = PartnerProfileEntity(
        id: 'p1',
        userId: 'u1',
        name: 'Sara',
        birthday: birthday,
        zodiacSign: 'scorpio',
        zodiacTraits: zodiacTraits,
        loveLanguage: 'quality_time',
        communicationStyle: 'direct',
        relationshipStatus: 'married',
        anniversaryDate: anniversary,
        photoUrl: 'https://example.com/photo.jpg',
        preferences: prefs,
        culturalContext: cultural,
        profileCompletionPercent: 75,
        createdAt: now,
        updatedAt: now,
      );

      expect(profile.birthday, birthday);
      expect(profile.zodiacSign, 'scorpio');
      expect(profile.zodiacTraits, zodiacTraits);
      expect(profile.loveLanguage, 'quality_time');
      expect(profile.communicationStyle, 'direct');
      expect(profile.anniversaryDate, anniversary);
      expect(profile.photoUrl, 'https://example.com/photo.jpg');
      expect(profile.preferences, prefs);
      expect(profile.culturalContext, cultural);
      expect(profile.profileCompletionPercent, 75);
    });
  });

  group('copyWith', () {
    test('copies with updated name', () {
      final profile = createProfile();
      final copy = profile.copyWith(name: 'Fatima');
      expect(copy.name, 'Fatima');
      expect(copy.id, 'profile-1');
      expect(copy.relationshipStatus, 'married');
    });

    test('copies with updated zodiacSign', () {
      final profile = createProfile();
      final copy = profile.copyWith(zodiacSign: 'leo');
      expect(copy.zodiacSign, 'leo');
      expect(copy.name, 'Sara');
    });

    test('copies with updated loveLanguage', () {
      final profile = createProfile();
      final copy = profile.copyWith(loveLanguage: 'words_of_affirmation');
      expect(copy.loveLanguage, 'words_of_affirmation');
    });

    test('copies with updated photoUrl', () {
      final profile = createProfile();
      final copy = profile.copyWith(photoUrl: 'https://new-photo.com/img.jpg');
      expect(copy.photoUrl, 'https://new-photo.com/img.jpg');
    });

    test('copies with updated profileCompletionPercent', () {
      final profile = createProfile();
      final copy = profile.copyWith(profileCompletionPercent: 50);
      expect(copy.profileCompletionPercent, 50);
    });
  });

  group('equality', () {
    test('two profiles with same values are equal', () {
      final p1 = createProfile();
      final p2 = createProfile();
      expect(p1, equals(p2));
    });

    test('two profiles with different names are not equal', () {
      final p1 = createProfile();
      final p2 = p1.copyWith(name: 'Fatima');
      expect(p1, isNot(equals(p2)));
    });
  });

  group('hasMinimumForAI', () {
    test('returns false when no AI-relevant fields set', () {
      final profile = createProfile();
      expect(profile.hasMinimumForAI, false);
    });

    test('returns true when zodiacSign is set', () {
      final profile = createProfile(zodiacSign: 'scorpio');
      expect(profile.hasMinimumForAI, true);
    });

    test('returns true when loveLanguage is set', () {
      final profile = createProfile(loveLanguage: 'quality_time');
      expect(profile.hasMinimumForAI, true);
    });

    test('returns true when preferences is set', () {
      final profile = createProfile(
        preferences: const PartnerPreferencesEntity(
          hobbies: ['reading'],
        ),
      );
      expect(profile.hasMinimumForAI, true);
    });

    test('returns true when multiple AI fields are set', () {
      final profile = createProfile(
        zodiacSign: 'scorpio',
        loveLanguage: 'quality_time',
        preferences: const PartnerPreferencesEntity(),
      );
      expect(profile.hasMinimumForAI, true);
    });
  });

  group('zodiacDisplayName', () {
    test('returns empty string when zodiacSign is null', () {
      final profile = createProfile();
      expect(profile.zodiacDisplayName, '');
    });

    test('returns capitalized zodiac sign', () {
      final profile = createProfile(zodiacSign: 'scorpio');
      expect(profile.zodiacDisplayName, 'Scorpio');
    });

    test('handles already capitalized sign', () {
      final profile = createProfile(zodiacSign: 'Leo');
      expect(profile.zodiacDisplayName, 'Leo');
    });

    test('capitalizes first letter of multi-word sign', () {
      final profile = createProfile(zodiacSign: 'aries');
      expect(profile.zodiacDisplayName, 'Aries');
    });
  });

  group('ZodiacProfileEntity', () {
    test('creates with required fields', () {
      const zodiac = ZodiacProfileEntity(
        sign: 'scorpio',
        element: 'water',
        modality: 'fixed',
        rulingPlanet: 'Pluto',
      );
      expect(zodiac.sign, 'scorpio');
      expect(zodiac.element, 'water');
      expect(zodiac.modality, 'fixed');
      expect(zodiac.rulingPlanet, 'Pluto');
    });

    test('has empty default lists', () {
      const zodiac = ZodiacProfileEntity(
        sign: 'scorpio',
        element: 'water',
        modality: 'fixed',
        rulingPlanet: 'Pluto',
      );
      expect(zodiac.personality, isEmpty);
      expect(zodiac.communicationTips, isEmpty);
      expect(zodiac.emotionalNeeds, isEmpty);
      expect(zodiac.giftPreferences, isEmpty);
      expect(zodiac.conflictStyle, isNull);
      expect(zodiac.loveLanguageAffinity, isNull);
      expect(zodiac.bestApproachDuring, isNull);
    });

    test('creates with all fields', () {
      const zodiac = ZodiacProfileEntity(
        sign: 'scorpio',
        element: 'water',
        modality: 'fixed',
        rulingPlanet: 'Pluto',
        personality: ['intense', 'loyal'],
        communicationTips: ['Be direct'],
        emotionalNeeds: ['trust', 'depth'],
        conflictStyle: 'confrontational',
        giftPreferences: ['meaningful', 'personal'],
        loveLanguageAffinity: 'physical_touch',
        bestApproachDuring: {'stress': 'Give space'},
      );
      expect(zodiac.personality, ['intense', 'loyal']);
      expect(zodiac.communicationTips, ['Be direct']);
      expect(zodiac.emotionalNeeds, ['trust', 'depth']);
      expect(zodiac.conflictStyle, 'confrontational');
      expect(zodiac.giftPreferences, ['meaningful', 'personal']);
      expect(zodiac.loveLanguageAffinity, 'physical_touch');
      expect(zodiac.bestApproachDuring, {'stress': 'Give space'});
    });
  });

  group('CulturalContextEntity', () {
    test('creates with all null fields', () {
      const cultural = CulturalContextEntity();
      expect(cultural.background, isNull);
      expect(cultural.religiousObservance, isNull);
      expect(cultural.dialect, isNull);
    });

    test('shouldAddIslamicHolidays returns true for high observance', () {
      const cultural = CulturalContextEntity(religiousObservance: 'high');
      expect(cultural.shouldAddIslamicHolidays, true);
    });

    test('shouldAddIslamicHolidays returns true for moderate observance', () {
      const cultural = CulturalContextEntity(religiousObservance: 'moderate');
      expect(cultural.shouldAddIslamicHolidays, true);
    });

    test('shouldAddIslamicHolidays returns false for low observance', () {
      const cultural = CulturalContextEntity(religiousObservance: 'low');
      expect(cultural.shouldAddIslamicHolidays, false);
    });

    test('shouldAddIslamicHolidays returns false for null observance', () {
      const cultural = CulturalContextEntity();
      expect(cultural.shouldAddIslamicHolidays, false);
    });

    test('isHighObservance returns true for high', () {
      const cultural = CulturalContextEntity(religiousObservance: 'high');
      expect(cultural.isHighObservance, true);
    });

    test('isHighObservance returns false for moderate', () {
      const cultural = CulturalContextEntity(religiousObservance: 'moderate');
      expect(cultural.isHighObservance, false);
    });

    test('isHighObservance returns false for null', () {
      const cultural = CulturalContextEntity();
      expect(cultural.isHighObservance, false);
    });
  });

  group('PartnerPreferencesEntity', () {
    test('creates with defaults', () {
      const prefs = PartnerPreferencesEntity();
      expect(prefs.favorites, isEmpty);
      expect(prefs.dislikes, isEmpty);
      expect(prefs.hobbies, isEmpty);
      expect(prefs.stressCoping, isNull);
      expect(prefs.notes, isNull);
    });

    test('filledCount returns 0 for empty preferences', () {
      const prefs = PartnerPreferencesEntity();
      expect(prefs.filledCount, 0);
    });

    test('filledCount counts all items', () {
      const prefs = PartnerPreferencesEntity(
        favorites: {
          'flowers': ['roses', 'tulips'],
          'food': ['sushi'],
        },
        dislikes: ['loud music'],
        hobbies: ['reading', 'cooking'],
        stressCoping: 'walks',
        notes: 'Likes surprises',
      );
      // favorites: 2+1=3, dislikes: 1, hobbies: 2, stressCoping: 1, notes: 1 = 8
      expect(prefs.filledCount, 8);
    });

    test('filledCount counts only non-null optional fields', () {
      const prefs = PartnerPreferencesEntity(
        hobbies: ['reading'],
        stressCoping: 'meditation',
      );
      // hobbies: 1, stressCoping: 1 = 2
      expect(prefs.filledCount, 2);
    });
  });
}
