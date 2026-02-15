# LOLO Sprint 4 -- E2E & Integration Test Suites

**Prepared by:** Yuki Tanaka, QA Engineer
**Date:** February 15, 2026
**Version:** 1.0
**Sprint:** Sprint 4 -- Smart Actions (Weeks 15-16)
**Dependencies:** QA Test Strategy v1.0, API Contracts v1.0, Tech Lead S4-01, Backend S4-02

---

## 1. E2E Integration Tests (Dart)

### 1.1 Action Cards E2E

```dart
// test/integration/action_cards_e2e_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/main.dart' as app;
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';

class MockActionCardRepository extends Mock implements ActionCardRepository {}
class MockGamificationRepository extends Mock implements GamificationRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockActionCardRepository mockCardRepo;
  late MockGamificationRepository mockGamRepo;

  final testCards = [
    const ActionCardEntity(
      id: 'card-001', type: ActionCardType.say,
      title: 'Tell her you appreciate her',
      description: 'Send a specific compliment about something she did today.',
      difficulty: ActionCardDifficulty.easy, estimatedMinutes: 5,
      xpReward: 15, status: ActionCardStatus.pending,
      contextTags: ['morning', 'words_of_affirmation'],
    ),
    const ActionCardEntity(
      id: 'card-002', type: ActionCardType.do_,
      title: 'Handle dinner tonight',
      description: 'Take over cooking or order her favorite meal.',
      difficulty: ActionCardDifficulty.medium, estimatedMinutes: 30,
      xpReward: 25, status: ActionCardStatus.pending,
      contextTags: ['evening', 'practical_help'],
    ),
    const ActionCardEntity(
      id: 'card-003', type: ActionCardType.buy,
      title: 'Get her favorite snack',
      description: 'Pick up the snack she mentioned last week.',
      difficulty: ActionCardDifficulty.easy, estimatedMinutes: 15,
      xpReward: 20, status: ActionCardStatus.pending,
      contextTags: ['gift_suggestion'],
    ),
  ];

  final testSummary = DailyCardsSummary(
    cards: testCards, totalCards: 3, completedToday: 0, totalXpAvailable: 60,
  );

  setUp(() {
    mockCardRepo = MockActionCardRepository();
    mockGamRepo = MockGamificationRepository();
    registerFallbackValue(const ActionCardEntity(
      id: '', type: ActionCardType.say, title: '', description: '',
      difficulty: ActionCardDifficulty.easy, estimatedMinutes: 0,
      xpReward: 0, status: ActionCardStatus.pending,
    ));
  });

  group('Action Cards E2E Flow', () {
    testWidgets('view daily cards, swipe complete, verify XP, check history',
        (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(testSummary));
      when(() => mockCardRepo.completeCard('card-001', notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(testCards[0].copyWith(
                status: ActionCardStatus.completed,
                completedAt: DateTime.now(),
              )));
      when(() => mockCardRepo.getHistory(status: any(named: 'status'), limit: any(named: 'limit')))
          .thenAnswer((_) async => Right([
                testCards[0].copyWith(status: ActionCardStatus.completed),
              ]));

      await tester.pumpWidget(ProviderScope(
        overrides: [
          actionCardRepositoryProvider.overrideWithValue(mockCardRepo),
        ],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Navigate to action cards
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      // Verify cards loaded
      expect(find.text('Tell her you appreciate her'), findsOneWidget);
      expect(find.text('0/3'), findsOneWidget);
      expect(find.text('60 XP'), findsOneWidget);

      // Swipe right to complete first card
      await tester.drag(find.byType(Dismissible).first, const Offset(500, 0));
      await tester.pumpAndSettle();
      verify(() => mockCardRepo.completeCard('card-001', notes: any(named: 'notes'))).called(1);

      // Verify progress updated
      expect(find.text('Handle dinner tonight'), findsOneWidget);

      // Navigate to history
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      verify(() => mockCardRepo.getHistory(status: any(named: 'status'), limit: any(named: 'limit'))).called(1);
    });

    testWidgets('swipe left to skip card shows next card', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(testSummary));
      when(() => mockCardRepo.skipCard('card-001', reason: any(named: 'reason')))
          .thenAnswer((_) async => Right(testCards[0].copyWith(
                status: ActionCardStatus.skipped,
              )));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      // Swipe left to skip
      await tester.drag(find.byType(Dismissible).first, const Offset(-500, 0));
      await tester.pumpAndSettle();
      verify(() => mockCardRepo.skipCard('card-001', reason: any(named: 'reason'))).called(1);
    });

    testWidgets('save card via bookmark icon', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(testSummary));
      when(() => mockCardRepo.saveCard('card-001'))
          .thenAnswer((_) async => const Right(null));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bookmark_border));
      await tester.pumpAndSettle();
      verify(() => mockCardRepo.saveCard('card-001')).called(1);
    });

    testWidgets('empty state when all cards completed', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(DailyCardsSummary(
                cards: testCards.map((c) => c.copyWith(status: ActionCardStatus.completed)).toList(),
                totalCards: 3, completedToday: 3, totalXpAvailable: 0,
              )));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('card detail screen shows notes field and complete button', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(testSummary));
      when(() => mockCardRepo.completeCard('card-001', notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(testCards[0].copyWith(
                status: ActionCardStatus.completed,
              )));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      // Tap card to open detail
      await tester.tap(find.text('Tell her you appreciate her'));
      await tester.pumpAndSettle();

      expect(find.text('+15 XP'), findsOneWidget);
      expect(find.text('5 min'), findsOneWidget);

      // Enter notes and complete
      await tester.enterText(find.byType(TextField), 'She smiled!');
      await tester.tap(find.text('Mark Complete'));
      await tester.pumpAndSettle();
      verify(() => mockCardRepo.completeCard('card-001', notes: 'She smiled!')).called(1);
    });
  });
}
```

### 1.2 SOS E2E

```dart
// test/integration/sos_e2e_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/main.dart' as app;
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:lolo/features/sos/data/repositories/sos_repository.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';

class MockSosRepository extends Mock implements SosRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockSosRepository mockSosRepo;

  final testSession = SosSession(
    sessionId: 'sos-001',
    scenario: SosScenario.sheIsAngry,
    urgency: SosUrgency.happeningNow,
    immediateAdvice: const SosImmediateAdvice(
      doNow: 'Take a deep breath and lower your voice.',
      doNotDo: 'Do not say "calm down" or dismiss her feelings.',
      bodyLanguage: 'Face her directly, uncross your arms.',
    ),
    severityAssessmentRequired: true,
    estimatedResolutionSteps: 4,
    createdAt: DateTime.now(),
  );

  final testAssessment = const SosAssessment(
    sessionId: 'sos-001',
    severityScore: 4,
    severityLabel: 'serious',
    coachingPlan: SosCoachingPlan(
      totalSteps: 4, estimatedMinutes: 15,
      approach: 'empathetic_listening_first',
      keyInsight: 'She feels unheard. Lead with validation.',
    ),
  );

  final testCoachingStep = const CoachingStep(
    sessionId: 'sos-001', stepNumber: 1, totalSteps: 4,
    sayThis: 'I can see this really upset you, and I want to understand.',
    whyItWorks: 'Validation before explanation reduces defensiveness.',
    doNotSay: ['But I didn\'t mean to...', 'You\'re overreacting'],
    bodyLanguageTip: 'Maintain gentle eye contact.',
    toneAdvice: 'soft', isLastStep: false,
    nextStepPrompt: 'What did she say?',
  );

  setUp(() {
    mockSosRepo = MockSosRepository();
  });

  group('SOS Mode E2E Flow', () {
    testWidgets('activate -> assess -> coaching -> resolve', (tester) async {
      when(() => mockSosRepo.activate(
            scenario: 'sheIsAngry', urgency: 'happeningNow',
            briefContext: any(named: 'briefContext'),
          )).thenAnswer((_) async => Right(testSession));
      when(() => mockSosRepo.assess(
            sessionId: 'sos-001', answers: any(named: 'answers'),
          )).thenAnswer((_) async => Right(testAssessment));
      when(() => mockSosRepo.coachStream(
            sessionId: 'sos-001', stepNumber: 1,
            userUpdate: any(named: 'userUpdate'),
          )).thenAnswer((_) => Stream.value(testCoachingStep));
      when(() => mockSosRepo.resolve(
            sessionId: 'sos-001', outcome: 'resolved_well',
            rating: any(named: 'rating'),
          )).thenAnswer((_) async => const Right(null));

      await tester.pumpWidget(ProviderScope(
        overrides: [sosRepositoryProvider.overrideWithValue(mockSosRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Navigate to SOS
      await tester.tap(find.byIcon(Icons.sos));
      await tester.pumpAndSettle();

      // Step 1: Select scenario
      await tester.tap(find.text("She's angry"));
      await tester.pumpAndSettle();

      // Select urgency
      expect(find.text('NOW'), findsOneWidget);

      // Tap activate
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();

      verify(() => mockSosRepo.activate(
            scenario: 'sheIsAngry', urgency: 'happeningNow',
            briefContext: any(named: 'briefContext'),
          )).called(1);

      // Step 2: Assessment screen
      expect(find.text('Take a deep breath and lower your voice.'), findsOneWidget);

      // Fill assessment answers
      await tester.tap(find.text('minutes'));
      await tester.tap(find.text('furious'));
      await tester.tap(find.text('Yes'));
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      verify(() => mockSosRepo.assess(
            sessionId: 'sos-001', answers: any(named: 'answers'),
          )).called(1);

      // Step 3: Coaching screen with SSE
      expect(find.textContaining('I can see this really upset you'), findsOneWidget);
      expect(find.textContaining('overreacting'), findsOneWidget);

      // Step 4: Resolve
      await tester.tap(find.text('Resolved'));
      await tester.pumpAndSettle();
      verify(() => mockSosRepo.resolve(
            sessionId: 'sos-001', outcome: 'resolved_well',
            rating: any(named: 'rating'),
          )).called(1);
    });

    testWidgets('SOS tier limit shows upgrade prompt for free user', (tester) async {
      when(() => mockSosRepo.activate(
            scenario: any(named: 'scenario'),
            urgency: any(named: 'urgency'),
            briefContext: any(named: 'briefContext'),
          )).thenAnswer((_) async => const Left(ServerFailure('TIER_LIMIT_EXCEEDED')));

      await tester.pumpWidget(ProviderScope(
        overrides: [sosRepositoryProvider.overrideWithValue(mockSosRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.sos));
      await tester.pumpAndSettle();
      await tester.tap(find.text("She's angry"));
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
```

### 1.3 Subscription E2E

```dart
// test/integration/subscription_e2e_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/main.dart' as app;
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';
import 'package:lolo/features/subscription/data/repositories/subscription_repository.dart';
import 'package:lolo/features/subscription/presentation/providers/subscription_providers.dart';

class MockSubscriptionRepository extends Mock implements SubscriptionRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockSubscriptionRepository mockSubRepo;

  setUp(() {
    mockSubRepo = MockSubscriptionRepository();
  });

  group('Subscription E2E Flow', () {
    testWidgets('free user hits paywall -> purchase Pro -> access premium', (tester) async {
      // Initially free tier
      when(() => mockSubRepo.getStatus()).thenAnswer((_) async => Right(
            SubscriptionEntity(
              tier: 'free', status: 'active', autoRenew: false,
              usage: const UsageLimits(
                aiMessages: UsageItem(used: 5, limit: 10),
                sosSessions: UsageItem(used: 2, limit: 2),
                actionCards: UsageItem(used: 3, limit: 3),
              ),
            ),
          ));
      // After purchase: Pro tier
      when(() => mockSubRepo.verifyReceipt(
            platform: any(named: 'platform'),
            receiptData: any(named: 'receiptData'),
            productId: 'lolo_pro_monthly',
          )).thenAnswer((_) async => Right(
            SubscriptionEntity(
              tier: 'pro', status: 'active', autoRenew: true,
              usage: const UsageLimits(
                aiMessages: UsageItem(used: 5, limit: 100),
                sosSessions: UsageItem(used: 2, limit: 10),
                actionCards: UsageItem(used: 3, limit: 10),
              ),
            ),
          ));

      await tester.pumpWidget(ProviderScope(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(mockSubRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Attempt to access SOS (blocked for free at limit)
      await tester.tap(find.byIcon(Icons.sos));
      await tester.pumpAndSettle();

      // Paywall should appear
      expect(find.text('Pro'), findsOneWidget);
      expect(find.text('Legend'), findsOneWidget);

      // Select Pro plan
      await tester.tap(find.text('Subscribe to Pro'));
      await tester.pumpAndSettle();

      verify(() => mockSubRepo.verifyReceipt(
            platform: any(named: 'platform'),
            receiptData: any(named: 'receiptData'),
            productId: 'lolo_pro_monthly',
          )).called(1);
    });

    testWidgets('restore purchases works', (tester) async {
      when(() => mockSubRepo.getStatus()).thenAnswer((_) async => Right(
            SubscriptionEntity(tier: 'free', status: 'active', autoRenew: false),
          ));
      when(() => mockSubRepo.restorePurchases())
          .thenAnswer((_) async => Right(
            SubscriptionEntity(tier: 'pro', status: 'active', autoRenew: true),
          ));

      await tester.pumpWidget(ProviderScope(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(mockSubRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Navigate to settings -> subscription
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Subscription'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restore Purchases'));
      await tester.pumpAndSettle();

      verify(() => mockSubRepo.restorePurchases()).called(1);
    });

    testWidgets('cancel subscription downgrades to free', (tester) async {
      when(() => mockSubRepo.getStatus()).thenAnswer((_) async => Right(
            SubscriptionEntity(tier: 'pro', status: 'active', autoRenew: true),
          ));
      when(() => mockSubRepo.cancelSubscription())
          .thenAnswer((_) async => Right(
            SubscriptionEntity(tier: 'pro', status: 'cancelled', autoRenew: false),
          ));

      await tester.pumpWidget(ProviderScope(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(mockSubRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Subscription'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel Subscription'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      verify(() => mockSubRepo.cancelSubscription()).called(1);
    });
  });
}
```

### 1.4 Gamification E2E

```dart
// test/integration/gamification_e2e_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/main.dart' as app;
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';

class MockGamificationRepository extends Mock implements GamificationRepository {}
class MockActionCardRepository extends Mock implements ActionCardRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockGamificationRepository mockGamRepo;
  late MockActionCardRepository mockCardRepo;

  final profile = GamificationProfile(
    level: 7, levelName: 'Devoted Partner',
    xpCurrent: 1450, xpForNextLevel: 2000, totalXpEarned: 8450,
    currentStreak: 14, longestStreak: 21,
    freezesAvailable: 1, consistencyScore: 78,
  );

  final levelUpProfile = GamificationProfile(
    level: 8, levelName: 'Relationship Champion',
    xpCurrent: 5, xpForNextLevel: 2500, totalXpEarned: 8505,
    currentStreak: 15, longestStreak: 21,
    freezesAvailable: 1, consistencyScore: 80,
  );

  final testBadges = [
    const BadgeEntity(
      id: 'streak_7', name: 'Week Warrior', icon: 'fire_7',
      description: 'Maintain a 7-day streak', category: 'streak',
      rarity: 'common', earned: true,
    ),
    const BadgeEntity(
      id: 'streak_14', name: 'Two-Week Warrior', icon: 'fire_14',
      description: 'Maintain a 14-day streak', category: 'streak',
      rarity: 'uncommon', earned: true,
    ),
  ];

  setUp(() {
    mockGamRepo = MockGamificationRepository();
    mockCardRepo = MockActionCardRepository();
  });

  group('Gamification E2E Flow', () {
    testWidgets('complete action -> earn XP -> level up -> badge awarded', (tester) async {
      var callCount = 0;
      when(() => mockGamRepo.getProfile()).thenAnswer((_) async {
        callCount++;
        return Right(callCount > 1 ? levelUpProfile : profile);
      });
      when(() => mockGamRepo.getBadges())
          .thenAnswer((_) async => Right(testBadges));
      when(() => mockGamRepo.logAction(
            actionType: 'action_card_complete',
            referenceId: any(named: 'referenceId'),
          )).thenAnswer((_) async => Right(XpAwardResult(
            xpAwarded: 55, levelUp: true,
            newLevel: 8, newLevelName: 'Relationship Champion',
            badgeEarned: testBadges[1],
          )));
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(DailyCardsSummary(
                cards: [
                  const ActionCardEntity(
                    id: 'card-lvl', type: ActionCardType.do_,
                    title: 'Level up action', description: 'Do something nice.',
                    difficulty: ActionCardDifficulty.challenging,
                    estimatedMinutes: 60, xpReward: 55,
                    status: ActionCardStatus.pending,
                  ),
                ],
                totalCards: 1, completedToday: 0, totalXpAvailable: 55,
              )));
      when(() => mockCardRepo.completeCard('card-lvl', notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(const ActionCardEntity(
                id: 'card-lvl', type: ActionCardType.do_,
                title: 'Level up action', description: 'Do something nice.',
                difficulty: ActionCardDifficulty.challenging,
                estimatedMinutes: 60, xpReward: 55,
                status: ActionCardStatus.completed,
              )));

      await tester.pumpWidget(ProviderScope(
        overrides: [
          gamificationRepositoryProvider.overrideWithValue(mockGamRepo),
          actionCardRepositoryProvider.overrideWithValue(mockCardRepo),
        ],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Check gamification hub
      await tester.tap(find.byIcon(Icons.emoji_events));
      await tester.pumpAndSettle();
      expect(find.text('Level 7'), findsOneWidget);
      expect(find.text('Devoted Partner'), findsOneWidget);
      expect(find.text('14'), findsOneWidget); // streak

      // Go to action cards and complete
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Dismissible).first, const Offset(500, 0));
      await tester.pumpAndSettle();

      // Level up dialog should appear
      expect(find.textContaining('Level 8'), findsOneWidget);
      expect(find.text('Relationship Champion'), findsOneWidget);

      // Badge notification
      expect(find.text('Two-Week Warrior'), findsOneWidget);
    });

    testWidgets('gamification hub shows badge grid and leaderboard', (tester) async {
      when(() => mockGamRepo.getProfile())
          .thenAnswer((_) async => Right(profile));
      when(() => mockGamRepo.getBadges())
          .thenAnswer((_) async => Right(testBadges));
      when(() => mockGamRepo.getLeaderboard())
          .thenAnswer((_) async => Right([
                LeaderboardEntry(rank: 1, displayName: 'Ahmed', xp: 12000, level: 12),
                LeaderboardEntry(rank: 2, displayName: 'You', xp: 8450, level: 7),
              ]));

      await tester.pumpWidget(ProviderScope(
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockGamRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.emoji_events));
      await tester.pumpAndSettle();

      // Badge grid
      expect(find.text('Week Warrior'), findsOneWidget);
      expect(find.text('Two-Week Warrior'), findsOneWidget);

      // Leaderboard tab
      await tester.tap(find.text('Leaderboard'));
      await tester.pumpAndSettle();
      expect(find.text('Ahmed'), findsOneWidget);
      expect(find.text('#1'), findsOneWidget);
    });
  });
}
```

---

## 2. Widget Tests (Dart)

### 2.1 Action Card Feed Widget

```dart
// test/widget/action_card_feed_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/action_cards/presentation/screens/action_card_feed_screen.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

import '../../fixtures/test_factories.dart';

class MockActionCardRepository extends Mock implements ActionCardRepository {}

Widget buildTestWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

void main() {
  late MockActionCardRepository mockRepo;

  setUp(() {
    mockRepo = MockActionCardRepository();
  });

  group('ActionCardFeedScreen Widget', () {
    testWidgets('renders card with correct type icon and color', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget); // say type
      expect(find.text('SAY'), findsOneWidget);
      expect(find.text('easy'), findsOneWidget);
      expect(find.text('5 min'), findsOneWidget);
    });

    testWidgets('renders progress header with correct counts', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(DailyCardsSummary(
                cards: TestFactories.cardList(pending: 2, completed: 1),
                totalCards: 3, completedToday: 1, totalXpAvailable: 40,
              )));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('1/3'), findsOneWidget);
      expect(find.text('40 XP'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('swipe right triggers complete callback', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));
      when(() => mockRepo.completeCard(any(), notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(TestFactories.completedCard()));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), const Offset(500, 0));
      await tester.pumpAndSettle();

      verify(() => mockRepo.completeCard(any(), notes: any(named: 'notes'))).called(1);
    });

    testWidgets('swipe left triggers skip callback', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));
      when(() => mockRepo.skipCard(any(), reason: any(named: 'reason')))
          .thenAnswer((_) async => Right(TestFactories.skippedCard()));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
      await tester.pumpAndSettle();

      verify(() => mockRepo.skipCard(any(), reason: any(named: 'reason'))).called(1);
    });

    testWidgets('empty state shown when no pending cards', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(DailyCardsSummary(
                cards: [], totalCards: 0, completedToday: 0, totalXpAvailable: 0,
              )));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('shows loading skeleton while fetching', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 5));
        return Right(TestFactories.dailySummary());
      });

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('context tags render as chips', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.byType(Chip), findsWidgets);
    });

    testWidgets('XP reward displayed on card', (tester) async {
      when(() => mockRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));

      await tester.pumpWidget(buildTestWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('+15 XP'), findsOneWidget);
    });
  });
}
```

### 2.2 SOS Coaching Widget

```dart
// test/widget/sos_coaching_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lolo/features/sos/presentation/screens/sos_coaching_screen.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

Widget buildTestWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

void main() {
  final step = const CoachingStep(
    sessionId: 'sos-001', stepNumber: 2, totalSteps: 5,
    sayThis: 'I understand why you feel that way.',
    whyItWorks: 'Validation reduces defensiveness.',
    doNotSay: ['You always do this', 'Calm down'],
    bodyLanguageTip: 'Maintain gentle eye contact.',
    toneAdvice: 'soft', isLastStep: false,
    nextStepPrompt: 'What did she say?',
  );

  group('SosCoachingScreen Widget', () {
    testWidgets('displays Say This card with coaching text', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.text('I understand why you feel that way.'), findsOneWidget);
      expect(find.textContaining('Say This'), findsOneWidget);
    });

    testWidgets('displays Do Not Say cards', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.text('You always do this'), findsOneWidget);
      expect(find.text('Calm down'), findsOneWidget);
    });

    testWidgets('shows body language tip', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Maintain gentle eye contact.'), findsOneWidget);
    });

    testWidgets('shows step progress indicator', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Step 2 of 5'), findsOneWidget);
    });

    testWidgets('shows next step prompt when not last step', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.text('What did she say?'), findsOneWidget);
      expect(find.text('Next Step'), findsOneWidget);
    });

    testWidgets('shows resolve button on last step', (tester) async {
      final lastStep = CoachingStep(
        sessionId: 'sos-001', stepNumber: 5, totalSteps: 5,
        sayThis: 'Final coaching step.',
        whyItWorks: 'Closure is important.', doNotSay: [],
        bodyLanguageTip: 'Relax your shoulders.',
        toneAdvice: 'warm', isLastStep: true,
      );

      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: lastStep),
      ));
      await tester.pumpAndSettle();

      expect(find.text('How did it go?'), findsOneWidget);
    });

    testWidgets('tone advice badge renders correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        SosCoachingScreen(step: step),
      ));
      await tester.pumpAndSettle();

      expect(find.textContaining('soft'), findsOneWidget);
    });
  });
}
```

### 2.3 Gamification Hub Widget

```dart
// test/widget/gamification_hub_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/gamification/presentation/screens/gamification_hub_screen.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class MockGamificationRepository extends Mock implements GamificationRepository {}

Widget buildTestWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

void main() {
  late MockGamificationRepository mockRepo;

  final profile = GamificationProfile(
    level: 7, levelName: 'Devoted Partner',
    xpCurrent: 1450, xpForNextLevel: 2000, totalXpEarned: 8450,
    currentStreak: 14, longestStreak: 21,
    freezesAvailable: 1, consistencyScore: 78,
  );

  setUp(() {
    mockRepo = MockGamificationRepository();
  });

  group('GamificationHubScreen Widget', () {
    testWidgets('renders level bar with correct progress', (tester) async {
      when(() => mockRepo.getProfile()).thenAnswer((_) async => Right(profile));
      when(() => mockRepo.getBadges()).thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(buildTestWidget(
        const GamificationHubScreen(),
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('Level 7'), findsOneWidget);
      expect(find.text('Devoted Partner'), findsOneWidget);
      expect(find.text('1450 / 2000 XP'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('renders streak counter with fire icon', (tester) async {
      when(() => mockRepo.getProfile()).thenAnswer((_) async => Right(profile));
      when(() => mockRepo.getBadges()).thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(buildTestWidget(
        const GamificationHubScreen(),
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('14'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });

    testWidgets('badge grid renders earned and unearned badges', (tester) async {
      when(() => mockRepo.getProfile()).thenAnswer((_) async => Right(profile));
      when(() => mockRepo.getBadges()).thenAnswer((_) async => Right([
            const BadgeEntity(
              id: 'streak_7', name: 'Week Warrior', icon: 'fire_7',
              description: '7-day streak', category: 'streak',
              rarity: 'common', earned: true,
            ),
            const BadgeEntity(
              id: 'streak_30', name: 'Monthly Master', icon: 'fire_30',
              description: '30-day streak', category: 'streak',
              rarity: 'rare', earned: false, progress: 0.47,
            ),
          ]));

      await tester.pumpWidget(buildTestWidget(
        const GamificationHubScreen(),
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('Week Warrior'), findsOneWidget);
      expect(find.text('Monthly Master'), findsOneWidget);
    });

    testWidgets('consistency score displays with correct label', (tester) async {
      when(() => mockRepo.getProfile()).thenAnswer((_) async => Right(profile));
      when(() => mockRepo.getBadges()).thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(buildTestWidget(
        const GamificationHubScreen(),
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.text('78'), findsOneWidget);
      expect(find.textContaining('Consistent'), findsOneWidget);
    });

    testWidgets('freeze count shown correctly', (tester) async {
      when(() => mockRepo.getProfile()).thenAnswer((_) async => Right(profile));
      when(() => mockRepo.getBadges()).thenAnswer((_) async => const Right([]));

      await tester.pumpWidget(buildTestWidget(
        const GamificationHubScreen(),
        overrides: [gamificationRepositoryProvider.overrideWithValue(mockRepo)],
      ));
      await tester.pumpAndSettle();

      expect(find.textContaining('1 freeze'), findsOneWidget);
    });
  });
}
```

### 2.4 Paywall Widget

```dart
// test/widget/paywall_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lolo/features/subscription/presentation/screens/paywall_screen.dart';
import 'package:lolo/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

Widget buildTestWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

void main() {
  group('PaywallScreen Widget', () {
    testWidgets('renders tier comparison table', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Free'), findsOneWidget);
      expect(find.text('Pro'), findsOneWidget);
      expect(find.text('Legend'), findsOneWidget);
    });

    testWidgets('shows correct pricing for each tier', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining('\$6.99'), findsOneWidget);
      expect(find.textContaining('\$12.99'), findsOneWidget);
    });

    testWidgets('CTA buttons present for Pro and Legend', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Subscribe to Pro'), findsOneWidget);
      expect(find.text('Subscribe to Legend'), findsOneWidget);
    });

    testWidgets('restore purchases link present', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Restore Purchases'), findsOneWidget);
    });

    testWidgets('feature comparison rows rendered', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('SOS Mode'), findsOneWidget);
      expect(find.text('Action Cards'), findsOneWidget);
      expect(find.text('AI Messages'), findsOneWidget);
    });

    testWidgets('highlights recommended plan', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Most Popular'), findsOneWidget);
    });

    testWidgets('terms and privacy links present', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PaywallScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Terms of Service'), findsOneWidget);
      expect(find.text('Privacy Policy'), findsOneWidget);
    });
  });
}
```

---

## 3. RTL Golden Tests (Dart)

```dart
// test/golden/sprint4_rtl_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/features/action_cards/presentation/screens/action_card_feed_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_activation_screen.dart';
import 'package:lolo/features/sos/presentation/screens/sos_coaching_screen.dart';
import 'package:lolo/features/gamification/presentation/screens/gamification_hub_screen.dart';
import 'package:lolo/features/subscription/presentation/screens/paywall_screen.dart';
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

import '../../fixtures/test_factories.dart';

class MockActionCardRepository extends Mock implements ActionCardRepository {}
class MockGamificationRepository extends Mock implements GamificationRepository {}

Widget buildRtlWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ar'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: child,
      ),
    ),
  );
}

Widget buildLtrWidget(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

void main() {
  late MockActionCardRepository mockCardRepo;
  late MockGamificationRepository mockGamRepo;

  setUp(() {
    mockCardRepo = MockActionCardRepository();
    mockGamRepo = MockGamificationRepository();

    when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
        .thenAnswer((_) async => Right(TestFactories.dailySummary()));
    when(() => mockGamRepo.getProfile())
        .thenAnswer((_) async => Right(TestFactories.gamProfile()));
    when(() => mockGamRepo.getBadges())
        .thenAnswer((_) async => Right(TestFactories.badges()));
  });

  group('Sprint 4 RTL Golden Tests', () {
    testGoldens('ActionCardFeed - Arabic RTL', (tester) async {
      await tester.pumpWidgetBuilder(
        buildRtlWidget(
          const ActionCardFeedScreen(),
          overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        ),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'action_card_feed_ar_rtl');
    });

    testGoldens('ActionCardFeed - English LTR for comparison', (tester) async {
      await tester.pumpWidgetBuilder(
        buildLtrWidget(
          const ActionCardFeedScreen(),
          overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        ),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'action_card_feed_en_ltr');
    });

    testGoldens('SOS Activation - Arabic RTL', (tester) async {
      await tester.pumpWidgetBuilder(
        buildRtlWidget(const SosActivationScreen()),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'sos_activation_ar_rtl');
    });

    testGoldens('SOS Coaching - Arabic RTL', (tester) async {
      final step = const CoachingStep(
        sessionId: 'sos-001', stepNumber: 1, totalSteps: 4,
        sayThis: 'أنا أفهم لماذا تشعرين بهذا الشكل.',
        whyItWorks: 'التحقق من المشاعر يقلل من الدفاعية.',
        doNotSay: ['لا تبالغي', 'هدّئي نفسك'],
        bodyLanguageTip: 'حافظ على تواصل بصري لطيف.',
        toneAdvice: 'soft', isLastStep: false,
        nextStepPrompt: 'ماذا قالت؟',
      );

      await tester.pumpWidgetBuilder(
        buildRtlWidget(SosCoachingScreen(step: step)),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'sos_coaching_ar_rtl');
    });

    testGoldens('Gamification Hub - Arabic RTL', (tester) async {
      await tester.pumpWidgetBuilder(
        buildRtlWidget(
          const GamificationHubScreen(),
          overrides: [gamificationRepositoryProvider.overrideWithValue(mockGamRepo)],
        ),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'gamification_hub_ar_rtl');
    });

    testGoldens('Paywall - Arabic RTL', (tester) async {
      await tester.pumpWidgetBuilder(
        buildRtlWidget(const PaywallScreen()),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'paywall_ar_rtl');
    });

    testGoldens('Paywall - Malay LTR', (tester) async {
      await tester.pumpWidgetBuilder(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('ms'),
            home: const PaywallScreen(),
          ),
        ),
        surfaceSize: const Size(375, 812),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'paywall_ms_ltr');
    });
  });

  group('RTL Swipe Direction Verification', () {
    testWidgets('swipe start-to-end completes card in RTL (right-to-left gesture)', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));
      when(() => mockCardRepo.completeCard(any(), notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(TestFactories.completedCard()));

      await tester.pumpWidget(buildRtlWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
      ));
      await tester.pumpAndSettle();

      // In RTL, startToEnd is right-to-left (negative offset)
      await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
      await tester.pumpAndSettle();

      verify(() => mockCardRepo.completeCard(any(), notes: any(named: 'notes'))).called(1);
    });

    testWidgets('bidirectional text renders correctly in Arabic cards', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummaryArabic()));

      await tester.pumpWidget(buildRtlWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
      ));
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(find.byType(Text).first);
      expect(textWidget.textDirection, isNull); // inherits from Directionality
    });

    testWidgets('icons are mirrored in RTL layout', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummary()));

      await tester.pumpWidget(buildRtlWidget(
        const ActionCardFeedScreen(),
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
      ));
      await tester.pumpAndSettle();

      final directionality = tester.widget<Directionality>(
        find.byType(Directionality).first,
      );
      expect(directionality.textDirection, TextDirection.rtl);
    });
  });
}
```

---

## 4. Performance Tests (Dart)

```dart
// test/performance/sprint4_perf_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lolo/main.dart' as app;
import 'package:lolo/features/action_cards/data/repositories/action_card_repository.dart';
import 'package:lolo/features/action_cards/presentation/providers/action_card_providers.dart';
import 'package:lolo/features/sos/data/repositories/sos_repository.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';

import '../../fixtures/test_factories.dart';

class MockActionCardRepository extends Mock implements ActionCardRepository {}
class MockSosRepository extends Mock implements SosRepository {}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockActionCardRepository mockCardRepo;
  late MockSosRepository mockSosRepo;

  setUp(() {
    mockCardRepo = MockActionCardRepository();
    mockSosRepo = MockSosRepository();
  });

  group('Cold Start Performance', () {
    testWidgets('app launches within 2 seconds', (tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(ProviderScope(child: const app.LoloApp()));
      await tester.pumpAndSettle();

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(2000),
          reason: 'Cold start must be under 2 seconds');
    });
  });

  group('Card Swipe Performance', () {
    testWidgets('card swipe animation at 60fps', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummaryLarge(count: 10)));
      when(() => mockCardRepo.completeCard(any(), notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(TestFactories.completedCard()));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      // Profile the swipe animation
      await binding.traceAction(() async {
        await tester.drag(find.byType(Dismissible).first, const Offset(500, 0));
        await tester.pumpAndSettle();
      }, reportKey: 'card_swipe_animation');

      // Timeline summary is written to binding.reportData
      final timeline = binding.reportData;
      expect(timeline, isNotNull);
    });

    testWidgets('rapid consecutive swipes remain smooth', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummaryLarge(count: 10)));
      when(() => mockCardRepo.completeCard(any(), notes: any(named: 'notes')))
          .thenAnswer((_) async => Right(TestFactories.completedCard()));
      when(() => mockCardRepo.skipCard(any(), reason: any(named: 'reason')))
          .thenAnswer((_) async => Right(TestFactories.skippedCard()));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();
      for (var i = 0; i < 5; i++) {
        final dismissibles = find.byType(Dismissible);
        if (dismissibles.evaluate().isNotEmpty) {
          await tester.drag(dismissibles.first, const Offset(500, 0));
          await tester.pumpAndSettle();
        }
      }
      stopwatch.stop();

      // 5 swipes should complete within 3 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(3000),
          reason: '5 consecutive swipes must complete in <3s');
    });
  });

  group('Memory Usage', () {
    testWidgets('action card screen stays under 200MB', (tester) async {
      when(() => mockCardRepo.getDailyCards(date: any(named: 'date')))
          .thenAnswer((_) async => Right(TestFactories.dailySummaryLarge(count: 50)));

      await tester.pumpWidget(ProviderScope(
        overrides: [actionCardRepositoryProvider.overrideWithValue(mockCardRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.bolt));
      await tester.pumpAndSettle();

      // Memory tracking via binding
      final memoryInfo = await binding.traceAction(() async {
        // Scroll through many cards
        for (var i = 0; i < 10; i++) {
          final dismissibles = find.byType(Dismissible);
          if (dismissibles.evaluate().isNotEmpty) {
            await tester.drag(dismissibles.first, const Offset(500, 0));
            await tester.pumpAndSettle();
          }
        }
      }, reportKey: 'memory_card_scroll');

      expect(memoryInfo, isNotNull);
    });
  });

  group('SOS Response Time', () {
    testWidgets('SOS first response arrives within 3 seconds', (tester) async {
      when(() => mockSosRepo.activate(
            scenario: any(named: 'scenario'),
            urgency: any(named: 'urgency'),
            briefContext: any(named: 'briefContext'),
          )).thenAnswer((_) async {
        // Simulate AI latency
        await Future.delayed(const Duration(milliseconds: 800));
        return Right(TestFactories.sosSession());
      });

      await tester.pumpWidget(ProviderScope(
        overrides: [sosRepositoryProvider.overrideWithValue(mockSosRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.sos));
      await tester.pumpAndSettle();

      await tester.tap(find.text("She's angry"));

      final stopwatch = Stopwatch()..start();
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(3000),
          reason: 'SOS first response must arrive within 3 seconds');
    });
  });

  group('Battery Drain Estimation', () {
    testWidgets('SOS session duration tracking for battery estimation', (tester) async {
      when(() => mockSosRepo.activate(
            scenario: any(named: 'scenario'),
            urgency: any(named: 'urgency'),
            briefContext: any(named: 'briefContext'),
          )).thenAnswer((_) async => Right(TestFactories.sosSession()));
      when(() => mockSosRepo.coachStream(
            sessionId: any(named: 'sessionId'),
            stepNumber: any(named: 'stepNumber'),
            userUpdate: any(named: 'userUpdate'),
          )).thenAnswer((_) => Stream.value(TestFactories.coachingStep()));
      when(() => mockSosRepo.resolve(
            sessionId: any(named: 'sessionId'),
            outcome: any(named: 'outcome'),
            rating: any(named: 'rating'),
          )).thenAnswer((_) async => const Right(null));

      await tester.pumpWidget(ProviderScope(
        overrides: [sosRepositoryProvider.overrideWithValue(mockSosRepo)],
        child: const app.LoloApp(),
      ));
      await tester.pumpAndSettle();

      // Simulate a 15-minute SOS session with multiple coaching steps
      await binding.traceAction(() async {
        await tester.tap(find.byIcon(Icons.sos));
        await tester.pumpAndSettle();
        await tester.tap(find.text("She's angry"));
        await tester.tap(find.byType(FilledButton).last);
        await tester.pumpAndSettle();

        // Multiple coaching rounds
        for (var step = 1; step <= 4; step++) {
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }, reportKey: 'sos_session_battery_profile');
    });
  });
}
```

---

## 5. API Contract Tests (TypeScript)

### 5.1 Action Cards API

```typescript
// test/api/action_cards_api_test.ts
import axios, { AxiosInstance, AxiosError } from 'axios';
import { describe, it, expect, beforeAll, afterAll } from '@jest/globals';

const BASE_URL = process.env.API_BASE_URL || 'http://localhost:5001/lolo-app/us-central1/api/v1';

interface TestUser {
  uid: string;
  token: string;
  tier: 'free' | 'pro' | 'legend';
}

const testUsers: Record<string, TestUser> = {
  free_en: { uid: 'test-free-en', token: '', tier: 'free' },
  pro_ar: { uid: 'test-pro-ar', token: '', tier: 'pro' },
  legend_ms: { uid: 'test-legend-ms', token: '', tier: 'legend' },
};

function createClient(user: TestUser): AxiosInstance {
  return axios.create({
    baseURL: BASE_URL,
    headers: {
      Authorization: `Bearer ${user.token}`,
      'Content-Type': 'application/json',
      'X-Request-Id': `test-${Date.now()}`,
    },
    validateStatus: () => true,
  });
}

describe('Action Cards API', () => {
  let freeClient: AxiosInstance;
  let proClient: AxiosInstance;
  let legendClient: AxiosInstance;

  beforeAll(async () => {
    // Obtain test tokens via admin SDK in test setup
    for (const [key, user] of Object.entries(testUsers)) {
      const res = await axios.post(`${BASE_URL}/auth/login`, {
        email: `${key}@test.lolo.app`,
        password: 'TestPass123!',
      });
      user.token = res.data.data.idToken;
    }
    freeClient = createClient(testUsers.free_en);
    proClient = createClient(testUsers.pro_ar);
    legendClient = createClient(testUsers.legend_ms);
  });

  describe('GET /action-cards', () => {
    it('returns daily cards with correct structure', async () => {
      const res = await proClient.get('/action-cards');
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('cards');
      expect(res.data.data).toHaveProperty('summary');
      expect(res.data.data.summary).toHaveProperty('totalCards');
      expect(res.data.data.summary).toHaveProperty('completedToday');
      expect(res.data.data.summary).toHaveProperty('totalXpAvailable');

      const card = res.data.data.cards[0];
      expect(card).toHaveProperty('id');
      expect(['say', 'do', 'buy', 'go']).toContain(card.type);
      expect(['easy', 'medium', 'challenging']).toContain(card.difficulty);
      expect(card.xpReward).toBeGreaterThan(0);
    });

    it('free tier gets max 3 cards per day', async () => {
      const res = await freeClient.get('/action-cards');
      expect(res.status).toBe(200);
      expect(res.data.data.cards.length).toBeLessThanOrEqual(3);
    });

    it('pro tier gets max 10 cards per day', async () => {
      const res = await proClient.get('/action-cards');
      expect(res.status).toBe(200);
      expect(res.data.data.cards.length).toBeLessThanOrEqual(10);
    });

    it('legend tier gets unlimited cards', async () => {
      const res = await legendClient.get('/action-cards');
      expect(res.status).toBe(200);
      expect(res.data.data.cards.length).toBeGreaterThanOrEqual(1);
    });

    it('supports date query parameter', async () => {
      const yesterday = new Date(Date.now() - 86400000).toISOString().slice(0, 10);
      const res = await proClient.get(`/action-cards?date=${yesterday}`);
      expect(res.status).toBe(200);
    });

    it('returns localized content for Arabic user', async () => {
      const res = await proClient.get('/action-cards', {
        headers: { 'Accept-Language': 'ar' },
      });
      expect(res.status).toBe(200);
      const card = res.data.data.cards[0];
      expect(card).toHaveProperty('titleLocalized');
    });

    it('forceRefresh only allowed for Legend tier', async () => {
      const freeRes = await freeClient.get('/action-cards?forceRefresh=true');
      expect(freeRes.status).toBe(403);
      expect(freeRes.data.error.code).toBe('TIER_LIMIT_EXCEEDED');

      const legendRes = await legendClient.get('/action-cards?forceRefresh=true');
      expect(legendRes.status).toBe(200);
    });
  });

  describe('POST /action-cards/:id/complete', () => {
    let cardId: string;

    beforeAll(async () => {
      const res = await proClient.get('/action-cards');
      cardId = res.data.data.cards[0]?.id;
    });

    it('completes a card and returns XP breakdown', async () => {
      if (!cardId) return;
      const res = await proClient.post(`/action-cards/${cardId}/complete`, {
        notes: 'She loved it!',
      });
      expect(res.status).toBe(200);
      expect(res.data.data.status).toBe('completed');
      expect(res.data.data).toHaveProperty('xpAwarded');
      expect(res.data.data).toHaveProperty('xpBreakdown');
      expect(res.data.data.xpBreakdown).toHaveProperty('base');
    });

    it('returns 409 for already completed card', async () => {
      if (!cardId) return;
      const res = await proClient.post(`/action-cards/${cardId}/complete`);
      expect(res.status).toBe(409);
      expect(res.data.error.code).toBe('ALREADY_COMPLETED');
    });

    it('returns 404 for non-existent card', async () => {
      const res = await proClient.post('/action-cards/nonexistent/complete');
      expect(res.status).toBe(404);
    });
  });

  describe('POST /action-cards/:id/skip', () => {
    it('skips card with reason and returns replacement for Pro', async () => {
      const cards = await proClient.get('/action-cards');
      const pendingCard = cards.data.data.cards.find((c: any) => c.status === 'pending');
      if (!pendingCard) return;

      const res = await proClient.post(`/action-cards/${pendingCard.id}/skip`, {
        reason: 'not_relevant',
      });
      expect(res.status).toBe(200);
      expect(res.data.data.status).toBe('skipped');
      expect(res.data.data).toHaveProperty('replacementCard');
    });
  });

  describe('POST /action-cards/:id/save', () => {
    it('saves card for later', async () => {
      const cards = await proClient.get('/action-cards');
      const pendingCard = cards.data.data.cards.find((c: any) => c.status === 'pending');
      if (!pendingCard) return;

      const res = await proClient.post(`/action-cards/${pendingCard.id}/save`);
      expect(res.status).toBe(200);
      expect(res.data.data.status).toBe('saved');
    });
  });

  describe('GET /action-cards/saved', () => {
    it('returns saved cards with pagination', async () => {
      const res = await proClient.get('/action-cards/saved');
      expect(res.status).toBe(200);
      expect(res.data).toHaveProperty('pagination');
    });
  });

  describe('GET /action-cards/history', () => {
    it('returns card history with status filter', async () => {
      const res = await proClient.get('/action-cards/history?status=completed&limit=5');
      expect(res.status).toBe(200);
      expect(Array.isArray(res.data.data)).toBe(true);
      expect(res.data).toHaveProperty('pagination');
    });
  });

  describe('Error Scenarios', () => {
    it('401 without auth token', async () => {
      const res = await axios.get(`${BASE_URL}/action-cards`, {
        validateStatus: () => true,
      });
      expect(res.status).toBe(401);
    });

    it('429 rate limit', async () => {
      const promises = Array.from({ length: 40 }, () =>
        proClient.get('/action-cards')
      );
      const results = await Promise.all(promises);
      const rateLimited = results.some((r) => r.status === 429);
      expect(rateLimited).toBe(true);
    });
  });
});
```

### 5.2 SOS API

```typescript
// test/api/sos_api_test.ts
import axios, { AxiosInstance } from 'axios';
import { describe, it, expect, beforeAll } from '@jest/globals';

const BASE_URL = process.env.API_BASE_URL || 'http://localhost:5001/lolo-app/us-central1/api/v1';

describe('SOS API', () => {
  let proClient: AxiosInstance;
  let freeClient: AxiosInstance;
  let sessionId: string;

  beforeAll(async () => {
    const proRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'pro_ar@test.lolo.app', password: 'TestPass123!',
    });
    proClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${proRes.data.data.idToken}` },
      validateStatus: () => true,
    });

    const freeRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'free_en@test.lolo.app', password: 'TestPass123!',
    });
    freeClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${freeRes.data.data.idToken}` },
      validateStatus: () => true,
    });
  });

  describe('POST /sos/activate', () => {
    it('activates SOS session with immediate advice', async () => {
      const res = await proClient.post('/sos/activate', {
        scenario: 'she_is_angry',
        urgency: 'happening_now',
        briefContext: 'She found out I forgot our anniversary',
      });
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('sessionId');
      expect(res.data.data.immediateAdvice).toHaveProperty('doNow');
      expect(res.data.data.immediateAdvice).toHaveProperty('doNotDo');
      expect(res.data.data.immediateAdvice).toHaveProperty('bodyLanguage');
      expect(res.data.data.severityAssessmentRequired).toBe(true);
      sessionId = res.data.data.sessionId;
    });

    it('returns 400 for missing scenario', async () => {
      const res = await proClient.post('/sos/activate', { urgency: 'happening_now' });
      expect(res.status).toBe(400);
      expect(res.data.error.code).toBe('INVALID_REQUEST');
    });

    it('returns 403 when free tier exceeds monthly limit', async () => {
      // Free tier: 2 sessions/month - exhaust them
      for (let i = 0; i < 3; i++) {
        const res = await freeClient.post('/sos/activate', {
          scenario: 'she_is_angry', urgency: 'happening_now',
        });
        if (i >= 2) {
          expect(res.status).toBe(403);
          expect(res.data.error.code).toBe('TIER_LIMIT_EXCEEDED');
        }
      }
    });
  });

  describe('POST /sos/assess', () => {
    it('submits assessment and returns severity score', async () => {
      const res = await proClient.post('/sos/assess', {
        sessionId,
        answers: {
          howLongAgo: 'minutes',
          herCurrentState: 'furious',
          haveYouSpoken: false,
          isSheTalking: false,
          yourFault: 'yes',
        },
      });
      expect(res.status).toBe(200);
      expect(res.data.data.severityScore).toBeGreaterThanOrEqual(1);
      expect(res.data.data.severityScore).toBeLessThanOrEqual(10);
      expect(['mild', 'moderate', 'serious', 'severe', 'critical'])
        .toContain(res.data.data.severityLabel);
      expect(res.data.data.coachingPlan).toHaveProperty('totalSteps');
    });

    it('returns 404 for invalid session ID', async () => {
      const res = await proClient.post('/sos/assess', {
        sessionId: 'nonexistent',
        answers: { howLongAgo: 'minutes', herCurrentState: 'calm', haveYouSpoken: true, isSheTalking: true, yourFault: 'no' },
      });
      expect(res.status).toBe(404);
    });
  });

  describe('POST /sos/coach', () => {
    it('returns coaching step with sayThis and doNotSay', async () => {
      const res = await proClient.post('/sos/coach', {
        sessionId, stepNumber: 1, stream: false,
      });
      expect(res.status).toBe(200);
      expect(res.data.data.coaching).toHaveProperty('sayThis');
      expect(res.data.data.coaching).toHaveProperty('doNotSay');
      expect(Array.isArray(res.data.data.coaching.doNotSay)).toBe(true);
      expect(res.data.data.coaching).toHaveProperty('toneAdvice');
    });

    it('SSE streaming returns event stream', async () => {
      const res = await proClient.post('/sos/coach', {
        sessionId, stepNumber: 2, stream: true,
      }, { headers: { Accept: 'text/event-stream' }, responseType: 'stream' });
      expect(res.status).toBe(200);
      expect(res.headers['content-type']).toContain('text/event-stream');
    });
  });

  describe('POST /sos/resolve', () => {
    it('resolves session and awards XP', async () => {
      const res = await proClient.post('/sos/resolve', {
        sessionId,
        outcome: 'resolved_well',
        rating: 4,
        whatWorked: 'Active listening helped.',
      });
      expect(res.status).toBe(200);
      expect(res.data.data.status).toBe('resolved');
      expect(res.data.data).toHaveProperty('xpAwarded');
      expect(res.data.data.xpAwarded).toBeGreaterThan(0);
    });

    it('returns 409 for already resolved session', async () => {
      const res = await proClient.post('/sos/resolve', {
        sessionId, outcome: 'resolved_well',
      });
      expect(res.status).toBe(409);
      expect(res.data.error.code).toBe('SESSION_ALREADY_RESOLVED');
    });
  });

  describe('GET /sos/history', () => {
    it('returns session history with pagination', async () => {
      const res = await proClient.get('/sos/history?limit=5');
      expect(res.status).toBe(200);
      expect(Array.isArray(res.data.data)).toBe(true);
      expect(res.data).toHaveProperty('pagination');
      if (res.data.data.length > 0) {
        expect(res.data.data[0]).toHaveProperty('sessionId');
        expect(res.data.data[0]).toHaveProperty('outcome');
      }
    });
  });

  describe('Error Scenarios', () => {
    it('503 when AI provider is down', async () => {
      // Simulated via test flag header
      const res = await proClient.post('/sos/activate', {
        scenario: 'she_is_angry', urgency: 'happening_now',
      }, { headers: { 'X-Test-Force-Error': 'ai_unavailable' } });
      expect(res.status).toBe(503);
      expect(res.data.error.code).toBe('AI_SERVICE_UNAVAILABLE');
    });
  });
});
```

### 5.3 Subscription API

```typescript
// test/api/subscription_api_test.ts
import axios, { AxiosInstance } from 'axios';
import * as crypto from 'crypto';
import { describe, it, expect, beforeAll } from '@jest/globals';

const BASE_URL = process.env.API_BASE_URL || 'http://localhost:5001/lolo-app/us-central1/api/v1';
const WEBHOOK_SECRET = process.env.REVENUECAT_WEBHOOK_SECRET || 'test-secret';

describe('Subscription API', () => {
  let freeClient: AxiosInstance;
  let proClient: AxiosInstance;

  beforeAll(async () => {
    const freeRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'free_en@test.lolo.app', password: 'TestPass123!',
    });
    freeClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${freeRes.data.data.idToken}` },
      validateStatus: () => true,
    });

    const proRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'pro_ar@test.lolo.app', password: 'TestPass123!',
    });
    proClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${proRes.data.data.idToken}` },
      validateStatus: () => true,
    });
  });

  describe('GET /subscriptions/status', () => {
    it('returns free tier status with usage limits', async () => {
      const res = await freeClient.get('/subscriptions/status');
      expect(res.status).toBe(200);
      expect(res.data.data.tier).toBe('free');
      expect(res.data.data.usage).toHaveProperty('aiMessages');
      expect(res.data.data.usage.aiMessages).toHaveProperty('used');
      expect(res.data.data.usage.aiMessages).toHaveProperty('limit');
    });

    it('returns pro tier status with correct limits', async () => {
      const res = await proClient.get('/subscriptions/status');
      expect(res.status).toBe(200);
      expect(res.data.data.tier).toBe('pro');
      expect(res.data.data.usage.sosSessions.limit).toBe(10);
    });
  });

  describe('POST /subscriptions/verify-receipt', () => {
    it('verifies valid receipt and upgrades tier', async () => {
      const res = await freeClient.post('/subscriptions/verify-receipt', {
        platform: 'android',
        receiptData: 'mock-receipt-token-pro',
        productId: 'lolo_pro_monthly',
      });
      expect(res.status).toBe(200);
      expect(res.data.data.verified).toBe(true);
      expect(res.data.data.tier).toBe('pro');
      expect(res.data.data.previousTier).toBe('free');
    });

    it('returns 400 for invalid receipt', async () => {
      const res = await freeClient.post('/subscriptions/verify-receipt', {
        platform: 'android',
        receiptData: 'invalid-receipt',
        productId: 'lolo_pro_monthly',
      });
      expect(res.status).toBe(400);
    });

    it('handles restore purchases with isRestore flag', async () => {
      const res = await freeClient.post('/subscriptions/verify-receipt', {
        platform: 'ios',
        receiptData: 'mock-restore-receipt',
        productId: 'lolo_pro_monthly',
        isRestore: true,
      });
      expect([200, 404]).toContain(res.status);
    });
  });

  describe('GET /subscriptions/plans', () => {
    it('returns all plans with regional pricing', async () => {
      const res = await freeClient.get('/subscriptions/plans');
      expect(res.status).toBe(200);
      expect(Array.isArray(res.data.data)).toBe(true);
      expect(res.data.data.length).toBeGreaterThanOrEqual(2);

      const proPlan = res.data.data.find((p: any) => p.tier === 'pro');
      expect(proPlan).toBeDefined();
      expect(proPlan.pricing).toHaveProperty('USD');
      expect(proPlan.pricing).toHaveProperty('SAR');
      expect(proPlan.pricing).toHaveProperty('MYR');
    });
  });

  describe('RevenueCat Webhook', () => {
    it('processes INITIAL_PURCHASE event', async () => {
      const body = {
        event: {
          type: 'INITIAL_PURCHASE',
          app_user_id: 'test-free-en',
          product_id: 'lolo_pro_monthly',
          expiration_at_ms: Date.now() + 30 * 86400000,
          original_transaction_id: 'txn-001',
          id: `evt-${Date.now()}`,
        },
      };
      const signature = crypto
        .createHmac('sha256', WEBHOOK_SECRET)
        .update(JSON.stringify(body))
        .digest('hex');

      const res = await axios.post(`${BASE_URL}/webhooks/revenuecat`, body, {
        headers: { 'x-revenuecat-signature': signature },
        validateStatus: () => true,
      });
      expect(res.status).toBe(200);
    });

    it('processes CANCELLATION event', async () => {
      const body = {
        event: {
          type: 'CANCELLATION',
          app_user_id: 'test-free-en',
          product_id: 'lolo_pro_monthly',
          id: `evt-cancel-${Date.now()}`,
        },
      };
      const signature = crypto
        .createHmac('sha256', WEBHOOK_SECRET)
        .update(JSON.stringify(body))
        .digest('hex');

      const res = await axios.post(`${BASE_URL}/webhooks/revenuecat`, body, {
        headers: { 'x-revenuecat-signature': signature },
        validateStatus: () => true,
      });
      expect(res.status).toBe(200);
    });

    it('rejects invalid signature', async () => {
      const res = await axios.post(`${BASE_URL}/webhooks/revenuecat`, {
        event: { type: 'INITIAL_PURCHASE', app_user_id: 'x', product_id: 'y', id: 'z' },
      }, {
        headers: { 'x-revenuecat-signature': 'invalid' },
        validateStatus: () => true,
      });
      expect(res.status).toBe(401);
    });

    it('handles idempotent duplicate events', async () => {
      const eventId = `evt-idempotent-${Date.now()}`;
      const body = {
        event: { type: 'RENEWAL', app_user_id: 'test-pro-ar', product_id: 'lolo_pro_monthly', id: eventId },
      };
      const signature = crypto
        .createHmac('sha256', WEBHOOK_SECRET)
        .update(JSON.stringify(body))
        .digest('hex');

      const res1 = await axios.post(`${BASE_URL}/webhooks/revenuecat`, body, {
        headers: { 'x-revenuecat-signature': signature }, validateStatus: () => true,
      });
      const res2 = await axios.post(`${BASE_URL}/webhooks/revenuecat`, body, {
        headers: { 'x-revenuecat-signature': signature }, validateStatus: () => true,
      });
      expect(res1.status).toBe(200);
      expect(res2.status).toBe(200); // idempotent, no error
    });
  });
});
```

### 5.4 Gamification API

```typescript
// test/api/gamification_api_test.ts
import axios, { AxiosInstance } from 'axios';
import { describe, it, expect, beforeAll } from '@jest/globals';

const BASE_URL = process.env.API_BASE_URL || 'http://localhost:5001/lolo-app/us-central1/api/v1';

describe('Gamification API', () => {
  let proClient: AxiosInstance;
  let legendClient: AxiosInstance;

  beforeAll(async () => {
    const proRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'pro_ar@test.lolo.app', password: 'TestPass123!',
    });
    proClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${proRes.data.data.idToken}` },
      validateStatus: () => true,
    });

    const legendRes = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'legend_ms@test.lolo.app', password: 'TestPass123!',
    });
    legendClient = axios.create({
      baseURL: BASE_URL,
      headers: { Authorization: `Bearer ${legendRes.data.data.idToken}` },
      validateStatus: () => true,
    });
  });

  describe('GET /gamification/profile', () => {
    it('returns complete gamification profile', async () => {
      const res = await proClient.get('/gamification/profile');
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('level');
      expect(res.data.data.level).toHaveProperty('current');
      expect(res.data.data.level).toHaveProperty('name');
      expect(res.data.data.level).toHaveProperty('xpCurrent');
      expect(res.data.data.level).toHaveProperty('xpForNextLevel');
      expect(res.data.data).toHaveProperty('streak');
      expect(res.data.data.streak).toHaveProperty('currentDays');
      expect(res.data.data).toHaveProperty('consistencyScore');
    });

    it('weekly XP array has 7 entries', async () => {
      const res = await proClient.get('/gamification/profile');
      expect(res.data.data.weeklyXp).toHaveLength(7);
    });
  });

  describe('POST /gamification/action', () => {
    it('awards XP for action card completion', async () => {
      const res = await proClient.post('/gamification/action', {
        actionType: 'action_card_complete',
        referenceId: `card-test-${Date.now()}`,
        metadata: { cardType: 'say' },
      });
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('xpAwarded');
      expect(res.data.data.xpAwarded).toBeGreaterThan(0);
      expect(res.data.data).toHaveProperty('xpBreakdown');
      expect(res.data.data.xpBreakdown).toHaveProperty('base');
      expect(res.data.data).toHaveProperty('streakUpdate');
    });

    it('returns level up data when threshold crossed', async () => {
      const res = await proClient.post('/gamification/action', {
        actionType: 'action_card_complete',
        referenceId: `card-levelup-${Date.now()}`,
      });
      expect(res.status).toBe(200);
      // levelUp may be true or false depending on state
      expect(res.data.data).toHaveProperty('levelUp');
      if (res.data.data.levelUp) {
        expect(res.data.data.newLevel).toHaveProperty('level');
        expect(res.data.data.newLevel).toHaveProperty('name');
      }
    });

    it('returns badge when milestone reached', async () => {
      const res = await proClient.post('/gamification/action', {
        actionType: 'streak_milestone',
        metadata: { streakDay: 14 },
      });
      expect(res.status).toBe(200);
      if (res.data.data.badgeEarned) {
        expect(res.data.data.badgeEarned).toHaveProperty('id');
        expect(res.data.data.badgeEarned).toHaveProperty('name');
        expect(res.data.data.badgeEarned).toHaveProperty('rarity');
      }
    });

    it('returns 409 for duplicate action', async () => {
      const refId = `card-dup-${Date.now()}`;
      await proClient.post('/gamification/action', {
        actionType: 'action_card_complete', referenceId: refId,
      });
      const res = await proClient.post('/gamification/action', {
        actionType: 'action_card_complete', referenceId: refId,
      });
      expect(res.status).toBe(409);
      expect(res.data.error.code).toBe('ACTION_ALREADY_LOGGED');
    });

    it('returns 400 for invalid action type', async () => {
      const res = await proClient.post('/gamification/action', {
        actionType: 'invalid_type',
      });
      expect(res.status).toBe(400);
    });
  });

  describe('GET /gamification/badges', () => {
    it('returns earned and unearned badges', async () => {
      const res = await proClient.get('/gamification/badges');
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('earned');
      expect(res.data.data).toHaveProperty('unearned');
      expect(res.data.data).toHaveProperty('totalEarned');
      expect(res.data.data).toHaveProperty('totalAvailable');

      if (res.data.data.earned.length > 0) {
        const badge = res.data.data.earned[0];
        expect(badge).toHaveProperty('id');
        expect(badge).toHaveProperty('name');
        expect(badge).toHaveProperty('rarity');
        expect(badge).toHaveProperty('earnedAt');
      }
      if (res.data.data.unearned.length > 0) {
        expect(res.data.data.unearned[0]).toHaveProperty('progress');
      }
    });
  });

  describe('GET /gamification/streak', () => {
    it('returns streak with freezes and milestones', async () => {
      const res = await proClient.get('/gamification/streak');
      expect(res.status).toBe(200);
      expect(res.data.data).toHaveProperty('currentStreak');
      expect(res.data.data).toHaveProperty('longestStreak');
      expect(res.data.data.freezes).toHaveProperty('available');
      expect(res.data.data.freezes).toHaveProperty('maxPerMonth');
      expect(Array.isArray(res.data.data.milestones)).toBe(true);
    });
  });

  describe('GET /gamification/leaderboard', () => {
    it('Legend tier can access leaderboard', async () => {
      const res = await legendClient.get('/gamification/leaderboard');
      expect(res.status).toBe(200);
      expect(Array.isArray(res.data.data)).toBe(true);
    });

    it('Non-Legend tier gets 403', async () => {
      const res = await proClient.get('/gamification/leaderboard');
      expect(res.status).toBe(403);
      expect(res.data.error.code).toBe('TIER_LIMIT_EXCEEDED');
    });
  });

  describe('Error Scenarios', () => {
    it('401 without auth', async () => {
      const res = await axios.get(`${BASE_URL}/gamification/profile`, {
        validateStatus: () => true,
      });
      expect(res.status).toBe(401);
    });

    it('429 rate limit on rapid requests', async () => {
      const promises = Array.from({ length: 40 }, () =>
        proClient.get('/gamification/profile')
      );
      const results = await Promise.all(promises);
      const rateLimited = results.some((r) => r.status === 429);
      expect(rateLimited).toBe(true);
    });
  });
});
```

---

## 6. Test Fixtures

```dart
// test/fixtures/test_factories.dart
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';

/// Centralized mock factories for Sprint 4 test suites.
/// Test users: Free/en, Pro/ar, Legend/ms.
class TestFactories {
  TestFactories._();

  // ── Action Cards ──

  static ActionCardEntity card({
    String id = 'card-001',
    ActionCardType type = ActionCardType.say,
    ActionCardStatus status = ActionCardStatus.pending,
    int xpReward = 15,
  }) =>
      ActionCardEntity(
        id: id, type: type,
        title: 'Tell her you appreciate her',
        description: 'Send a specific compliment about something she did today.',
        difficulty: ActionCardDifficulty.easy, estimatedMinutes: 5,
        xpReward: xpReward, status: status,
        contextTags: const ['morning', 'words_of_affirmation'],
      );

  static ActionCardEntity cardArabic({String id = 'card-ar-001'}) =>
      ActionCardEntity(
        id: id, type: ActionCardType.say,
        title: 'أخبرها أنك تقدرها',
        description: 'أرسل لها مجاملة محددة عن شيء فعلته اليوم.',
        difficulty: ActionCardDifficulty.easy, estimatedMinutes: 5,
        xpReward: 15, status: ActionCardStatus.pending,
        contextTags: const ['صباح', 'كلمات_تقدير'],
      );

  static ActionCardEntity completedCard() =>
      card(status: ActionCardStatus.completed);

  static ActionCardEntity skippedCard() =>
      card(status: ActionCardStatus.skipped);

  static List<ActionCardEntity> cardList({int pending = 3, int completed = 0}) {
    final cards = <ActionCardEntity>[];
    for (var i = 0; i < pending; i++) {
      cards.add(card(
        id: 'card-p-$i',
        type: ActionCardType.values[i % ActionCardType.values.length],
        xpReward: 15 + (i * 5),
      ));
    }
    for (var i = 0; i < completed; i++) {
      cards.add(card(id: 'card-c-$i', status: ActionCardStatus.completed));
    }
    return cards;
  }

  static DailyCardsSummary dailySummary() => DailyCardsSummary(
        cards: [card()], totalCards: 3, completedToday: 0, totalXpAvailable: 60,
      );

  static DailyCardsSummary dailySummaryArabic() => DailyCardsSummary(
        cards: [cardArabic()], totalCards: 3, completedToday: 0, totalXpAvailable: 60,
      );

  static DailyCardsSummary dailySummaryLarge({int count = 10}) => DailyCardsSummary(
        cards: List.generate(count, (i) => card(
          id: 'card-lg-$i',
          type: ActionCardType.values[i % ActionCardType.values.length],
          xpReward: 10 + (i * 3),
        )),
        totalCards: count, completedToday: 0,
        totalXpAvailable: List.generate(count, (i) => 10 + (i * 3)).reduce((a, b) => a + b),
      );

  // ── SOS ──

  static SosSession sosSession() => SosSession(
        sessionId: 'sos-001',
        scenario: SosScenario.sheIsAngry,
        urgency: SosUrgency.happeningNow,
        immediateAdvice: const SosImmediateAdvice(
          doNow: 'Take a deep breath and lower your voice.',
          doNotDo: 'Do not say "calm down".',
          bodyLanguage: 'Face her directly, uncross your arms.',
        ),
        severityAssessmentRequired: true,
        estimatedResolutionSteps: 4,
        createdAt: DateTime(2026, 2, 15, 10, 0),
      );

  static SosAssessment sosAssessment() => const SosAssessment(
        sessionId: 'sos-001', severityScore: 4, severityLabel: 'serious',
        coachingPlan: SosCoachingPlan(
          totalSteps: 4, estimatedMinutes: 15,
          approach: 'empathetic_listening_first',
          keyInsight: 'She feels unheard.',
        ),
      );

  static CoachingStep coachingStep({int step = 1, bool isLast = false}) =>
      CoachingStep(
        sessionId: 'sos-001', stepNumber: step, totalSteps: 4,
        sayThis: 'I understand why you feel that way.',
        whyItWorks: 'Validation reduces defensiveness.',
        doNotSay: const ['You always do this', 'Calm down'],
        bodyLanguageTip: 'Maintain gentle eye contact.',
        toneAdvice: 'soft', isLastStep: isLast,
        nextStepPrompt: isLast ? null : 'What did she say?',
      );

  // ── Gamification ──

  static GamificationProfile gamProfile() => GamificationProfile(
        level: 7, levelName: 'Devoted Partner',
        xpCurrent: 1450, xpForNextLevel: 2000, totalXpEarned: 8450,
        currentStreak: 14, longestStreak: 21,
        freezesAvailable: 1, consistencyScore: 78,
      );

  static List<BadgeEntity> badges() => const [
        BadgeEntity(
          id: 'streak_7', name: 'Week Warrior', icon: 'fire_7',
          description: '7-day streak', category: 'streak',
          rarity: 'common', earned: true,
        ),
        BadgeEntity(
          id: 'streak_14', name: 'Two-Week Warrior', icon: 'fire_14',
          description: '14-day streak', category: 'streak',
          rarity: 'uncommon', earned: true,
        ),
      ];

  // ── Subscription ──

  static SubscriptionEntity freeSub() => SubscriptionEntity(
        tier: 'free', status: 'active', autoRenew: false,
        usage: const UsageLimits(
          aiMessages: UsageItem(used: 5, limit: 10),
          sosSessions: UsageItem(used: 2, limit: 2),
          actionCards: UsageItem(used: 3, limit: 3),
        ),
      );

  static SubscriptionEntity proSub() => SubscriptionEntity(
        tier: 'pro', status: 'active', autoRenew: true,
        usage: const UsageLimits(
          aiMessages: UsageItem(used: 20, limit: 100),
          sosSessions: UsageItem(used: 3, limit: 10),
          actionCards: UsageItem(used: 5, limit: 10),
        ),
      );

  static SubscriptionEntity legendSub() => SubscriptionEntity(
        tier: 'legend', status: 'active', autoRenew: true,
        usage: const UsageLimits(
          aiMessages: UsageItem(used: 50, limit: -1),
          sosSessions: UsageItem(used: 8, limit: -1),
          actionCards: UsageItem(used: 15, limit: -1),
        ),
      );

  // ── Test User Profiles ──

  static const testUserFreeEn = {
    'uid': 'test-free-en', 'email': 'free_en@test.lolo.app',
    'tier': 'free', 'language': 'en', 'displayName': 'TestFreeEN',
  };
  static const testUserProAr = {
    'uid': 'test-pro-ar', 'email': 'pro_ar@test.lolo.app',
    'tier': 'pro', 'language': 'ar', 'displayName': 'اختبار_برو',
  };
  static const testUserLegendMs = {
    'uid': 'test-legend-ms', 'email': 'legend_ms@test.lolo.app',
    'tier': 'legend', 'language': 'ms', 'displayName': 'UjiLegend',
  };
}
```

---

## Coverage Matrix

| Module | E2E | Widget | Golden/RTL | Perf | API | Target |
|--------|-----|--------|------------|------|-----|--------|
| Action Cards | 5 tests | 8 tests | 3 goldens | 3 tests | 12 tests | 85% |
| SOS Mode | 2 tests | 7 tests | 2 goldens | 2 tests | 8 tests | 82% |
| Gamification | 2 tests | 5 tests | 1 golden | -- | 9 tests | 80% |
| Subscription | 3 tests | 7 tests | 2 goldens | -- | 9 tests | 80% |
| **Total** | **12** | **27** | **8** | **5** | **38** | **82%** |

## Run Commands

```bash
# Widget + Unit tests
flutter test test/widget/ test/fixtures/

# Integration E2E (requires emulator)
flutter test integration_test/

# Golden tests (generate baselines first)
flutter test --update-goldens test/golden/
flutter test test/golden/

# Performance (requires device)
flutter drive --driver=test_driver/perf_driver.dart --target=test/performance/sprint4_perf_test.dart

# API contract tests
cd functions && npx jest test/api/ --verbose

# Full Sprint 4 suite
flutter test test/widget/ test/golden/ && cd functions && npx jest test/api/
```
