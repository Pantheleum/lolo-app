// FILE: lib/features/ai/domain/enums/ai_enums.dart

enum AiMessageMode {
  goodMorning('good_morning', 1),
  checkingIn('checking_in', 1),
  appreciation('appreciation', 2),
  motivation('motivation', 2),
  celebration('celebration', 2),
  flirting('flirting', 2),
  reassurance('reassurance', 3),
  longDistance('long_distance', 3),
  apology('apology', 4),
  afterArgument('after_argument', 4);

  const AiMessageMode(this.apiValue, this.baseDepth);
  final String apiValue;
  final int baseDepth;

  static AiMessageMode fromApi(String value) =>
      AiMessageMode.values.firstWhere((e) => e.apiValue == value,
          orElse: () => AiMessageMode.checkingIn);
}

enum AiRequestType {
  message('message'),
  actionCard('action_card'),
  gift('gift'),
  sosCoaching('sos_coaching'),
  sosAssessment('sos_assessment'),
  analysis('analysis'),
  memoryQuery('memory_query');

  const AiRequestType(this.apiValue);
  final String apiValue;
}

enum AiTone {
  warm('warm'),
  playful('playful'),
  serious('serious'),
  romantic('romantic'),
  gentle('gentle'),
  confident('confident');

  const AiTone(this.apiValue);
  final String apiValue;

  static AiTone fromApi(String v) =>
      AiTone.values.firstWhere((e) => e.apiValue == v, orElse: () => AiTone.warm);
}

enum AiLength {
  short('short'),
  medium('medium'),
  long_('long');

  const AiLength(this.apiValue);
  final String apiValue;

  static AiLength fromApi(String v) =>
      AiLength.values.firstWhere((e) => e.apiValue == v, orElse: () => AiLength.medium);
}

enum SubscriptionTier {
  free('free', 10, 2, 3, 5),
  pro('pro', 100, 10, 10, 30),
  legend('legend', -1, -1, -1, -1); // -1 = unlimited

  const SubscriptionTier(
      this.apiValue, this.monthlyMessages, this.monthlySos, this.dailyCards, this.monthlyGifts);
  final String apiValue;
  final int monthlyMessages;
  final int monthlySos;
  final int dailyCards;
  final int monthlyGifts;

  bool get isUnlimited => this == SubscriptionTier.legend;

  static SubscriptionTier fromApi(String v) =>
      SubscriptionTier.values.firstWhere((e) => e.apiValue == v,
          orElse: () => SubscriptionTier.free);
}

enum EmotionalState {
  happy, stressed, sad, angry, anxious, neutral, excited, tired, overwhelmed, vulnerable;

  bool get increasesDepth => this == angry || this == anxious;
}

enum CyclePhase {
  follicular, ovulation, lutealEarly, lutealLate, menstruation, unknown;

  String get apiValue => switch (this) {
        CyclePhase.follicular => 'follicular',
        CyclePhase.ovulation => 'ovulation',
        CyclePhase.lutealEarly => 'luteal_early',
        CyclePhase.lutealLate => 'luteal_late',
        CyclePhase.menstruation => 'menstruation',
        CyclePhase.unknown => 'unknown',
      };

  bool get increasesDepth => this == CyclePhase.lutealLate;
}

enum SosScenario {
  sheIsAngry('she_is_angry'),
  sheIsCrying('she_is_crying'),
  sheIsSilent('she_is_silent'),
  caughtInLie('caught_in_lie'),
  forgotImportantDate('forgot_important_date'),
  saidWrongThing('said_wrong_thing'),
  sheWantsToTalk('she_wants_to_talk'),
  herFamilyConflict('her_family_conflict'),
  jealousyIssue('jealousy_issue'),
  other('other');

  const SosScenario(this.apiValue);
  final String apiValue;
}

enum SosUrgency {
  happeningNow('happening_now'),
  justHappened('just_happened'),
  brewing('brewing');

  const SosUrgency(this.apiValue);
  final String apiValue;
}

enum GiftOccasion {
  birthday('birthday'),
  anniversary('anniversary'),
  eid('eid'),
  valentines('valentines'),
  justBecause('just_because'),
  apology('apology'),
  congratulations('congratulations'),
  hariRaya('hari_raya'),
  christmas('christmas'),
  other('other');

  const GiftOccasion(this.apiValue);
  final String apiValue;
}

enum GiftType {
  physical('physical'),
  experience('experience'),
  digital('digital'),
  handmade('handmade'),
  any('any');

  const GiftType(this.apiValue);
  final String apiValue;
}

enum ActionCardType {
  say('say'),
  do_('do'),
  buy('buy'),
  go('go');

  const ActionCardType(this.apiValue);
  final String apiValue;

  static ActionCardType fromApi(String v) =>
      ActionCardType.values.firstWhere((e) => e.apiValue == v,
          orElse: () => ActionCardType.do_);
}

enum CardDifficulty {
  easy, medium, challenging;

  static CardDifficulty fromApi(String v) => switch (v) {
        'easy' => CardDifficulty.easy,
        'medium' => CardDifficulty.medium,
        'challenging' => CardDifficulty.challenging,
        _ => CardDifficulty.medium,
      };
}

enum CardStatus {
  pending, completed, skipped, saved;

  static CardStatus fromApi(String v) => switch (v) {
        'completed' => CardStatus.completed,
        'skipped' => CardStatus.skipped,
        'saved' => CardStatus.saved,
        _ => CardStatus.pending,
      };
}
