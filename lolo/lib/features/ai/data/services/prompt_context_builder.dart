// FILE: lib/features/ai/data/services/prompt_context_builder.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class PromptContextBuilder {
  String? _partnerName;
  String? _userName;
  String? _zodiacSign;
  String? _loveLanguage;
  String? _communicationStyle;
  String? _culturalBackground;
  String? _religiousObservance;
  EmotionalState? _emotionalState;
  CyclePhase? _cyclePhase;
  bool _isPregnant = false;
  int? _trimester;
  String? _relationshipStatus;
  int? _relationshipDurationMonths;
  int? _humorLevel;
  String? _humorType;
  List<String> _recentMemories = [];
  List<String> _upcomingEvents = [];
  String _language = 'en';
  String? _dialect;

  PromptContextBuilder();

  PromptContextBuilder partnerProfile({
    required String partnerName,
    String? zodiacSign,
    String? loveLanguage,
    String? communicationStyle,
    String? culturalBackground,
    String? religiousObservance,
    int? humorLevel,
    String? humorType,
  }) {
    _partnerName = partnerName;
    _zodiacSign = zodiacSign;
    _loveLanguage = loveLanguage;
    _communicationStyle = communicationStyle;
    _culturalBackground = culturalBackground;
    _religiousObservance = religiousObservance;
    _humorLevel = humorLevel;
    _humorType = humorType;
    return this;
  }

  PromptContextBuilder userName(String name) {
    _userName = name;
    return this;
  }

  PromptContextBuilder relationship({
    required String status,
    int? durationMonths,
  }) {
    _relationshipStatus = status;
    _relationshipDurationMonths = durationMonths;
    return this;
  }

  PromptContextBuilder emotional(EmotionalState? state) {
    _emotionalState = state;
    return this;
  }

  PromptContextBuilder hormonal({
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
  }) {
    _cyclePhase = cyclePhase;
    _isPregnant = isPregnant;
    _trimester = trimester;
    return this;
  }

  PromptContextBuilder memories(List<String> memories) {
    _recentMemories = memories.take(5).toList();
    return this;
  }

  PromptContextBuilder calendar(List<String> events) {
    _upcomingEvents = events.take(3).toList();
    return this;
  }

  PromptContextBuilder locale({required String language, String? dialect}) {
    _language = language;
    _dialect = dialect;
    return this;
  }

  Map<String, dynamic> build() {
    return {
      if (_partnerName != null) 'partnerName': _partnerName,
      if (_userName != null) 'userName': _userName,
      if (_zodiacSign != null) 'zodiacSign': _zodiacSign,
      if (_loveLanguage != null) 'loveLanguage': _loveLanguage,
      if (_communicationStyle != null) 'communicationStyle': _communicationStyle,
      if (_culturalBackground != null) 'culturalBackground': _culturalBackground,
      if (_religiousObservance != null) 'religiousObservance': _religiousObservance,
      if (_emotionalState != null) 'emotionalState': _emotionalState!.name,
      if (_cyclePhase != null) 'cyclePhase': _cyclePhase!.apiValue,
      'isPregnant': _isPregnant,
      if (_trimester != null) 'trimester': _trimester,
      if (_relationshipStatus != null) 'relationshipStatus': _relationshipStatus,
      if (_relationshipDurationMonths != null)
        'relationshipDurationMonths': _relationshipDurationMonths,
      if (_humorLevel != null) 'humorLevel': _humorLevel,
      if (_humorType != null) 'humorType': _humorType,
      if (_recentMemories.isNotEmpty) 'recentMemories': _recentMemories,
      if (_upcomingEvents.isNotEmpty) 'upcomingEvents': _upcomingEvents,
      'language': _language,
      if (_dialect != null) 'dialect': _dialect,
    };
  }

  int computeEmotionalDepth(AiMessageMode mode) {
    return EmotionalDepthCalculator.calculate(
      mode: mode,
      emotionalState: _emotionalState,
      cyclePhase: _cyclePhase,
      isPregnant: _isPregnant,
      trimester: _trimester,
    );
  }
}

class EmotionalDepthCalculator {
  static int calculate({
    required AiMessageMode mode,
    EmotionalState? emotionalState,
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
    int? situationSeverity,
  }) {
    int score = mode.baseDepth;
    if (emotionalState != null && emotionalState.increasesDepth) score++;
    if (cyclePhase != null && cyclePhase.increasesDepth) score++;
    if (isPregnant && trimester == 1) score++;
    if (situationSeverity != null && situationSeverity >= 4) score++;
    return score.clamp(1, 5);
  }
}
