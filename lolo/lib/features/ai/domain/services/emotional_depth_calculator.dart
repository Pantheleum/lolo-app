// FILE: lib/features/ai/domain/services/emotional_depth_calculator.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class EmotionalDepthCalculator {
  const EmotionalDepthCalculator._();

  static int calculate({
    required AiMessageMode mode,
    EmotionalState? emotionalState,
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
    int? situationSeverity,
  }) {
    int score = mode.baseDepth;

    if (emotionalState != null && emotionalState.increasesDepth) {
      score++;
    }

    if (cyclePhase != null && cyclePhase.increasesDepth) {
      score++;
    }

    if (isPregnant && trimester == 1) {
      score++;
    }

    if (situationSeverity != null && situationSeverity >= 4) {
      score++;
    }

    return score.clamp(1, 5);
  }

  /// SOS always returns depth 5
  static int forSos() => 5;
}
