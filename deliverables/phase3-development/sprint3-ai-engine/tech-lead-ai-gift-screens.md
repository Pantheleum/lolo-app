# LOLO Sprint 3 -- AI Message Generator & Gift Recommendation Engine UI

**Task ID:** S3-01
**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 3 -- AI Engine (Weeks 13-14)
**Dependencies:** Flutter Scaffold (S1-01), UI Components (S1-02), Core Screens (S2-01), API Contracts v1.0

---

## Table of Contents

1. [Module 5: AI Message Generator](#module-5-ai-message-generator)
   - Screen 19: Mode Picker
   - Screen 20: Message Configuration
   - Screen 21: Generated Message Result
   - Screen 22: Message History
2. [Module 6: Gift Recommendation Engine](#module-6-gift-recommendation-engine)
   - Screen 23: Gift Browse
   - Screen 24: Gift Detail
   - Screen 25: Gift History
3. [Route Registration Updates](#route-registration-updates)

---

## Module 5: AI Message Generator

### 5.1 Domain Layer

#### `lib/features/ai_messages/domain/entities/message_mode.dart`

```dart
import 'package:flutter/material.dart';

/// Represents one of the 10 AI message generation modes.
///
/// Modes 0-2 are free tier; modes 3-9 require premium subscription.
/// Each mode has an icon, localized name key, and description key
/// used by the Mode Picker grid.
enum MessageMode {
  romantic(icon: Icons.favorite, freeAccess: true),
  apology(icon: Icons.healing, freeAccess: true),
  appreciation(icon: Icons.thumb_up, freeAccess: true),
  flirty(icon: Icons.local_fire_department, freeAccess: false),
  encouragement(icon: Icons.emoji_events, freeAccess: false),
  missYou(icon: Icons.flight_takeoff, freeAccess: false),
  goodMorning(icon: Icons.wb_sunny, freeAccess: false),
  goodNight(icon: Icons.nightlight_round, freeAccess: false),
  anniversary(icon: Icons.cake, freeAccess: false),
  custom(icon: Icons.auto_awesome, freeAccess: false);

  const MessageMode({required this.icon, required this.freeAccess});

  final IconData icon;
  final bool freeAccess;

  /// Index-based check matching the spec: modes 0-2 are free.
  bool get isLocked => !freeAccess;
}
```

#### `lib/features/ai_messages/domain/entities/message_tone.dart`

```dart
/// Available tone options for message generation.
enum MessageTone {
  heartfelt,
  playful,
  direct,
  poetic;

  String get displayName => switch (this) {
        MessageTone.heartfelt => 'Heartfelt',
        MessageTone.playful => 'Playful',
        MessageTone.direct => 'Direct',
        MessageTone.poetic => 'Poetic',
      };
}
```

#### `lib/features/ai_messages/domain/entities/message_length.dart`

```dart
/// Desired length for generated messages.
enum MessageLength {
  short,
  medium,
  long;

  String get displayName => switch (this) {
        MessageLength.short => 'Short',
        MessageLength.medium => 'Medium',
        MessageLength.long => 'Long',
      };
}
```

#### `lib/features/ai_messages/domain/entities/generated_message_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

part 'generated_message_entity.freezed.dart';

/// Immutable entity representing a generated AI message.
@freezed
class GeneratedMessageEntity with _$GeneratedMessageEntity {
  const factory GeneratedMessageEntity({
    required String id,
    required String content,
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    required DateTime createdAt,
    @Default(0) int rating,
    @Default(false) bool isFavorite,
    String? modelBadge,
    String? languageCode,
    String? context,
    @Default(false) bool includePartnerName,
  }) = _GeneratedMessageEntity;
}
```

#### `lib/features/ai_messages/domain/entities/message_request_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

part 'message_request_entity.freezed.dart';

/// Immutable entity encapsulating all parameters for a message
/// generation API request.
@freezed
class MessageRequestEntity with _$MessageRequestEntity {
  const factory MessageRequestEntity({
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    @Default(50) int humorLevel,
    @Default('en') String languageCode,
    @Default(true) bool includePartnerName,
    String? contextText,
  }) = _MessageRequestEntity;
}
```

#### `lib/features/ai_messages/domain/repositories/message_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';

/// Contract for AI message generation and history operations.
abstract class MessageRepository {
  /// Generate a new AI message based on the given configuration.
  Future<Either<Failure, GeneratedMessageEntity>> generateMessage(
    MessageRequestEntity request,
  );

  /// Regenerate a message with the same parameters but new output.
  Future<Either<Failure, GeneratedMessageEntity>> regenerateMessage(
    String originalMessageId,
  );

  /// Submit a 1-5 star rating for a generated message.
  Future<Either<Failure, void>> rateMessage({
    required String messageId,
    required int rating,
  });

  /// Toggle the favorite status of a message.
  Future<Either<Failure, void>> toggleFavorite(String messageId);

  /// Get paginated message history with optional filters.
  Future<Either<Failure, List<GeneratedMessageEntity>>> getMessageHistory({
    int page = 1,
    int pageSize = 20,
    bool? favoritesOnly,
    MessageMode? modeFilter,
    String? searchQuery,
  });

  /// Get current month's usage count and limit.
  Future<Either<Failure, ({int used, int limit})>> getUsageCount();
}
```

---

### 5.2 Presentation Layer -- Providers

#### `lib/features/ai_messages/presentation/providers/message_mode_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';

part 'message_mode_provider.g.dart';

/// Tracks the currently selected message mode across the
/// AI Messages flow. Set on the Mode Picker screen, consumed
/// by the Configuration screen.
@riverpod
class SelectedMessageMode extends _$SelectedMessageMode {
  @override
  MessageMode? build() => null;

  void select(MessageMode mode) {
    state = mode;
  }

  void clear() {
    state = null;
  }
}
```

#### `lib/features/ai_messages/presentation/providers/message_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';

part 'message_state.freezed.dart';

/// States for the message generation flow.
@freezed
class MessageGenerationState with _$MessageGenerationState {
  const factory MessageGenerationState.idle() = _Idle;
  const factory MessageGenerationState.generating() = _Generating;
  const factory MessageGenerationState.success({
    required GeneratedMessageEntity message,
  }) = _Success;
  const factory MessageGenerationState.error({
    required String message,
  }) = _Error;
}

/// States for message history list.
@freezed
class MessageHistoryState with _$MessageHistoryState {
  const factory MessageHistoryState.initial() = _HistoryInitial;
  const factory MessageHistoryState.loading() = _HistoryLoading;
  const factory MessageHistoryState.loaded({
    required List<GeneratedMessageEntity> messages,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _HistoryLoaded;
  const factory MessageHistoryState.error({
    required String message,
  }) = _HistoryError;
}
```

#### `lib/features/ai_messages/presentation/providers/message_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';
import 'package:lolo/features/ai_messages/domain/repositories/message_repository.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';

part 'message_provider.g.dart';

/// Manages message generation -- builds the request from the
/// configuration screen inputs and delegates to the repository.
@riverpod
class MessageGenerationNotifier extends _$MessageGenerationNotifier {
  @override
  MessageGenerationState build() => const MessageGenerationState.idle();

  /// Generate a new message with the given configuration.
  Future<void> generate({
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    required int humorLevel,
    required String languageCode,
    required bool includePartnerName,
    String? contextText,
  }) async {
    state = const MessageGenerationState.generating();

    final request = MessageRequestEntity(
      mode: mode,
      tone: tone,
      length: length,
      humorLevel: humorLevel,
      languageCode: languageCode,
      includePartnerName: includePartnerName,
      contextText: contextText,
    );

    final repository = ref.read(messageRepositoryProvider);
    final result = await repository.generateMessage(request);

    state = result.fold(
      (failure) => MessageGenerationState.error(message: failure.message),
      (msg) => MessageGenerationState.success(message: msg),
    );
  }

  /// Regenerate the last generated message.
  Future<void> regenerate(String messageId) async {
    state = const MessageGenerationState.generating();

    final repository = ref.read(messageRepositoryProvider);
    final result = await repository.regenerateMessage(messageId);

    state = result.fold(
      (failure) => MessageGenerationState.error(message: failure.message),
      (msg) => MessageGenerationState.success(message: msg),
    );
  }

  /// Rate a generated message (1-5 stars).
  Future<void> rate(String messageId, int rating) async {
    final repository = ref.read(messageRepositoryProvider);
    await repository.rateMessage(messageId: messageId, rating: rating);

    // Update local state if currently showing this message
    state.whenOrNull(
      success: (message) {
        if (message.id == messageId) {
          state = MessageGenerationState.success(
            message: message.copyWith(rating: rating),
          );
        }
      },
    );
  }

  /// Toggle favorite status on the current message.
  Future<void> toggleFavorite(String messageId) async {
    final repository = ref.read(messageRepositoryProvider);
    await repository.toggleFavorite(messageId);

    state.whenOrNull(
      success: (message) {
        if (message.id == messageId) {
          state = MessageGenerationState.success(
            message: message.copyWith(isFavorite: !message.isFavorite),
          );
        }
      },
    );
  }

  void reset() {
    state = const MessageGenerationState.idle();
  }
}

/// Provides the current month's usage count for the usage counter
/// displayed on the result screen.
@riverpod
class MessageUsage extends _$MessageUsage {
  @override
  Future<({int used, int limit})> build() async {
    final repository = ref.watch(messageRepositoryProvider);
    final result = await repository.getUsageCount();
    return result.fold(
      (_) => (used: 0, limit: 10),
      (usage) => usage,
    );
  }
}
```

#### `lib/features/ai_messages/presentation/providers/message_history_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/repositories/message_repository.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';

part 'message_history_provider.g.dart';

/// Filter state for the message history screen.
@riverpod
class MessageHistoryFilter extends _$MessageHistoryFilter {
  @override
  ({bool? favoritesOnly, MessageMode? mode, String? search}) build() =>
      (favoritesOnly: null, mode: null, search: null);

  void setFavoritesOnly(bool? value) {
    state = (favoritesOnly: value, mode: state.mode, search: state.search);
  }

  void setModeFilter(MessageMode? mode) {
    state = (favoritesOnly: state.favoritesOnly, mode: mode, search: state.search);
  }

  void setSearch(String? query) {
    state = (
      favoritesOnly: state.favoritesOnly,
      mode: state.mode,
      search: query?.isEmpty == true ? null : query,
    );
  }

  void clearAll() {
    state = (favoritesOnly: null, mode: null, search: null);
  }
}

/// Manages paginated message history with filter support.
@riverpod
class MessageHistoryNotifier extends _$MessageHistoryNotifier {
  static const int _pageSize = 20;

  @override
  MessageHistoryState build() {
    // Auto-load first page when the provider is first read
    Future.microtask(loadFirstPage);
    return const MessageHistoryState.initial();
  }

  /// Load (or reload) the first page.
  Future<void> loadFirstPage() async {
    state = const MessageHistoryState.loading();

    final filter = ref.read(messageHistoryFilterProvider);
    final repository = ref.read(messageRepositoryProvider);

    final result = await repository.getMessageHistory(
      page: 1,
      pageSize: _pageSize,
      favoritesOnly: filter.favoritesOnly,
      modeFilter: filter.mode,
      searchQuery: filter.search,
    );

    state = result.fold(
      (failure) => MessageHistoryState.error(message: failure.message),
      (messages) => MessageHistoryState.loaded(
        messages: messages,
        hasMore: messages.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  /// Load the next page (infinite scroll).
  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _HistoryLoaded || !current.hasMore || current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(messageHistoryFilterProvider);
    final repository = ref.read(messageRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.getMessageHistory(
      page: nextPage,
      pageSize: _pageSize,
      favoritesOnly: filter.favoritesOnly,
      modeFilter: filter.mode,
      searchQuery: filter.search,
    );

    state = result.fold(
      (failure) => current.copyWith(isLoadingMore: false),
      (messages) => current.copyWith(
        messages: [...current.messages, ...messages],
        hasMore: messages.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }
}
```

---

### 5.3 Screen 19: Mode Picker (`/ai/messages`)

#### `lib/features/ai_messages/presentation/screens/messages_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_mode_provider.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_mode_card.dart';

/// Screen 19: AI Message Mode Picker.
///
/// Displays a 2-column grid of 10 mode cards. Free tier users
/// see modes 0-2 unlocked; modes 3-9 show a lock overlay.
/// Tapping an unlocked mode navigates to the configuration screen.
/// Tapping a locked mode navigates to the paywall.
class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: LoloAppBar(
        title: 'AI Messages',
        showBackButton: false,
        showLogo: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('message-history'),
            tooltip: 'Message History',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              // Header text
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: LoloSpacing.spaceLg,
                    bottom: LoloSpacing.spaceMd,
                  ),
                  child: Text(
                    'Choose a message mode',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              // 2-column grid of mode cards
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: LoloSpacing.spaceSm,
                  crossAxisSpacing: LoloSpacing.spaceSm,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final mode = MessageMode.values[index];
                    return MessageModeCard(
                      mode: mode,
                      onTap: () => _onModeTapped(context, ref, mode),
                    );
                  },
                  childCount: MessageMode.values.length,
                ),
              ),

              // Bottom spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: LoloSpacing.screenBottomPadding),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onModeTapped(BuildContext context, WidgetRef ref, MessageMode mode) {
    if (mode.isLocked) {
      context.pushNamed('paywall', extra: 'ai_messages');
      return;
    }

    ref.read(selectedMessageModeProvider.notifier).select(mode);
    context.pushNamed('generate-message');
  }
}
```

#### `lib/features/ai_messages/presentation/widgets/message_mode_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';

/// A single mode card in the 2-column Mode Picker grid.
///
/// Shows the mode icon, localized name, and a short description.
/// Locked modes display a semi-transparent overlay with a lock icon.
class MessageModeCard extends StatelessWidget {
  const MessageModeCard({
    required this.mode,
    required this.onTap,
    super.key,
  });

  final MessageMode mode;
  final VoidCallback onTap;

  /// Mode display names. In production these would come from
  /// AppLocalizations; hardcoded here for sprint velocity.
  String get _modeName => switch (mode) {
        MessageMode.romantic => 'Romantic',
        MessageMode.apology => 'Apology',
        MessageMode.appreciation => 'Appreciation',
        MessageMode.flirty => 'Flirty',
        MessageMode.encouragement => 'Encouragement',
        MessageMode.missYou => 'Miss You',
        MessageMode.goodMorning => 'Good Morning',
        MessageMode.goodNight => 'Good Night',
        MessageMode.anniversary => 'Anniversary',
        MessageMode.custom => 'Custom',
      };

  String get _modeDescription => switch (mode) {
        MessageMode.romantic => 'Express your deep love and affection',
        MessageMode.apology => 'Say sorry the right way',
        MessageMode.appreciation => 'Show her you notice and care',
        MessageMode.flirty => 'Playful messages to make her smile',
        MessageMode.encouragement => 'Lift her spirits when she needs it',
        MessageMode.missYou => 'Let her know she is on your mind',
        MessageMode.goodMorning => 'Start her day with warmth',
        MessageMode.goodNight => 'Sweet dreams messages',
        MessageMode.anniversary => 'Celebrate your milestones',
        MessageMode.custom => 'Write about anything you want',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: '$_modeName. $_modeDescription. ${mode.isLocked ? "Premium feature." : ""}',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
            border: Border.all(color: borderColor, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Card content
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  LoloSpacing.cardInnerPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon container
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        mode.icon,
                        color: LoloColors.colorPrimary,
                        size: LoloSpacing.iconSizeMedium,
                      ),
                    ),
                    const SizedBox(height: LoloSpacing.spaceSm),

                    // Mode name
                    Text(
                      _modeName,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: LoloSpacing.space2xs),

                    // Description
                    Text(
                      _modeDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondaryText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Lock overlay for premium modes
              if (mode.isLocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: (isDark
                              ? LoloColors.darkBgPrimary
                              : LoloColors.lightBgPrimary)
                          .withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(
                        LoloSpacing.cardBorderRadius,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: LoloColors.colorAccent.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: LoloColors.colorAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 5.4 Screen 20: Message Configuration (`/ai/messages/configure`)

#### `lib/features/ai_messages/presentation/screens/generate_message_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_slider.dart';
import 'package:lolo/core/widgets/lolo_toggle.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_mode_provider.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_provider.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/length_selector_widget.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/language_override_selector.dart';

/// Screen 20: Message Configuration.
///
/// Allows the user to customize tone, humor level, length,
/// language, partner name inclusion, and optional context
/// before generating an AI message.
class GenerateMessageScreen extends ConsumerStatefulWidget {
  const GenerateMessageScreen({super.key});

  @override
  ConsumerState<GenerateMessageScreen> createState() =>
      _GenerateMessageScreenState();
}

class _GenerateMessageScreenState
    extends ConsumerState<GenerateMessageScreen> {
  // Configuration state
  MessageTone _selectedTone = MessageTone.heartfelt;
  double _humorLevel = 50;
  MessageLength _selectedLength = MessageLength.medium;
  String _selectedLanguage = 'en';
  bool _includePartnerName = true;
  late final TextEditingController _contextController;

  @override
  void initState() {
    super.initState();
    _contextController = TextEditingController();
  }

  @override
  void dispose() {
    _contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMode = ref.watch(selectedMessageModeProvider);
    final generationState = ref.watch(messageGenerationNotifierProvider);

    final isGenerating = generationState is _Generating;

    // Navigate to result on success
    ref.listen<MessageGenerationState>(
      messageGenerationNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          success: (_) => context.pushNamed('message-detail'),
        );
      },
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Configure Message',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: LoloSpacing.screenHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: LoloSpacing.spaceMd),

                    // Selected mode badge
                    if (selectedMode != null)
                      _ModeBadge(mode: selectedMode),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Tone selection
                    Text(
                      'Tone',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: LoloSpacing.spaceXs),
                    LoloChipGroup(
                      items: MessageTone.values
                          .map((t) => ChipItem(label: t.displayName))
                          .toList(),
                      selectedIndices: {_selectedTone.index},
                      onSelectionChanged: (indices) {
                        if (indices.isNotEmpty) {
                          setState(() {
                            _selectedTone = MessageTone.values[indices.first];
                          });
                        }
                      },
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Humor slider
                    LoloSlider(
                      value: _humorLevel,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: 'Humor Level',
                      valueDisplay: _humorLevel <= 20
                          ? 'Serious'
                          : _humorLevel >= 80
                              ? 'Funny'
                              : '${_humorLevel.round()}',
                      onChanged: (v) => setState(() => _humorLevel = v),
                    ),
                    // Min/max labels
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: LoloSpacing.space2xs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Serious',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextTertiary
                                  : LoloColors.lightTextTertiary,
                            ),
                          ),
                          Text(
                            'Funny',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextTertiary
                                  : LoloColors.lightTextTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Length toggle
                    Text(
                      'Message Length',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: LoloSpacing.spaceXs),
                    LengthSelectorWidget(
                      selected: _selectedLength,
                      onChanged: (l) =>
                          setState(() => _selectedLength = l),
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Language override
                    Text(
                      'Language',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: LoloSpacing.spaceXs),
                    LanguageOverrideSelector(
                      selected: _selectedLanguage,
                      onChanged: (lang) =>
                          setState(() => _selectedLanguage = lang),
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Partner name toggle
                    LoloToggle(
                      value: _includePartnerName,
                      onChanged: (v) =>
                          setState(() => _includePartnerName = v),
                      label: 'Include her name',
                      description:
                          'Personalize the message with your partner\'s name',
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Context input
                    LoloTextField(
                      label: 'Context (optional)',
                      controller: _contextController,
                      hint:
                          'e.g., We had an argument about...',
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),

                    const SizedBox(height: LoloSpacing.space2xl),
                  ],
                ),
              ),
            ),

            // Generate button
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: LoloSpacing.screenHorizontalPadding,
                vertical: LoloSpacing.spaceMd,
              ),
              child: _GenerateButton(
                isLoading: isGenerating,
                onPressed: selectedMode != null
                    ? () => _onGenerate(selectedMode)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGenerate(MessageMode mode) {
    ref.read(messageGenerationNotifierProvider.notifier).generate(
          mode: mode,
          tone: _selectedTone,
          length: _selectedLength,
          humorLevel: _humorLevel.round(),
          languageCode: _selectedLanguage,
          includePartnerName: _includePartnerName,
          contextText: _contextController.text.isNotEmpty
              ? _contextController.text
              : null,
        );
  }
}

/// Displays the selected mode as a colored badge at the top.
class _ModeBadge extends StatelessWidget {
  const _ModeBadge({required this.mode});
  final MessageMode mode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: LoloColors.colorPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(mode.icon, color: LoloColors.colorPrimary, size: 18),
          const SizedBox(width: 8),
          Text(
            mode.name[0].toUpperCase() + mode.name.substring(1),
            style: theme.textTheme.titleMedium?.copyWith(
              color: LoloColors.colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium gradient generate button with loading state.
class _GenerateButton extends StatelessWidget {
  const _GenerateButton({
    required this.isLoading,
    this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressed != null && !isLoading
              ? LoloGradients.premium
              : null,
          color: onPressed == null || isLoading
              ? LoloColors.darkBorderDefault
              : null,
          borderRadius: BorderRadius.circular(24),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Generate Message',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
```

#### `lib/features/ai_messages/presentation/widgets/length_selector_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

/// Three-segment toggle for selecting message length: Short / Medium / Long.
///
/// Uses a segmented button pattern with animated background.
class LengthSelectorWidget extends StatelessWidget {
  const LengthSelectorWidget({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final MessageLength selected;
  final ValueChanged<MessageLength> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: MessageLength.values.map((length) {
          final isSelected = length == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(length),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsetsDirectional.all(4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? LoloColors.colorPrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  length.displayName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary),
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
```

#### `lib/features/ai_messages/presentation/widgets/language_override_selector.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Language selector for EN / AR / MS override.
///
/// Defaults to the current app locale. Allows user to generate
/// a message in a different language than their UI language.
class LanguageOverrideSelector extends StatelessWidget {
  const LanguageOverrideSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  static const _languages = [
    ('en', 'EN', 'English'),
    ('ar', 'AR', 'Arabic'),
    ('ms', 'MS', 'Malay'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: _languages.map((lang) {
        final isSelected = lang.$1 == selected;
        final borderColor = isSelected
            ? LoloColors.colorPrimary
            : (isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault);
        final bgColor = isSelected
            ? LoloColors.colorPrimary.withValues(alpha: 0.12)
            : Colors.transparent;

        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Semantics(
            label: '${lang.$3} language',
            selected: isSelected,
            child: GestureDetector(
              onTap: () => onChanged(lang.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Text(
                  lang.$2,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? LoloColors.colorPrimary
                        : (isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
```

---

### 5.5 Screen 21: Generated Message Result (`/ai/messages/result`)

#### `lib/features/ai_messages/presentation/screens/message_detail_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_provider.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_result_card.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/copy_share_bar.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_feedback_widget.dart';
import 'package:share_plus/share_plus.dart';

/// Screen 21: Generated Message Result.
///
/// Displays the AI-generated message with typewriter animation,
/// action row (copy/share/edit/regenerate), star rating,
/// favorite toggle, model badge, and usage counter.
class MessageDetailScreen extends ConsumerStatefulWidget {
  const MessageDetailScreen({super.key});

  @override
  ConsumerState<MessageDetailScreen> createState() =>
      _MessageDetailScreenState();
}

class _MessageDetailScreenState
    extends ConsumerState<MessageDetailScreen> {
  bool _isEditing = false;
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generationState = ref.watch(messageGenerationNotifierProvider);
    final usageAsync = ref.watch(messageUsageProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Your Message',
        showBackButton: true,
      ),
      body: generationState.when(
        idle: () => const Center(child: Text('No message generated yet.')),
        generating: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: LoloColors.colorPrimary),
              SizedBox(height: LoloSpacing.spaceMd),
              Text('Crafting your message...'),
            ],
          ),
        ),
        error: (errorMsg) => Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48,
                  color: LoloColors.colorError),
                const SizedBox(height: LoloSpacing.spaceMd),
                Text(errorMsg, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        success: (message) => _buildSuccessContent(
          context, message, usageAsync, theme, isDark,
        ),
      ),
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    GeneratedMessageEntity message,
    AsyncValue<({int used, int limit})> usageAsync,
    ThemeData theme,
    bool isDark,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LoloSpacing.spaceLg),

          // Hero message card with typewriter animation
          MessageResultCard(
            content: _isEditing ? null : message.content,
            isEditing: _isEditing,
            editController: _editController,
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          // Actions row: Copy, Share, Edit, Regenerate
          CopyShareBar(
            onCopy: () => _copyToClipboard(context, message.content),
            onShare: () => _shareMessage(message.content),
            onEdit: () => _toggleEdit(message.content),
            onRegenerate: () => ref
                .read(messageGenerationNotifierProvider.notifier)
                .regenerate(message.id),
            isEditing: _isEditing,
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // 5-star rating
          MessageFeedbackWidget(
            currentRating: message.rating,
            onRatingChanged: (rating) => ref
                .read(messageGenerationNotifierProvider.notifier)
                .rate(message.id, rating),
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          // Favorite toggle
          _FavoriteRow(
            isFavorite: message.isFavorite,
            onToggle: () => ref
                .read(messageGenerationNotifierProvider.notifier)
                .toggleFavorite(message.id),
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // AI model badge
          if (message.modelBadge != null)
            Text(
              'Generated by ${message.modelBadge}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
            ),

          const SizedBox(height: LoloSpacing.spaceXs),

          // Usage counter
          usageAsync.when(
            data: (usage) => Text(
              '${usage.used} of ${usage.limit} messages used this month',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareMessage(String content) {
    Share.share(content, subject: 'Message from LOLO');
  }

  void _toggleEdit(String content) {
    setState(() {
      if (!_isEditing) {
        _editController.text = content;
      }
      _isEditing = !_isEditing;
    });
  }
}

/// Favorite toggle row with animated heart icon.
class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({
    required this.isFavorite,
    required this.onToggle,
  });

  final bool isFavorite;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
                color: isFavorite
                    ? LoloColors.colorError
                    : LoloColors.darkTextSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isFavorite ? 'Saved to Favorites' : 'Save to Favorites',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
```

#### `lib/features/ai_messages/presentation/widgets/message_result_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Hero card displaying the generated message text.
///
/// On first display, runs a typewriter animation that reveals
/// characters incrementally. When [isEditing] is true, shows
/// a text field instead.
class MessageResultCard extends StatefulWidget {
  const MessageResultCard({
    this.content,
    this.isEditing = false,
    this.editController,
    super.key,
  });

  final String? content;
  final bool isEditing;
  final TextEditingController? editController;

  @override
  State<MessageResultCard> createState() => _MessageResultCardState();
}

class _MessageResultCardState extends State<MessageResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<int> _charCount;
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    final textLength = widget.content?.length ?? 0;

    _animController = AnimationController(
      duration: Duration(milliseconds: textLength * 25),
      vsync: this,
    );

    _charCount = IntTween(begin: 0, end: textLength).animate(
      CurvedAnimation(parent: _animController, curve: Curves.linear),
    );

    _animController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _animationComplete = true);
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark
        ? LoloColors.darkSurfaceElevated1
        : LoloColors.lightSurfaceElevated1;
    final borderColor = isDark
        ? LoloColors.darkBorderAccent
        : LoloColors.lightBorderAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceLg),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: widget.isEditing
          ? TextField(
              controller: widget.editController,
              maxLines: null,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.7,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Edit your message...',
              ),
            )
          : AnimatedBuilder(
              animation: _charCount,
              builder: (context, _) {
                final displayText = _animationComplete
                    ? widget.content ?? ''
                    : (widget.content ?? '')
                        .substring(0, _charCount.value);
                return SelectableText(
                  displayText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                  ),
                );
              },
            ),
    );
  }
}
```

#### `lib/features/ai_messages/presentation/widgets/copy_share_bar.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Horizontal action bar with Copy, Share, Edit, Regenerate buttons.
class CopyShareBar extends StatelessWidget {
  const CopyShareBar({
    required this.onCopy,
    required this.onShare,
    required this.onEdit,
    required this.onRegenerate,
    this.isEditing = false,
    super.key,
  });

  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onEdit;
  final VoidCallback onRegenerate;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionBtn(
          icon: Icons.copy,
          label: 'Copy',
          onTap: onCopy,
          color: iconColor,
        ),
        _ActionBtn(
          icon: Icons.share_outlined,
          label: 'Share',
          onTap: onShare,
          color: iconColor,
        ),
        _ActionBtn(
          icon: isEditing ? Icons.check : Icons.edit_outlined,
          label: isEditing ? 'Done' : 'Edit',
          onTap: onEdit,
          color: isEditing ? LoloColors.colorPrimary : iconColor,
        ),
        _ActionBtn(
          icon: Icons.refresh,
          label: 'Regenerate',
          onTap: onRegenerate,
          color: iconColor,
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => Semantics(
        label: label,
        button: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.spaceXs,
              vertical: LoloSpacing.spaceXs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
```

#### `lib/features/ai_messages/presentation/widgets/message_feedback_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// 5-star rating row for message feedback.
///
/// Displays a "Rate this message" label with 5 tappable stars.
/// Active stars use [LoloColors.colorAccent]; inactive use gray.
class MessageFeedbackWidget extends StatelessWidget {
  const MessageFeedbackWidget({
    required this.currentRating,
    required this.onRatingChanged,
    super.key,
  });

  final int currentRating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate this message',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            final isActive = starNumber <= currentRating;

            return Semantics(
              label: '$starNumber star${starNumber > 1 ? "s" : ""}',
              selected: isActive,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onRatingChanged(starNumber);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 4),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      isActive ? Icons.star : Icons.star_border,
                      key: ValueKey('$index-$isActive'),
                      size: 32,
                      color: isActive
                          ? LoloColors.colorAccent
                          : LoloColors.gray4,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
```

---

### 5.6 Screen 22: Message History (`/ai/messages/history`)

#### `lib/features/ai_messages/presentation/screens/message_history_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/paginated_list_view.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_history_provider.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';
import 'package:share_plus/share_plus.dart';

/// Screen 22: Message History.
///
/// Shows a searchable, filterable, paginated list of past
/// generated messages. Tapping a message expands it inline
/// with copy/share actions.
class MessageHistoryScreen extends ConsumerStatefulWidget {
  const MessageHistoryScreen({super.key});

  @override
  ConsumerState<MessageHistoryScreen> createState() =>
      _MessageHistoryScreenState();
}

class _MessageHistoryScreenState
    extends ConsumerState<MessageHistoryScreen> {
  String? _expandedMessageId;

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(messageHistoryNotifierProvider);
    final filter = ref.watch(messageHistoryFilterProvider);

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Message History',
        showBackButton: true,
        showSearch: true,
        searchHint: 'Search messages...',
        onSearchChanged: (query) {
          ref.read(messageHistoryFilterProvider.notifier).setSearch(query);
          ref.read(messageHistoryNotifierProvider.notifier).loadFirstPage();
        },
      ),
      body: Column(
        children: [
          // Filter chips row
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
              bottom: LoloSpacing.spaceXs,
            ),
            child: _FilterChipsRow(
              currentFilter: filter,
              onFilterChanged: (favOnly, mode) {
                ref
                    .read(messageHistoryFilterProvider.notifier)
                    .setFavoritesOnly(favOnly);
                ref
                    .read(messageHistoryFilterProvider.notifier)
                    .setModeFilter(mode);
                ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadFirstPage();
              },
            ),
          ),

          // Message list
          Expanded(
            child: historyState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (messages, hasMore, page, isLoadingMore) =>
                  PaginatedListView(
                itemCount: messages.length,
                isLoading: isLoadingMore,
                hasMore: hasMore,
                onLoadMore: () => ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadFirstPage(),
                emptyState: LoloEmptyState(
                  illustration: const Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: LoloColors.gray4,
                  ),
                  title: 'No messages yet',
                  description:
                      'Generate your first message to see it here!',
                  ctaLabel: 'Generate Now',
                  onCtaTap: () => Navigator.of(context).pop(),
                ),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isExpanded =
                      _expandedMessageId == message.id;

                  return _MessageHistoryTile(
                    message: message,
                    isExpanded: isExpanded,
                    onTap: () => setState(() {
                      _expandedMessageId =
                          isExpanded ? null : message.id;
                    }),
                    onCopy: () => _copyMessage(context, message.content),
                    onShare: () => Share.share(message.content),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyMessage(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Filter chips: All, Favorites, then one per MessageMode.
class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final ({bool? favoritesOnly, MessageMode? mode, String? search}) currentFilter;
  final void Function(bool? favoritesOnly, MessageMode? mode) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    // Build chip items: All + Favorites + each mode
    final items = <ChipItem>[
      const ChipItem(label: 'All'),
      const ChipItem(label: 'Favorites', icon: Icons.favorite),
      ...MessageMode.values.map(
        (m) => ChipItem(
          label: m.name[0].toUpperCase() + m.name.substring(1),
          icon: m.icon,
        ),
      ),
    ];

    // Determine selected index
    int selectedIndex;
    if (currentFilter.favoritesOnly == true) {
      selectedIndex = 1;
    } else if (currentFilter.mode != null) {
      selectedIndex = 2 + currentFilter.mode!.index;
    } else {
      selectedIndex = 0;
    }

    return LoloChipGroup(
      items: items,
      selectedIndices: {selectedIndex},
      onSelectionChanged: (indices) {
        final idx = indices.first;
        if (idx == 0) {
          onFilterChanged(null, null);
        } else if (idx == 1) {
          onFilterChanged(true, null);
        } else {
          onFilterChanged(null, MessageMode.values[idx - 2]);
        }
      },
      scrollable: true,
    );
  }
}

/// A single message history tile with expandable content.
class _MessageHistoryTile extends StatelessWidget {
  const _MessageHistoryTile({
    required this.message,
    required this.isExpanded,
    required this.onTap,
    required this.onCopy,
    required this.onShare,
  });

  final GeneratedMessageEntity message;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
          vertical: LoloSpacing.spaceSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: mode badge + date + stars
            Row(
              children: [
                // Mode badge
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(message.mode.icon, size: 12,
                        color: LoloColors.colorPrimary),
                      const SizedBox(width: 4),
                      Text(
                        message.mode.name[0].toUpperCase() +
                            message.mode.name.substring(1),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: LoloColors.colorPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Rating stars (compact)
                if (message.rating > 0)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      message.rating,
                      (_) => const Icon(
                        Icons.star,
                        size: 12,
                        color: LoloColors.colorAccent,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                // Date
                Text(
                  _formatDate(message.createdAt),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: secondaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Preview (2 lines) or full content
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                message.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    message.content,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  // Expanded action row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: onCopy,
                        tooltip: 'Copy',
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined, size: 18),
                        onPressed: onShare,
                        tooltip: 'Share',
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      if (message.isFavorite)
                        const Icon(
                          Icons.favorite,
                          size: 16,
                          color: LoloColors.colorError,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

---

## Module 6: Gift Recommendation Engine

### 6.1 Domain Layer

#### `lib/features/gift_engine/domain/entities/gift_category.dart`

```dart
import 'package:flutter/material.dart';

/// Gift categories for browsing and filtering.
enum GiftCategory {
  all(icon: Icons.apps, label: 'All'),
  flowers(icon: Icons.local_florist, label: 'Flowers'),
  jewelry(icon: Icons.diamond, label: 'Jewelry'),
  experience(icon: Icons.confirmation_number, label: 'Experience'),
  food(icon: Icons.restaurant, label: 'Food'),
  tech(icon: Icons.devices, label: 'Tech'),
  handmade(icon: Icons.handyman, label: 'Handmade');

  const GiftCategory({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
```

#### `lib/features/gift_engine/domain/entities/gift_recommendation_entity.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';

part 'gift_recommendation_entity.freezed.dart';

/// Immutable entity for a gift recommendation.
///
/// Contains the gift details, AI reasoning, trait matches,
/// save status, and user feedback.
@freezed
class GiftRecommendationEntity with _$GiftRecommendationEntity {
  const factory GiftRecommendationEntity({
    required String id,
    required String name,
    required String priceRange,
    required GiftCategory category,
    String? imageUrl,
    String? whySheLoveIt,
    @Default([]) List<String> matchedTraits,
    String? buyUrl,
    @Default(false) bool isSaved,
    @Default(false) bool isLowBudget,
    DateTime? createdAt,
    /// null = no feedback, true = liked, false = disliked
    bool? feedback,
    String? learningNote,
  }) = _GiftRecommendationEntity;
}
```

#### `lib/features/gift_engine/domain/repositories/gift_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';

/// Contract for gift recommendation operations.
abstract class GiftRepository {
  /// Browse gifts with category filter, search, and budget filter.
  Future<Either<Failure, List<GiftRecommendationEntity>>> browseGifts({
    int page = 1,
    int pageSize = 20,
    GiftCategory? category,
    String? searchQuery,
    bool? lowBudgetOnly,
  });

  /// Get a single gift by ID.
  Future<Either<Failure, GiftRecommendationEntity>> getGiftById(String id);

  /// Get AI-powered gift recommendations based on partner profile.
  Future<Either<Failure, List<GiftRecommendationEntity>>>
      getAiRecommendations();

  /// Toggle the saved/favorite status of a gift.
  Future<Either<Failure, void>> toggleSave(String giftId);

  /// Submit feedback for a gift recommendation.
  Future<Either<Failure, void>> submitFeedback({
    required String giftId,
    required bool liked,
  });

  /// Get related gifts for a given gift.
  Future<Either<Failure, List<GiftRecommendationEntity>>> getRelatedGifts(
    String giftId,
  );

  /// Get gift history with optional feedback filter.
  Future<Either<Failure, List<GiftRecommendationEntity>>> getGiftHistory({
    int page = 1,
    int pageSize = 20,
    bool? likedOnly,
    bool? dislikedOnly,
  });
}
```

---

### 6.2 Presentation Layer -- Providers

#### `lib/features/gift_engine/presentation/providers/gift_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';

part 'gift_state.freezed.dart';

/// States for the gift browse screen.
@freezed
class GiftBrowseState with _$GiftBrowseState {
  const factory GiftBrowseState.initial() = _BrowseInitial;
  const factory GiftBrowseState.loading() = _BrowseLoading;
  const factory GiftBrowseState.loaded({
    required List<GiftRecommendationEntity> gifts,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _BrowseLoaded;
  const factory GiftBrowseState.error({required String message}) =
      _BrowseError;
}

/// States for the gift detail screen.
@freezed
class GiftDetailState with _$GiftDetailState {
  const factory GiftDetailState.loading() = _DetailLoading;
  const factory GiftDetailState.loaded({
    required GiftRecommendationEntity gift,
    required List<GiftRecommendationEntity> relatedGifts,
  }) = _DetailLoaded;
  const factory GiftDetailState.error({required String message}) =
      _DetailError;
}

/// States for the gift history screen.
@freezed
class GiftHistoryState with _$GiftHistoryState {
  const factory GiftHistoryState.initial() = _HistInitial;
  const factory GiftHistoryState.loading() = _HistLoading;
  const factory GiftHistoryState.loaded({
    required List<GiftRecommendationEntity> gifts,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _HistLoaded;
  const factory GiftHistoryState.error({required String message}) =
      _HistError;
}
```

#### `lib/features/gift_engine/presentation/providers/gift_filter_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';

part 'gift_filter_provider.g.dart';

/// Filter state for the Gift Browse screen.
@riverpod
class GiftBrowseFilter extends _$GiftBrowseFilter {
  @override
  ({GiftCategory? category, String? search, bool lowBudget}) build() =>
      (category: null, search: null, lowBudget: false);

  void setCategory(GiftCategory? category) {
    // 'All' category maps to null (no filter)
    final effective = category == GiftCategory.all ? null : category;
    state = (
      category: effective,
      search: state.search,
      lowBudget: state.lowBudget,
    );
  }

  void setSearch(String? query) {
    state = (
      category: state.category,
      search: query?.isEmpty == true ? null : query,
      lowBudget: state.lowBudget,
    );
  }

  void toggleLowBudget() {
    state = (
      category: state.category,
      search: state.search,
      lowBudget: !state.lowBudget,
    );
  }
}

/// Filter for the Gift History screen.
@riverpod
class GiftHistoryFilter extends _$GiftHistoryFilter {
  @override
  ({bool? likedOnly, bool? dislikedOnly}) build() =>
      (likedOnly: null, dislikedOnly: null);

  void setAll() {
    state = (likedOnly: null, dislikedOnly: null);
  }

  void setLikedOnly() {
    state = (likedOnly: true, dislikedOnly: null);
  }

  void setDislikedOnly() {
    state = (likedOnly: null, dislikedOnly: true);
  }
}
```

#### `lib/features/gift_engine/presentation/providers/gift_provider.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/domain/repositories/gift_repository.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';

part 'gift_provider.g.dart';

/// Manages the gift browse screen state with pagination and filters.
@riverpod
class GiftBrowseNotifier extends _$GiftBrowseNotifier {
  static const int _pageSize = 20;

  @override
  GiftBrowseState build() {
    Future.microtask(loadFirstPage);
    return const GiftBrowseState.initial();
  }

  Future<void> loadFirstPage() async {
    state = const GiftBrowseState.loading();

    final filter = ref.read(giftBrowseFilterProvider);
    final repository = ref.read(giftRepositoryProvider);

    final result = await repository.browseGifts(
      page: 1,
      pageSize: _pageSize,
      category: filter.category,
      searchQuery: filter.search,
      lowBudgetOnly: filter.lowBudget ? true : null,
    );

    state = result.fold(
      (failure) => GiftBrowseState.error(message: failure.message),
      (gifts) => GiftBrowseState.loaded(
        gifts: gifts,
        hasMore: gifts.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _BrowseLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(giftBrowseFilterProvider);
    final repository = ref.read(giftRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.browseGifts(
      page: nextPage,
      pageSize: _pageSize,
      category: filter.category,
      searchQuery: filter.search,
      lowBudgetOnly: filter.lowBudget ? true : null,
    );

    state = result.fold(
      (_) => current.copyWith(isLoadingMore: false),
      (gifts) => current.copyWith(
        gifts: [...current.gifts, ...gifts],
        hasMore: gifts.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }

  /// Toggle the saved status locally and remotely.
  Future<void> toggleSave(String giftId) async {
    final current = state;
    if (current is! _BrowseLoaded) return;

    // Optimistic update
    final updatedGifts = current.gifts.map((g) {
      if (g.id == giftId) return g.copyWith(isSaved: !g.isSaved);
      return g;
    }).toList();
    state = current.copyWith(gifts: updatedGifts);

    final repository = ref.read(giftRepositoryProvider);
    await repository.toggleSave(giftId);
  }
}

/// Manages the gift detail screen state.
@riverpod
class GiftDetailNotifier extends _$GiftDetailNotifier {
  @override
  GiftDetailState build(String giftId) {
    Future.microtask(() => _load(giftId));
    return const GiftDetailState.loading();
  }

  Future<void> _load(String giftId) async {
    final repository = ref.read(giftRepositoryProvider);

    final giftResult = await repository.getGiftById(giftId);
    final relatedResult = await repository.getRelatedGifts(giftId);

    giftResult.fold(
      (failure) =>
          state = GiftDetailState.error(message: failure.message),
      (gift) => state = GiftDetailState.loaded(
        gift: gift,
        relatedGifts: relatedResult.fold((_) => [], (r) => r),
      ),
    );
  }

  Future<void> toggleSave() async {
    final current = state;
    if (current is! _DetailLoaded) return;

    state = current.copyWith(
      gift: current.gift.copyWith(isSaved: !current.gift.isSaved),
    );

    final repository = ref.read(giftRepositoryProvider);
    await repository.toggleSave(current.gift.id);
  }

  Future<void> submitFeedback(bool liked) async {
    final current = state;
    if (current is! _DetailLoaded) return;

    state = current.copyWith(
      gift: current.gift.copyWith(feedback: liked),
    );

    final repository = ref.read(giftRepositoryProvider);
    await repository.submitFeedback(
      giftId: current.gift.id,
      liked: liked,
    );
  }
}

/// Manages gift history with pagination.
@riverpod
class GiftHistoryNotifier extends _$GiftHistoryNotifier {
  static const int _pageSize = 20;

  @override
  GiftHistoryState build() {
    Future.microtask(loadFirstPage);
    return const GiftHistoryState.initial();
  }

  Future<void> loadFirstPage() async {
    state = const GiftHistoryState.loading();

    final filter = ref.read(giftHistoryFilterProvider);
    final repository = ref.read(giftRepositoryProvider);

    final result = await repository.getGiftHistory(
      page: 1,
      pageSize: _pageSize,
      likedOnly: filter.likedOnly,
      dislikedOnly: filter.dislikedOnly,
    );

    state = result.fold(
      (failure) => GiftHistoryState.error(message: failure.message),
      (gifts) => GiftHistoryState.loaded(
        gifts: gifts,
        hasMore: gifts.length >= _pageSize,
        currentPage: 1,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! _HistLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    state = current.copyWith(isLoadingMore: true);

    final filter = ref.read(giftHistoryFilterProvider);
    final repository = ref.read(giftRepositoryProvider);
    final nextPage = current.currentPage + 1;

    final result = await repository.getGiftHistory(
      page: nextPage,
      pageSize: _pageSize,
      likedOnly: filter.likedOnly,
      dislikedOnly: filter.dislikedOnly,
    );

    state = result.fold(
      (_) => current.copyWith(isLoadingMore: false),
      (gifts) => current.copyWith(
        gifts: [...current.gifts, ...gifts],
        hasMore: gifts.length >= _pageSize,
        currentPage: nextPage,
        isLoadingMore: false,
      ),
    );
  }
}
```

---

### 6.3 Screen 23: Gift Browse (`/gifts`)

#### `lib/features/gift_engine/presentation/screens/gifts_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/gift_card.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';

/// Screen 23: Gift Browse.
///
/// Displays a searchable, filterable, paginated 2-column grid
/// of gift recommendations. Includes category chips, a low-budget
/// toggle, and a FAB for AI recommendations.
class GiftsScreen extends ConsumerWidget {
  const GiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browseState = ref.watch(giftBrowseNotifierProvider);
    final filter = ref.watch(giftBrowseFilterProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Gifts',
        showBackButton: false,
        showLogo: true,
        showSearch: true,
        searchHint: 'Search gifts...',
        onSearchChanged: (query) {
          ref.read(giftBrowseFilterProvider.notifier).setSearch(query);
          ref.read(giftBrowseNotifierProvider.notifier).loadFirstPage();
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('gift-history'),
            tooltip: 'Gift History',
          ),
        ],
      ),
      floatingActionButton: _AiRecommendFab(
        onPressed: () =>
            context.pushNamed('gift-recommend'),
      ),
      body: Column(
        children: [
          // Category chips
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
            ),
            child: LoloChipGroup(
              items: GiftCategory.values
                  .map((c) => ChipItem(label: c.label, icon: c.icon))
                  .toList(),
              selectedIndices: {
                filter.category?.index ?? GiftCategory.all.index,
              },
              onSelectionChanged: (indices) {
                final idx = indices.first;
                ref
                    .read(giftBrowseFilterProvider.notifier)
                    .setCategory(GiftCategory.values[idx]);
                ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage();
              },
              scrollable: true,
            ),
          ),

          // Low Budget toggle
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding,
              vertical: LoloSpacing.spaceXs,
            ),
            child: _LowBudgetToggle(
              isOn: filter.lowBudget,
              onToggle: () {
                ref
                    .read(giftBrowseFilterProvider.notifier)
                    .toggleLowBudget();
                ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage();
              },
            ),
          ),

          // Gift grid
          Expanded(
            child: browseState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (gifts, hasMore, page, isLoadingMore) =>
                  _GiftGrid(
                gifts: gifts,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
                onLoadMore: () => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage(),
                onGiftTap: (id) =>
                    context.pushNamed('gift-detail', pathParameters: {'id': id}),
                onSaveTap: (id) => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .toggleSave(id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Low-budget high-impact toggle pill.
class _LowBudgetToggle extends StatelessWidget {
  const _LowBudgetToggle({
    required this.isOn,
    required this.onToggle,
  });

  final bool isOn;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isOn
              ? LoloColors.colorAccent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isOn
                ? LoloColors.colorAccent
                : (theme.brightness == Brightness.dark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_offer,
              size: 16,
              color: isOn
                  ? LoloColors.colorAccent
                  : (theme.brightness == Brightness.dark
                      ? LoloColors.darkTextSecondary
                      : LoloColors.lightTextSecondary),
            ),
            const SizedBox(width: 6),
            Text(
              'Low Budget High Impact',
              style: theme.textTheme.labelMedium?.copyWith(
                color: isOn
                    ? LoloColors.colorAccent
                    : (theme.brightness == Brightness.dark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary),
                fontWeight: isOn ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2-column grid of GiftCard widgets with infinite scroll.
class _GiftGrid extends StatefulWidget {
  const _GiftGrid({
    required this.gifts,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onGiftTap,
    required this.onSaveTap,
  });

  final List gifts;
  final bool hasMore;
  final bool isLoadingMore;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onGiftTap;
  final ValueChanged<String> onSaveTap;

  @override
  State<_GiftGrid> createState() => _GiftGridState();
}

class _GiftGridState extends State<_GiftGrid> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_isLoadingMore || !widget.hasMore) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      _isLoadingMore = true;
      await widget.onLoadMore();
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gifts.isEmpty) {
      return LoloEmptyState(
        illustration: const Icon(
          Icons.card_giftcard_outlined,
          size: 64,
          color: LoloColors.gray4,
        ),
        title: 'No gifts found',
        description: 'Try adjusting your filters or search.',
      );
    }

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: LoloColors.colorPrimary,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsetsDirectional.all(
          LoloSpacing.screenHorizontalPadding,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: LoloSpacing.spaceSm,
          crossAxisSpacing: LoloSpacing.spaceSm,
          childAspectRatio: 0.75,
        ),
        itemCount: widget.gifts.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.gifts.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsetsDirectional.all(16),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: LoloColors.colorPrimary,
                ),
              ),
            );
          }

          final gift = widget.gifts[index];
          return GiftCard(
            name: gift.name,
            priceRange: gift.priceRange,
            imageUrl: gift.imageUrl,
            reasoning: gift.whySheLoveIt,
            isSaved: gift.isSaved,
            onSave: () => widget.onSaveTap(gift.id),
            onTap: () => widget.onGiftTap(gift.id),
          );
        },
      ),
    );
  }
}

/// FAB for triggering AI gift recommendations.
class _AiRecommendFab extends StatelessWidget {
  const _AiRecommendFab({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LoloGradients.premium,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: LoloColors.colorPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text(
          'Get AI Recommendations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
```

---

### 6.4 Screen 24: Gift Detail (`/gifts/:id`)

#### `lib/features/gift_engine/presentation/screens/gift_detail_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/gift_card.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';

/// Screen 24: Gift Detail.
///
/// Displays full gift information including a hero image with
/// parallax effect, AI reasoning card, trait match tags,
/// action row, and related gifts.
class GiftDetailScreen extends ConsumerWidget {
  const GiftDetailScreen({
    required this.giftId,
    super.key,
  });

  final String giftId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(giftDetailNotifierProvider(giftId));

    return Scaffold(
      body: detailState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: LoloColors.colorPrimary),
        ),
        error: (msg) => Center(child: Text(msg)),
        loaded: (gift, relatedGifts) =>
            _GiftDetailBody(
          gift: gift,
          relatedGifts: relatedGifts,
          onToggleSave: () => ref
              .read(giftDetailNotifierProvider(giftId).notifier)
              .toggleSave(),
          onFeedback: (liked) => ref
              .read(giftDetailNotifierProvider(giftId).notifier)
              .submitFeedback(liked),
          onRelatedTap: (id) =>
              context.pushNamed('gift-detail', pathParameters: {'id': id}),
        ),
      ),
    );
  }
}

/// Main scrollable body of the gift detail screen.
class _GiftDetailBody extends StatelessWidget {
  const _GiftDetailBody({
    required this.gift,
    required this.relatedGifts,
    required this.onToggleSave,
    required this.onFeedback,
    required this.onRelatedTap,
  });

  final GiftRecommendationEntity gift;
  final List<GiftRecommendationEntity> relatedGifts;
  final VoidCallback onToggleSave;
  final ValueChanged<bool> onFeedback;
  final ValueChanged<String> onRelatedTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // Hero image with parallax (240dp)
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsetsDirectional.all(4),
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroImage(imageUrl: gift.imageUrl),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: LoloSpacing.spaceLg),

                // Name + price + category
                Text(gift.name, style: theme.textTheme.headlineMedium),
                const SizedBox(height: LoloSpacing.spaceXs),
                Row(
                  children: [
                    Text(
                      gift.priceRange,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: LoloColors.colorAccent,
                      ),
                    ),
                    const SizedBox(width: LoloSpacing.spaceSm),
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        gift.category.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: LoloColors.colorPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: LoloSpacing.spaceXl),

                // "Why She'll Love It" card
                if (gift.whySheLoveIt != null)
                  _ReasoningCard(
                    title: "Why She'll Love It",
                    content: gift.whySheLoveIt!,
                    icon: Icons.auto_awesome,
                  ),

                const SizedBox(height: LoloSpacing.spaceMd),

                // "Based on Her Profile" trait tags
                if (gift.matchedTraits.isNotEmpty) ...[
                  Text(
                    'Based on Her Profile',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: gift.matchedTraits.map((trait) {
                      return Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: LoloColors.colorSuccess.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: LoloColors.colorSuccess,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trait,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: LoloColors.colorSuccess,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXl),
                ],

                // Action row: Buy Now, Save, Not Right
                _ActionRow(
                  gift: gift,
                  onToggleSave: onToggleSave,
                  onFeedback: onFeedback,
                ),

                const SizedBox(height: LoloSpacing.spaceXl),

                // Related gifts
                if (relatedGifts.isNotEmpty) ...[
                  Text(
                    'Related Gifts',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: LoloSpacing.spaceSm),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedGifts.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: LoloSpacing.spaceSm),
                      itemBuilder: (context, index) {
                        final related = relatedGifts[index];
                        return SizedBox(
                          width: 160,
                          child: GiftCard(
                            name: related.name,
                            priceRange: related.priceRange,
                            imageUrl: related.imageUrl,
                            isSaved: related.isSaved,
                            onTap: () => onRelatedTap(related.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                const SizedBox(height: LoloSpacing.space2xl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Hero image with placeholder fallback.
class _HeroImage extends StatelessWidget {
  const _HeroImage({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 240,
        errorBuilder: (_, __, ___) => _placeholder(isDark),
      );
    }
    return _placeholder(isDark);
  }

  Widget _placeholder(bool isDark) => Container(
        width: double.infinity,
        height: 240,
        color: isDark
            ? LoloColors.darkBgTertiary
            : LoloColors.lightBgTertiary,
        child: Center(
          child: Icon(
            Icons.card_giftcard_outlined,
            size: 64,
            color: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
          ),
        ),
      );
}

/// AI reasoning card.
class _ReasoningCard extends StatelessWidget {
  const _ReasoningCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.cardInnerPadding),
      decoration: BoxDecoration(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        border: Border.all(
          color: isDark
              ? LoloColors.darkBorderDefault
              : LoloColors.lightBorderDefault,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: LoloColors.colorPrimary),
              const SizedBox(width: 8),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: isDark
                  ? LoloColors.darkTextSecondary
                  : LoloColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Action row: Buy Now (external), Save (heart), Not Right (thumbs down).
class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.gift,
    required this.onToggleSave,
    required this.onFeedback,
  });

  final GiftRecommendationEntity gift;
  final VoidCallback onToggleSave;
  final ValueChanged<bool> onFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        // Buy Now
        if (gift.buyUrl != null)
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(gift.buyUrl!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.shopping_cart_outlined, size: 18),
              label: const Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: LoloColors.colorPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(0, 44),
              ),
            ),
          ),
        if (gift.buyUrl != null) const SizedBox(width: 8),

        // Save
        _CircleAction(
          icon: gift.isSaved ? Icons.favorite : Icons.favorite_border,
          color: gift.isSaved ? LoloColors.colorError : null,
          tooltip: gift.isSaved ? 'Unsave' : 'Save',
          onTap: onToggleSave,
        ),
        const SizedBox(width: 8),

        // Not Right (thumbs down)
        _CircleAction(
          icon: gift.feedback == false
              ? Icons.thumb_down
              : Icons.thumb_down_outlined,
          color: gift.feedback == false ? LoloColors.colorWarning : null,
          tooltip: 'Not right for her',
          onTap: () => onFeedback(false),
        ),
      ],
    );
  }
}

/// Circular action button for save/feedback actions.
class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    this.color,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final Color? color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final defaultColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: tooltip,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
          ),
          child: Icon(icon, size: 20, color: color ?? defaultColor),
        ),
      ),
    );
  }
}
```

---

### 6.5 Screen 25: Gift History (`/gifts/history`)

#### `lib/features/gift_engine/presentation/screens/gift_history_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/paginated_list_view.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';

/// Screen 25: Gift History.
///
/// Displays a list of past gift recommendations with feedback
/// indicators and filter options.
class GiftHistoryScreen extends ConsumerWidget {
  const GiftHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(giftHistoryNotifierProvider);
    final filter = ref.watch(giftHistoryFilterProvider);

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Gift History',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Filter chips: All / Liked / Didn't Like
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
              bottom: LoloSpacing.spaceXs,
            ),
            child: LoloChipGroup(
              items: const [
                ChipItem(label: 'All'),
                ChipItem(label: 'Liked', icon: Icons.thumb_up),
                ChipItem(label: "Didn't Like", icon: Icons.thumb_down),
              ],
              selectedIndices: {
                if (filter.likedOnly == true)
                  1
                else if (filter.dislikedOnly == true)
                  2
                else
                  0,
              },
              onSelectionChanged: (indices) {
                final idx = indices.first;
                final notifier =
                    ref.read(giftHistoryFilterProvider.notifier);
                if (idx == 0) {
                  notifier.setAll();
                } else if (idx == 1) {
                  notifier.setLikedOnly();
                } else {
                  notifier.setDislikedOnly();
                }
                ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadFirstPage();
              },
              scrollable: true,
            ),
          ),

          // History list
          Expanded(
            child: historyState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (gifts, hasMore, page, isLoadingMore) =>
                  PaginatedListView(
                itemCount: gifts.length,
                isLoading: isLoadingMore,
                hasMore: hasMore,
                onLoadMore: () => ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadFirstPage(),
                emptyState: LoloEmptyState(
                  illustration: const Icon(
                    Icons.card_giftcard_outlined,
                    size: 64,
                    color: LoloColors.gray4,
                  ),
                  title: 'No gift history yet',
                  description:
                      'Browse gifts and get recommendations to build your history.',
                ),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  return _GiftHistoryTile(
                    gift: gift,
                    onTap: () => context.pushNamed(
                      'gift-detail',
                      pathParameters: {'id': gift.id},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A single gift history tile with feedback indicator.
class _GiftHistoryTile extends StatelessWidget {
  const _GiftHistoryTile({
    required this.gift,
    required this.onTap,
  });

  final GiftRecommendationEntity gift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
          vertical: LoloSpacing.spaceSm,
        ),
        child: Row(
          children: [
            // Gift image thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 56,
                height: 56,
                child: gift.imageUrl != null && gift.imageUrl!.isNotEmpty
                    ? Image.network(
                        gift.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _thumbnail(isDark),
                      )
                    : _thumbnail(isDark),
              ),
            ),
            const SizedBox(width: LoloSpacing.spaceSm),

            // Name + date + learning note
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gift.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (gift.createdAt != null)
                    Text(
                      _formatDate(gift.createdAt!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondaryText,
                      ),
                    ),
                  if (gift.learningNote != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 12,
                          color: LoloColors.colorInfo,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            gift.learningNote!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: LoloColors.colorInfo,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Feedback indicator
            _FeedbackBadge(feedback: gift.feedback),
          ],
        ),
      ),
    );
  }

  Widget _thumbnail(bool isDark) => Container(
        color: isDark
            ? LoloColors.darkBorderDefault
            : LoloColors.lightBorderMuted,
        child: Center(
          child: Icon(
            Icons.card_giftcard_outlined,
            size: 24,
            color: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
          ),
        ),
      );

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Small badge showing feedback status: liked, disliked, or none.
class _FeedbackBadge extends StatelessWidget {
  const _FeedbackBadge({this.feedback});
  final bool? feedback;

  @override
  Widget build(BuildContext context) {
    if (feedback == null) {
      return const Icon(
        Icons.remove_circle_outline,
        size: 20,
        color: LoloColors.gray4,
      );
    }

    return Icon(
      feedback! ? Icons.thumb_up : Icons.thumb_down,
      size: 20,
      color: feedback!
          ? LoloColors.colorSuccess
          : LoloColors.colorWarning,
    );
  }
}
```

---

## Route Registration Updates

### Updated Route Names

#### `lib/core/router/route_names.dart` (additions)

```dart
/// Route names added for Sprint 3: AI Messages + Gift Engine.
///
/// These extend the existing RouteNames class from S1-01.
/// Add these constants inside the existing RouteNames class.

// --- AI Messages (Sprint 3 additions) ---
static const String messageConfigure = 'message-configure';
// Note: generateMessage, messageHistory, messageDetail already exist

// --- Gift Engine (Sprint 3 additions) ---
static const String giftHistory = 'gift-history';
// Note: gifts, giftDetail, giftRecommend already exist
```

### Updated Route Configuration

#### `lib/core/router/app_router.dart` (Sprint 3 updates)

```dart
/// Replace the placeholder builders in the existing router with
/// the actual screen widgets. Add new routes where needed.

// === Tab 2: Messages (updated) ===
GoRoute(
  path: '/messages',
  name: RouteNames.messages,
  builder: (_, __) => const MessagesScreen(),
  routes: [
    GoRoute(
      path: 'generate',
      name: RouteNames.generateMessage,
      builder: (_, __) => const GenerateMessageScreen(),
    ),
    GoRoute(
      path: 'history',
      name: RouteNames.messageHistory,
      builder: (_, __) => const MessageHistoryScreen(),
    ),
    GoRoute(
      path: 'detail/:id',
      name: RouteNames.messageDetail,
      builder: (_, state) => const MessageDetailScreen(),
    ),
    GoRoute(
      path: 'configure',
      name: RouteNames.messageConfigure,
      builder: (_, __) => const GenerateMessageScreen(),
    ),
  ],
),

// === Tab 3: Gifts (updated) ===
GoRoute(
  path: '/gifts',
  name: RouteNames.gifts,
  builder: (_, __) => const GiftsScreen(),
  routes: [
    GoRoute(
      path: 'recommend',
      name: RouteNames.giftRecommend,
      builder: (_, __) => const Placeholder(), // AI recommendation flow -- Sprint 4
    ),
    GoRoute(
      path: 'detail/:id',
      name: RouteNames.giftDetail,
      builder: (_, state) {
        final id = state.pathParameters['id']!;
        return GiftDetailScreen(giftId: id);
      },
    ),
    GoRoute(
      path: 'history',
      name: RouteNames.giftHistory,
      builder: (_, __) => const GiftHistoryScreen(),
    ),
    GoRoute(
      path: 'packages',
      name: RouteNames.giftPackages,
      builder: (_, __) => const Placeholder(), // Curated packages -- Sprint 4
    ),
    GoRoute(
      path: 'budget',
      name: RouteNames.giftBudget,
      builder: (_, __) => const Placeholder(), // Budget filter -- Sprint 4
    ),
  ],
),
```

### Required Imports for Router

```dart
// Add these imports to app_router.dart for Sprint 3 screens:
import 'package:lolo/features/ai_messages/presentation/screens/messages_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/generate_message_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/message_detail_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/message_history_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gifts_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gift_detail_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gift_history_screen.dart';
```

---

## File Index

| # | File | Module |
|---|------|--------|
| 1 | `lib/features/ai_messages/domain/entities/message_mode.dart` | AI Messages |
| 2 | `lib/features/ai_messages/domain/entities/message_tone.dart` | AI Messages |
| 3 | `lib/features/ai_messages/domain/entities/message_length.dart` | AI Messages |
| 4 | `lib/features/ai_messages/domain/entities/generated_message_entity.dart` | AI Messages |
| 5 | `lib/features/ai_messages/domain/entities/message_request_entity.dart` | AI Messages |
| 6 | `lib/features/ai_messages/domain/repositories/message_repository.dart` | AI Messages |
| 7 | `lib/features/ai_messages/presentation/providers/message_mode_provider.dart` | AI Messages |
| 8 | `lib/features/ai_messages/presentation/providers/message_state.dart` | AI Messages |
| 9 | `lib/features/ai_messages/presentation/providers/message_provider.dart` | AI Messages |
| 10 | `lib/features/ai_messages/presentation/providers/message_history_provider.dart` | AI Messages |
| 11 | `lib/features/ai_messages/presentation/screens/messages_screen.dart` | Screen 19 |
| 12 | `lib/features/ai_messages/presentation/widgets/message_mode_card.dart` | Screen 19 |
| 13 | `lib/features/ai_messages/presentation/screens/generate_message_screen.dart` | Screen 20 |
| 14 | `lib/features/ai_messages/presentation/widgets/length_selector_widget.dart` | Screen 20 |
| 15 | `lib/features/ai_messages/presentation/widgets/language_override_selector.dart` | Screen 20 |
| 16 | `lib/features/ai_messages/presentation/screens/message_detail_screen.dart` | Screen 21 |
| 17 | `lib/features/ai_messages/presentation/widgets/message_result_card.dart` | Screen 21 |
| 18 | `lib/features/ai_messages/presentation/widgets/copy_share_bar.dart` | Screen 21 |
| 19 | `lib/features/ai_messages/presentation/widgets/message_feedback_widget.dart` | Screen 21 |
| 20 | `lib/features/ai_messages/presentation/screens/message_history_screen.dart` | Screen 22 |
| 21 | `lib/features/gift_engine/domain/entities/gift_category.dart` | Gift Engine |
| 22 | `lib/features/gift_engine/domain/entities/gift_recommendation_entity.dart` | Gift Engine |
| 23 | `lib/features/gift_engine/domain/repositories/gift_repository.dart` | Gift Engine |
| 24 | `lib/features/gift_engine/presentation/providers/gift_state.dart` | Gift Engine |
| 25 | `lib/features/gift_engine/presentation/providers/gift_filter_provider.dart` | Gift Engine |
| 26 | `lib/features/gift_engine/presentation/providers/gift_provider.dart` | Gift Engine |
| 27 | `lib/features/gift_engine/presentation/screens/gifts_screen.dart` | Screen 23 |
| 28 | `lib/features/gift_engine/presentation/screens/gift_detail_screen.dart` | Screen 24 |
| 29 | `lib/features/gift_engine/presentation/screens/gift_history_screen.dart` | Screen 25 |

---

## Implementation Notes

### Pattern Compliance

- **Clean Architecture:** Domain entities + repositories are pure Dart; no Flutter imports. Presentation layer is fully separated.
- **Riverpod AsyncNotifier:** All state management uses `@riverpod` codegen annotation with freezed state classes.
- **GoRouter:** All navigation uses named routes via `context.pushNamed()`. Path parameters used for detail screens.
- **Design Tokens:** Every color references `LoloColors.*`, spacing uses `LoloSpacing.*`, gradients use `LoloGradients.*`.
- **Shared Widgets:** `LoloAppBar`, `LoloPrimaryButton`, `LoloTextField`, `LoloChipGroup`, `LoloSlider`, `LoloToggle`, `LoloEmptyState`, `PaginatedListView`, and `GiftCard` are reused from S1-02.
- **RTL-Aware:** All padding uses `EdgeInsetsDirectional`. Alignment uses directional variants. No hardcoded `left`/`right`.
- **Accessibility:** `Semantics` wrappers on interactive elements with descriptive labels and state indicators.

### Dependencies Required (pubspec.yaml additions)

```yaml
dependencies:
  share_plus: ^7.0.0       # Share sheet for messages
  url_launcher: ^6.2.0     # External buy links for gifts
```

### Data Layer Note

Data layer implementations (models, datasources, repository impls) follow the same pattern established in Sprint 2 (S2-01) for onboarding -- Hive for local cache, Dio for remote API calls, `dartz Either` for error handling. These will be implemented as part of the backend integration task (S3-02).
