// FILE: lib/features/ai/data/services/content_safety_filter.dart

class SafetyValidationResult {
  final bool isValid;
  final String? reason;
  final SafetyCategory? category;

  const SafetyValidationResult.valid()
      : isValid = true,
        reason = null,
        category = null;

  const SafetyValidationResult.blocked(this.reason, this.category) : isValid = false;
}

enum SafetyCategory {
  manipulation,
  explicit,
  harmful,
  promptInjection,
  pii,
  aiIdentity,
}

class ContentSafetyFilter {
  // Pre-generation: validate user input before sending to backend
  SafetyValidationResult validateInput(String? text) {
    if (text == null || text.isEmpty) return const SafetyValidationResult.valid();

    final lower = text.toLowerCase();

    // Prompt injection detection
    for (final pattern in _injectionPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot process this request.',
          SafetyCategory.promptInjection,
        );
      }
    }

    // Manipulation/harmful content detection
    for (final pattern in _manipulationPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot help with this type of request.',
          SafetyCategory.manipulation,
        );
      }
    }

    // Explicit content detection
    for (final pattern in _explicitPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot generate this type of content.',
          SafetyCategory.explicit,
        );
      }
    }

    // Length enforcement
    if (text.length > 500) {
      return const SafetyValidationResult.blocked(
        'Input exceeds maximum length.',
        SafetyCategory.harmful,
      );
    }

    return const SafetyValidationResult.valid();
  }

  // Post-generation: validate AI output before displaying
  SafetyValidationResult validateOutput(String content) {
    if (content.isEmpty) {
      return const SafetyValidationResult.blocked(
        'Empty response received.',
        SafetyCategory.harmful,
      );
    }

    final lower = content.toLowerCase();

    // AI identity leak detection
    for (final pattern in _aiIdentityPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'Response contained disallowed content.',
          SafetyCategory.aiIdentity,
        );
      }
    }

    // PII detection (phone numbers, emails)
    if (_phoneRegex.hasMatch(content) || _emailRegex.hasMatch(content)) {
      return const SafetyValidationResult.blocked(
        'Response contained personal information.',
        SafetyCategory.pii,
      );
    }

    // URL detection
    if (_urlRegex.hasMatch(content)) {
      return const SafetyValidationResult.blocked(
        'Response contained external links.',
        SafetyCategory.pii,
      );
    }

    return const SafetyValidationResult.valid();
  }

  // Sanitize free-text input (strip tags, normalize)
  String sanitize(String input) {
    var result = input;
    result = result.replaceAll(RegExp(r'<[^>]*>'), ''); // strip HTML
    result = result.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), ''); // control chars
    result = result.trim();
    return result;
  }

  static const _injectionPatterns = [
    'ignore previous instructions',
    'ignore all instructions',
    'ignore your instructions',
    'disregard previous',
    'disregard your',
    'forget your instructions',
    'override your',
    'you are now',
    'act as if',
    'pretend you are',
    'system prompt',
    'new instructions',
    'jailbreak',
    'developer mode',
    'dan mode',
  ];

  static const _manipulationPatterns = [
    'gaslight',
    'manipulate her',
    'make her jealous',
    'make her feel guilty',
    'control her',
    'how to lie to',
    'trick her into',
    'guilt trip',
    'emotional blackmail',
    'threaten',
    'stalk',
    'spy on',
    'track her without',
  ];

  static const _explicitPatterns = [
    'sexually explicit',
    'nude photo',
    'sexual act',
    'sexual position',
  ];

  static const _aiIdentityPatterns = [
    'as an ai',
    'i am an ai',
    "i'm an ai",
    'as a language model',
    'as an artificial',
    'i am chatgpt',
    'i am claude',
    'i am gemini',
    'i am grok',
    'powered by openai',
    'powered by anthropic',
    'lolo ai engine',
  ];

  static final _phoneRegex = RegExp(
    r'(?:\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}',
  );

  static final _emailRegex = RegExp(
    r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
  );

  static final _urlRegex = RegExp(
    r'https?://[^\s]+',
  );
}
