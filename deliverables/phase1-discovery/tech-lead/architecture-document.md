# LOLO Architecture Document

**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Dependencies:** Feature Backlog MoSCoW (v1.0), User Personas & Journey Maps (v1.0), Competitive Analysis (v1.0), Emotional State Framework (v1.0), Zodiac Master Profiles (v1.0)

---

## Table of Contents

1. [High-Level Architecture](#section-1-high-level-architecture)
2. [Flutter App Architecture](#section-2-flutter-app-architecture)
3. [Folder Structure](#section-3-folder-structure)
4. [Module Architecture](#section-4-module-architecture)
5. [AI Integration Layer](#section-5-ai-integration-layer)
6. [Data Architecture](#section-6-data-architecture)
7. [Authentication & Security](#section-7-authentication--security)
8. [Third-Party Integrations](#section-8-third-party-integrations)
9. [Performance Targets](#section-9-performance-targets)
10. [Testing Strategy Overview](#section-10-testing-strategy-overview)

---

## Section 1: High-Level Architecture

### 1.1 System Architecture Diagram

```
+=====================================================================+
|                        LOLO CLIENT (Flutter)                        |
|                                                                     |
|  +-------------------+  +------------------+  +------------------+  |
|  |   Presentation    |  |     Domain       |  |      Data        |  |
|  |                   |  |                  |  |                  |  |
|  | - Screens/Pages   |  | - Entities       |  | - Repositories   |  |
|  | - Widgets         |  | - Use Cases      |  |   (impl)         |  |
|  | - Riverpod        |  | - Repo Contracts |  | - Data Sources   |  |
|  |   Providers       |  | - Value Objects  |  | - DTOs / Models  |  |
|  +--------+----------+  +--------+---------+  +--------+---------+  |
|           |                      |                      |           |
|  +--------v----------------------v----------------------v--------+  |
|  |                    Core / Shared Layer                        |  |
|  |  Networking (Dio) | DI (Riverpod) | Theme | L10n | Router    |  |
|  +---------------------------+-----------------------------------+  |
+==============================|=======================================+
                               |
                    HTTPS / TLS 1.3
                               |
+==============================|=======================================+
|                    BACKEND SERVICES LAYER                            |
|                                                                     |
|  +------------------+  +-------------------+  +------------------+  |
|  | Firebase Auth    |  | Cloud Functions   |  | Firebase FCM     |  |
|  | (AuthN/AuthZ)    |  | (Business Logic)  |  | (Push Notifs)    |  |
|  +--------+---------+  +--------+----------+  +--------+---------+  |
|           |                      |                      |           |
|  +--------v----------------------v----------------------v--------+  |
|  |                    Data Persistence Layer                     |  |
|  |                                                               |  |
|  |  +----------------+  +----------------+  +----------------+   |  |
|  |  | Firestore      |  | PostgreSQL     |  | Redis          |   |  |
|  |  | (NoSQL primary)|  | (Analytics/    |  | (Cache / Rate  |   |  |
|  |  |                |  |  Billing)      |  |  Limiting)     |   |  |
|  |  +----------------+  +----------------+  +----------------+   |  |
|  +---------------------------------------------------------------+  |
|                                                                     |
+==============================|=======================================+
                               |
                    Internal API / gRPC
                               |
+==============================|=======================================+
|                    AI SERVICES LAYER                                 |
|                                                                     |
|  +---------------------------------------------------------------+  |
|  |                      AI Router Service                        |  |
|  |  (Cloud Function -- classifies, routes, retries, logs cost)   |  |
|  +---+-------------+-------------+-------------+--------+-------+  |
|      |             |             |             |        |           |
|  +---v---+   +-----v----+  +----v-----+  +---v----+  +v--------+  |
|  |Claude |   | Grok     |  | Gemini   |  | GPT    |  |Pinecone/|  |
|  |Haiku/ |   | 4.1 Fast |  | Flash    |  | 5 Mini |  |Weaviate |  |
|  |Sonnet |   |          |  |          |  |        |  |(VectorDB|  |
|  +-------+   +----------+  +----------+  +--------+  +---------+  |
|                                                                     |
|  Specialization:                                                    |
|  Claude  = Deep emotional, nuanced messages, apologies             |
|  Grok    = Real-time SOS coaching, quick-wit responses             |
|  Gemini  = Gift recommendations, data-heavy analysis               |
|  GPT     = General fallback, broad coverage                        |
|  Vector  = Personality matching, memory similarity search           |
+=====================================================================+
```

### 1.2 Client-Server-AI Layer Separation

The architecture is organized into three distinct layers with clear responsibilities:

**Client Layer (Flutter App)**
- All UI rendering, state management, and local caching
- Offline-first data access via Hive/Isar local databases
- Handles authentication tokens, biometric locks, and encryption at rest
- Communicates exclusively with Backend Services via HTTPS REST APIs
- Never calls AI providers directly -- all AI requests go through Cloud Functions

**Backend Services Layer (Firebase + PostgreSQL + Redis)**
- Firebase Auth handles all authentication (email, Google, Apple)
- Cloud Functions serve as the API gateway and business logic layer
- Firestore is the primary NoSQL database for user data, profiles, and memories
- PostgreSQL handles analytics, billing records, and structured reporting
- Redis provides caching for AI responses, rate limiting, and session management
- FCM + APNs manage push notification delivery

**AI Services Layer (Multi-Model)**
- AI Router (Cloud Function) classifies incoming requests by emotional depth, urgency, and task type
- Routes to the optimal model: Claude for emotional depth, Grok for real-time coaching, Gemini for analytical tasks, GPT as general fallback
- Pinecone/Weaviate vector database stores personality embeddings for similarity matching
- All AI responses are cached in Redis with locale-aware keys
- Cost tracking per request for budget management

### 1.3 Data Flow Overview

```
User Action (e.g., "Generate apology message")
    |
    v
Flutter Presentation Layer (Riverpod Provider triggers)
    |
    v
Domain Layer (GenerateMessageUseCase)
    |
    v
Data Layer (MessageRepository -> RemoteDataSource)
    |
    v
Dio HTTP Client -> Cloud Function API endpoint
    |
    v
Cloud Function: validate auth, check rate limits (Redis),
                 check cache (Redis), log request
    |
    v
AI Router: classify request -> route to Claude Sonnet
           (apology = high emotional depth)
    |
    v
Claude API: generate response with context
           (Her Profile, cultural context, language, tone)
    |
    v
Cloud Function: validate response language, cache in Redis,
                 log cost, return to client
    |
    v
Flutter Data Layer: parse DTO -> domain Entity
    |
    v
Riverpod Provider: update state -> UI re-renders
    |
    v
User sees generated message, can copy/share/regenerate
```

---

## Section 2: Flutter App Architecture

### 2.1 Clean Architecture Layers

LOLO follows strict Clean Architecture with three layers, enforced by import rules:

```
+------------------------------------------------------------------+
|                    PRESENTATION LAYER                              |
|  Depends on: Domain Layer                                         |
|  Contains: Screens, Widgets, Riverpod Providers, GoRouter config  |
|  Rules:                                                           |
|    - NO direct Dio/HTTP calls                                     |
|    - NO direct database access                                    |
|    - State managed ONLY via Riverpod providers                    |
|    - Widgets are stateless wherever possible                      |
+------------------------------------------------------------------+
         |  depends on (abstractions only)
         v
+------------------------------------------------------------------+
|                    DOMAIN LAYER                                    |
|  Depends on: NOTHING (pure Dart, zero Flutter imports)            |
|  Contains: Entities, Use Cases, Repository interfaces,            |
|            Value Objects, Failures, Enums                          |
|  Rules:                                                           |
|    - ZERO external package dependencies                           |
|    - Repository interfaces only (no implementations)              |
|    - Use Cases have single public call() method                   |
|    - Entities are immutable (freezed)                             |
+------------------------------------------------------------------+
         ^  implements
         |
+------------------------------------------------------------------+
|                    DATA LAYER                                      |
|  Depends on: Domain Layer                                         |
|  Contains: Repository implementations, Remote/Local data sources, |
|            DTOs/Models, API clients, DB adapters                  |
|  Rules:                                                           |
|    - Implements domain repository interfaces                      |
|    - DTOs map to/from domain entities                             |
|    - Handles all serialization/deserialization                    |
|    - Manages offline-first sync logic                             |
+------------------------------------------------------------------+
```

### 2.2 Feature-First Folder Structure

Every feature module follows an identical internal structure:

```
feature_name/
  data/
    datasources/
      feature_local_datasource.dart
      feature_remote_datasource.dart
    models/
      feature_model.dart          # DTO with fromJson/toJson
    repositories/
      feature_repository_impl.dart
  domain/
    entities/
      feature_entity.dart         # Immutable domain entity (freezed)
    repositories/
      feature_repository.dart     # Abstract interface
    usecases/
      get_feature_usecase.dart
      create_feature_usecase.dart
  presentation/
    providers/
      feature_provider.dart       # Riverpod providers
      feature_state.dart          # State classes (freezed)
    screens/
      feature_screen.dart
    widgets/
      feature_card_widget.dart
      feature_list_widget.dart
```

### 2.3 Dependency Injection Setup (Riverpod)

Riverpod is used as both DI container and state management solution. The DI graph follows Clean Architecture layers:

```dart
// === DATA LAYER PROVIDERS (lowest level) ===

// Remote data sources
@riverpod
MessageRemoteDataSource messageRemoteDataSource(Ref ref) {
  return MessageRemoteDataSourceImpl(
    dio: ref.watch(dioProvider),
    authToken: ref.watch(authTokenProvider),
  );
}

// Local data sources
@riverpod
MessageLocalDataSource messageLocalDataSource(Ref ref) {
  return MessageLocalDataSourceImpl(
    hiveBox: ref.watch(messageBoxProvider),
  );
}

// Repository implementations
@riverpod
MessageRepository messageRepository(Ref ref) {
  return MessageRepositoryImpl(
    remoteDataSource: ref.watch(messageRemoteDataSourceProvider),
    localDataSource: ref.watch(messageLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

// === DOMAIN LAYER PROVIDERS ===

@riverpod
GenerateMessageUseCase generateMessageUseCase(Ref ref) {
  return GenerateMessageUseCase(
    repository: ref.watch(messageRepositoryProvider),
  );
}

// === PRESENTATION LAYER PROVIDERS (highest level) ===

@riverpod
class MessageNotifier extends _$MessageNotifier {
  @override
  MessageState build() => const MessageState.initial();

  Future<void> generateMessage(MessageRequest request) async {
    state = const MessageState.loading();
    final result = await ref.read(generateMessageUseCaseProvider).call(request);
    result.fold(
      (failure) => state = MessageState.error(failure.message),
      (message) => state = MessageState.loaded(message),
    );
  }
}
```

**Provider Hierarchy:**

```
dioProvider (singleton)
  -> *RemoteDataSourceProvider (per feature)
    -> *RepositoryProvider (per feature)
      -> *UseCaseProvider (per feature)
        -> *NotifierProvider (per feature, holds UI state)
```

### 2.4 State Management Strategy Per Module

| Module | Primary State | Strategy | Rationale |
|--------|--------------|----------|-----------|
| Auth/Onboarding | Auth state, onboarding step | `AsyncNotifierProvider` | Multi-step flow with async validation |
| Her Profile | Profile entity, edit mode | `NotifierProvider` | Complex form state with real-time validation |
| Smart Reminders | Reminder list, filters | `AsyncNotifierProvider` + `StreamProvider` | Firestore real-time sync for reminders |
| AI Messages | Generated message, mode, tone | `AsyncNotifierProvider` | Async AI generation with loading/error states |
| Action Cards | Daily cards, completion | `AsyncNotifierProvider` + `FutureProvider` | Daily refresh with cache-first strategy |
| Gift Engine | Recommendations, filters | `AsyncNotifierProvider` | Paginated results with filter state |
| SOS Mode | Crisis scenario, coaching steps | `AsyncNotifierProvider` | Time-sensitive, streaming-like updates |
| Gamification | Streak, XP, score, level | `StreamProvider` | Real-time Firestore updates |
| Memory Vault | Memories list, wish list | `AsyncNotifierProvider` | CRUD with local-first sync |
| Core/Settings | Theme, locale, subscription | `NotifierProvider` | Synchronous app-wide config |

### 2.5 Navigation Architecture (GoRouter)

```dart
final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  refreshListenable: authStateListenable,
  redirect: _guardRoute,
  routes: [
    // === AUTH ROUTES ===
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (_, __) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),

    // === ONBOARDING ROUTES ===
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (_, __) => const OnboardingScreen(),
      routes: [
        GoRoute(path: 'name', name: 'onboarding-name',
          builder: (_, __) => const OnboardingNameScreen()),
        GoRoute(path: 'partner', name: 'onboarding-partner',
          builder: (_, __) => const OnboardingPartnerScreen()),
        GoRoute(path: 'anniversary', name: 'onboarding-anniversary',
          builder: (_, __) => const OnboardingAnniversaryScreen()),
        GoRoute(path: 'privacy', name: 'onboarding-privacy',
          builder: (_, __) => const OnboardingPrivacyScreen()),
        GoRoute(path: 'first-card', name: 'onboarding-first-card',
          builder: (_, __) => const OnboardingFirstCardScreen()),
      ],
    ),

    // === MAIN SHELL (Bottom Navigation) ===
    ShellRoute(
      builder: (_, __, child) => MainShellScreen(child: child),
      routes: [
        // Tab 1: Home
        GoRoute(
          path: '/',
          name: 'home',
          builder: (_, __) => const HomeScreen(),
          routes: [
            GoRoute(path: 'action-card/:id', name: 'action-card-detail',
              builder: (_, state) => ActionCardDetailScreen(
                id: state.pathParameters['id']!)),
            GoRoute(path: 'weekly-summary', name: 'weekly-summary',
              builder: (_, __) => const WeeklySummaryScreen()),
          ],
        ),

        // Tab 2: Messages
        GoRoute(
          path: '/messages',
          name: 'messages',
          builder: (_, __) => const MessagesScreen(),
          routes: [
            GoRoute(path: 'generate', name: 'generate-message',
              builder: (_, __) => const GenerateMessageScreen()),
            GoRoute(path: 'history', name: 'message-history',
              builder: (_, __) => const MessageHistoryScreen()),
            GoRoute(path: 'detail/:id', name: 'message-detail',
              builder: (_, state) => MessageDetailScreen(
                id: state.pathParameters['id']!)),
          ],
        ),

        // Tab 3: Gifts
        GoRoute(
          path: '/gifts',
          name: 'gifts',
          builder: (_, __) => const GiftsScreen(),
          routes: [
            GoRoute(path: 'recommend', name: 'gift-recommend',
              builder: (_, __) => const GiftRecommendScreen()),
            GoRoute(path: 'packages', name: 'gift-packages',
              builder: (_, __) => const GiftPackagesScreen()),
            GoRoute(path: 'detail/:id', name: 'gift-detail',
              builder: (_, state) => GiftDetailScreen(
                id: state.pathParameters['id']!)),
            GoRoute(path: 'budget', name: 'gift-budget',
              builder: (_, __) => const GiftBudgetScreen()),
          ],
        ),

        // Tab 4: Memories
        GoRoute(
          path: '/memories',
          name: 'memories',
          builder: (_, __) => const MemoriesScreen(),
          routes: [
            GoRoute(path: 'create', name: 'memory-create',
              builder: (_, __) => const MemoryCreateScreen()),
            GoRoute(path: 'detail/:id', name: 'memory-detail',
              builder: (_, state) => MemoryDetailScreen(
                id: state.pathParameters['id']!)),
            GoRoute(path: 'wishlist', name: 'wishlist',
              builder: (_, __) => const WishlistScreen()),
            GoRoute(path: 'wishlist/add', name: 'wishlist-add',
              builder: (_, __) => const WishlistAddScreen()),
          ],
        ),

        // Tab 5: Profile
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (_, __) => const ProfileScreen(),
          routes: [
            GoRoute(path: 'her-profile', name: 'her-profile',
              builder: (_, __) => const HerProfileScreen()),
            GoRoute(path: 'her-profile/zodiac', name: 'her-profile-zodiac',
              builder: (_, __) => const ZodiacDetailScreen()),
            GoRoute(path: 'her-profile/family', name: 'family-profiles',
              builder: (_, __) => const FamilyProfilesScreen()),
            GoRoute(path: 'her-profile/family/:id', name: 'family-member',
              builder: (_, state) => FamilyMemberScreen(
                id: state.pathParameters['id']!)),
            GoRoute(path: 'settings', name: 'settings',
              builder: (_, __) => const SettingsScreen()),
            GoRoute(path: 'subscription', name: 'subscription',
              builder: (_, __) => const SubscriptionScreen()),
            GoRoute(path: 'gamification', name: 'gamification',
              builder: (_, __) => const GamificationScreen()),
            GoRoute(path: 'privacy-settings', name: 'privacy-settings',
              builder: (_, __) => const PrivacySettingsScreen()),
            GoRoute(path: 'data-export', name: 'data-export',
              builder: (_, __) => const DataExportScreen()),
          ],
        ),
      ],
    ),

    // === OVERLAY ROUTES (outside shell) ===
    GoRoute(
      path: '/sos',
      name: 'sos',
      builder: (_, __) => const SosScreen(),
      routes: [
        GoRoute(path: 'scenario', name: 'sos-scenario',
          builder: (_, __) => const SosScenarioScreen()),
        GoRoute(path: 'coaching', name: 'sos-coaching',
          builder: (_, __) => const SosCoachingScreen()),
        GoRoute(path: 'followup', name: 'sos-followup',
          builder: (_, __) => const SosFollowUpScreen()),
      ],
    ),

    // === REMINDERS (accessible from multiple tabs) ===
    GoRoute(
      path: '/reminders',
      name: 'reminders',
      builder: (_, __) => const RemindersScreen(),
      routes: [
        GoRoute(path: 'create', name: 'reminder-create',
          builder: (_, __) => const ReminderCreateScreen()),
        GoRoute(path: 'promises', name: 'promises',
          builder: (_, __) => const PromisesScreen()),
        GoRoute(path: 'promises/create', name: 'promise-create',
          builder: (_, __) => const PromiseCreateScreen()),
      ],
    ),

    // === PAYWALL ===
    GoRoute(
      path: '/paywall',
      name: 'paywall',
      builder: (_, state) => PaywallScreen(
        triggerFeature: state.extra as String?),
    ),
  ],
);

// Route guard: redirects unauthenticated users, checks onboarding status
String? _guardRoute(BuildContext context, GoRouterState state) {
  final auth = /* read auth state */;
  final onboarded = /* read onboarding completion */;
  final isAuthRoute = state.matchedLocation.startsWith('/welcome') ||
                      state.matchedLocation.startsWith('/login');
  final isOnboardingRoute = state.matchedLocation.startsWith('/onboarding');

  if (!auth.isAuthenticated && !isAuthRoute) return '/welcome';
  if (auth.isAuthenticated && !onboarded && !isOnboardingRoute) {
    return '/onboarding';
  }
  if (auth.isAuthenticated && onboarded && isAuthRoute) return '/';
  return null;
}
```

---

## Section 3: Folder Structure

```
lolo/
  lib/
    main.dart                           # App entry point, ProviderScope, runApp
    app.dart                            # MaterialApp.router, theme, localization delegates
    bootstrap.dart                      # Hive init, Firebase init, env config

    # ================================================================
    # CORE: Shared utilities, configs, and cross-cutting concerns
    # ================================================================
    core/
      constants/
        app_constants.dart              # App-wide magic numbers, durations
        api_endpoints.dart              # All REST API endpoint strings
        asset_paths.dart                # Image/font/animation asset references
        hive_box_names.dart             # Hive box name constants
        firestore_collections.dart      # Firestore collection/document path strings

      enums/
        language_enum.dart              # en, ar, ms
        subscription_tier_enum.dart     # free, pro, legend
        relationship_status_enum.dart   # dating, engaged, married
        cultural_background_enum.dart   # gulf_arab, levantine, malay, western, etc.
        religious_observance_enum.dart   # high, moderate, low, secular
        action_card_type_enum.dart      # say, do_, buy, go
        message_mode_enum.dart          # good_morning, appreciation, romance, etc.
        crisis_scenario_enum.dart       # argument, forgot, upset, apologize, wrong_thing
        emotional_state_enum.dart       # happy, stressed, sad, angry, anxious, neutral

      errors/
        failures.dart                   # Failure sealed class (ServerFailure, CacheFailure, etc.)
        exceptions.dart                 # Custom exception types
        error_handler.dart              # Global error handling and mapping

      extensions/
        context_extensions.dart         # BuildContext extensions (theme, locale, etc.)
        string_extensions.dart          # String utilities (capitalize, truncate, etc.)
        date_extensions.dart            # DateTime extensions (Hijri conversion, formatting)
        num_extensions.dart             # Number formatting per locale

      network/
        dio_client.dart                 # Dio singleton with interceptors
        api_interceptor.dart            # Auth token injection, refresh logic
        error_interceptor.dart          # HTTP error mapping to Failures
        cache_interceptor.dart          # Response caching interceptor
        network_info.dart               # Connectivity checker interface + impl

      router/
        app_router.dart                 # GoRouter configuration (all routes)
        route_names.dart                # Route name string constants
        route_guards.dart               # Auth and onboarding redirect logic

      theme/
        app_theme.dart                  # ThemeData for light and dark modes
        app_colors.dart                 # Color palette constants
        app_text_styles.dart            # TextStyle definitions
        app_spacing.dart                # Padding/margin constants (8px grid)
        app_shadows.dart                # BoxShadow definitions
        typography/
          arabic_typography.dart         # Arabic font family config (Noto Naskh, Cairo, Tajawal)
          latin_typography.dart          # English/Malay font family config
          typography_utils.dart          # Font weight/size helpers

      localization/
        app_localizations.dart          # Generated l10n class (flutter gen-l10n output)
        l10n_provider.dart              # Riverpod provider for current locale
        hijri_calendar.dart             # Hijri date conversion utilities
        locale_aware_formatters.dart    # Date, number, currency formatters per locale
        cultural_context.dart           # Cultural parameter builder for AI requests

      services/
        local_storage_service.dart      # Hive/Isar abstraction layer
        secure_storage_service.dart     # flutter_secure_storage for tokens/keys
        encryption_service.dart         # AES-256 encryption for Memory Vault
        biometric_service.dart          # Local auth (fingerprint/face) service
        notification_service.dart       # FCM + local notification management
        analytics_service.dart          # Event tracking abstraction (Mixpanel/Amplitude)
        connectivity_service.dart       # Network state monitoring
        calendar_service.dart           # Google Calendar / Apple EventKit abstraction
        share_service.dart              # Share Plus for copy/share actions

      di/
        providers.dart                  # Global Riverpod providers (dio, auth, locale)
        provider_logger.dart            # Riverpod observer for debug logging

      utils/
        validators.dart                 # Email, password, date validators
        debouncer.dart                  # Input debouncing utility
        throttler.dart                  # Rate-limiting utility for API calls
        result.dart                     # Either<Failure, T> type alias (dartz)
        date_utils.dart                 # Date comparison and range helpers
        text_direction_utils.dart       # RTL/LTR detection utilities

    # ================================================================
    # FEATURES: Each module is self-contained with Clean Architecture
    # ================================================================
    features/

      # ------ Module 1: Onboarding & Account ------
      auth/
        data/
          datasources/
            auth_remote_datasource.dart       # Firebase Auth calls
            auth_local_datasource.dart        # Token persistence (secure storage)
          models/
            user_model.dart                   # User DTO (fromFirebaseUser, toJson)
          repositories/
            auth_repository_impl.dart
        domain/
          entities/
            user_entity.dart                  # Core user entity (freezed)
          repositories/
            auth_repository.dart              # Abstract auth contract
          usecases/
            sign_in_with_email_usecase.dart
            sign_in_with_google_usecase.dart
            sign_in_with_apple_usecase.dart
            sign_out_usecase.dart
            get_current_user_usecase.dart
            delete_account_usecase.dart
        presentation/
          providers/
            auth_provider.dart
            auth_state.dart
          screens/
            welcome_screen.dart
            login_screen.dart
          widgets/
            social_sign_in_button.dart
            auth_form_widget.dart

      onboarding/
        data/
          datasources/
            onboarding_remote_datasource.dart  # Save onboarding data to Firestore
            onboarding_local_datasource.dart   # Persist partial progress locally
          models/
            onboarding_data_model.dart
          repositories/
            onboarding_repository_impl.dart
        domain/
          entities/
            onboarding_data_entity.dart
          repositories/
            onboarding_repository.dart
          usecases/
            save_onboarding_step_usecase.dart
            complete_onboarding_usecase.dart
            get_onboarding_progress_usecase.dart
        presentation/
          providers/
            onboarding_provider.dart
            onboarding_state.dart
          screens/
            onboarding_screen.dart              # PageView controller for 5 steps
            onboarding_name_screen.dart
            onboarding_partner_screen.dart
            onboarding_anniversary_screen.dart
            onboarding_privacy_screen.dart
            onboarding_first_card_screen.dart
          widgets/
            language_picker_widget.dart
            zodiac_sign_picker_widget.dart
            date_picker_widget.dart
            onboarding_progress_indicator.dart

      # ------ Module 2: Her Profile Engine ------
      her_profile/
        data/
          datasources/
            her_profile_remote_datasource.dart
            her_profile_local_datasource.dart
          models/
            partner_profile_model.dart
            family_member_model.dart
            zodiac_defaults_model.dart
            cultural_context_model.dart
          repositories/
            her_profile_repository_impl.dart
        domain/
          entities/
            partner_profile_entity.dart        # Name, zodiac, love language, etc.
            family_member_entity.dart           # Mother, father, siblings
            zodiac_profile_entity.dart          # Default traits per sign
            cultural_context_entity.dart        # Cultural/religious settings
            partner_preferences_entity.dart     # Favorites, dislikes, hobbies
          repositories/
            her_profile_repository.dart
          usecases/
            get_partner_profile_usecase.dart
            update_partner_profile_usecase.dart
            get_zodiac_defaults_usecase.dart
            add_family_member_usecase.dart
            update_cultural_context_usecase.dart
            get_profile_completion_usecase.dart
        presentation/
          providers/
            her_profile_provider.dart
            her_profile_state.dart
            zodiac_provider.dart
            family_members_provider.dart
          screens/
            her_profile_screen.dart
            zodiac_detail_screen.dart
            partner_preferences_screen.dart
            cultural_context_screen.dart
            family_profiles_screen.dart
            family_member_screen.dart
          widgets/
            profile_completion_ring.dart
            zodiac_trait_card.dart
            preference_chip_widget.dart
            love_language_selector.dart

      # ------ Module 3: Smart Reminder Engine ------
      reminders/
        data/
          datasources/
            reminders_remote_datasource.dart
            reminders_local_datasource.dart
          models/
            reminder_model.dart
            promise_model.dart
            islamic_holiday_model.dart
          repositories/
            reminders_repository_impl.dart
        domain/
          entities/
            reminder_entity.dart               # Date, type, recurrence, notification tiers
            promise_entity.dart                 # Title, target date, status, priority
            islamic_holiday_entity.dart         # Holiday name, Hijri date, Gregorian equiv
          repositories/
            reminders_repository.dart
          usecases/
            get_reminders_usecase.dart
            create_reminder_usecase.dart
            update_reminder_usecase.dart
            delete_reminder_usecase.dart
            get_upcoming_reminders_usecase.dart
            create_promise_usecase.dart
            complete_promise_usecase.dart
            get_islamic_holidays_usecase.dart
            sync_calendar_usecase.dart
        presentation/
          providers/
            reminders_provider.dart
            reminders_state.dart
            promises_provider.dart
          screens/
            reminders_screen.dart
            reminder_create_screen.dart
            promises_screen.dart
            promise_create_screen.dart
          widgets/
            reminder_card_widget.dart
            reminder_tier_indicator.dart
            promise_status_badge.dart
            calendar_sync_button.dart
            hijri_date_display.dart

      # ------ Module 4: AI Message Generator ------
      ai_messages/
        data/
          datasources/
            message_remote_datasource.dart     # Cloud Function calls for AI gen
            message_local_datasource.dart      # Cache generated messages locally
          models/
            generated_message_model.dart
            message_request_model.dart
            message_feedback_model.dart
          repositories/
            message_repository_impl.dart
        domain/
          entities/
            generated_message_entity.dart      # Content, mode, tone, language, timestamp
            message_request_entity.dart        # Mode, tone, length, language, context
          repositories/
            message_repository.dart
          usecases/
            generate_message_usecase.dart
            regenerate_message_usecase.dart
            rate_message_usecase.dart
            get_message_history_usecase.dart
            favorite_message_usecase.dart
        presentation/
          providers/
            message_provider.dart
            message_state.dart
            message_mode_provider.dart
            message_history_provider.dart
          screens/
            messages_screen.dart                # Mode selection grid
            generate_message_screen.dart        # Generation + result display
            message_history_screen.dart
            message_detail_screen.dart
          widgets/
            message_mode_card.dart
            tone_slider_widget.dart
            length_selector_widget.dart
            message_result_card.dart
            copy_share_bar.dart
            message_feedback_widget.dart

      # ------ Module 5: Smart Action Cards ------
      action_cards/
        data/
          datasources/
            action_cards_remote_datasource.dart
            action_cards_local_datasource.dart
          models/
            action_card_model.dart
            card_feedback_model.dart
          repositories/
            action_cards_repository_impl.dart
        domain/
          entities/
            action_card_entity.dart             # Type (SAY/DO/BUY/GO), content, status
          repositories/
            action_cards_repository.dart
          usecases/
            get_daily_cards_usecase.dart
            complete_card_usecase.dart
            skip_card_usecase.dart
            get_card_history_usecase.dart
        presentation/
          providers/
            action_cards_provider.dart
            action_cards_state.dart
          screens/
            action_card_detail_screen.dart
          widgets/
            action_card_widget.dart              # Main card with swipe actions
            say_card_content.dart
            do_card_content.dart
            buy_card_content.dart
            go_card_content.dart
            card_type_badge.dart
            card_completion_button.dart
            card_skip_sheet.dart

      # ------ Module 6: Gift Recommendation Engine ------
      gift_engine/
        data/
          datasources/
            gift_remote_datasource.dart
            gift_local_datasource.dart
          models/
            gift_recommendation_model.dart
            gift_package_model.dart
            gift_feedback_model.dart
          repositories/
            gift_repository_impl.dart
        domain/
          entities/
            gift_recommendation_entity.dart     # Name, desc, price, reasoning, affiliate link
            gift_package_entity.dart            # Primary + complementary + message + wrapping
            budget_filter_entity.dart
          repositories/
            gift_repository.dart
          usecases/
            get_gift_recommendations_usecase.dart
            get_gift_packages_usecase.dart
            submit_gift_feedback_usecase.dart
        presentation/
          providers/
            gift_provider.dart
            gift_state.dart
            gift_filter_provider.dart
          screens/
            gifts_screen.dart
            gift_recommend_screen.dart
            gift_packages_screen.dart
            gift_detail_screen.dart
            gift_budget_screen.dart
          widgets/
            gift_card_widget.dart
            budget_range_slider.dart
            low_budget_toggle.dart
            affiliate_link_button.dart
            gift_feedback_dialog.dart

      # ------ Module 7: SOS Mode ------
      sos_mode/
        data/
          datasources/
            sos_remote_datasource.dart
            sos_local_datasource.dart          # Cached offline emergency responses
          models/
            sos_response_model.dart
            crisis_scenario_model.dart
          repositories/
            sos_repository_impl.dart
        domain/
          entities/
            sos_response_entity.dart            # Steps, say-this, dont-say, body language
            crisis_scenario_entity.dart
          repositories/
            sos_repository.dart
          usecases/
            get_sos_coaching_usecase.dart
            get_cached_sos_tips_usecase.dart
            submit_sos_followup_usecase.dart
        presentation/
          providers/
            sos_provider.dart
            sos_state.dart
          screens/
            sos_screen.dart                     # 2-tap entry point
            sos_scenario_screen.dart            # Crisis type selection
            sos_coaching_screen.dart            # Step-by-step AI coaching
            sos_follow_up_screen.dart           # "How did it go?" feedback
          widgets/
            crisis_scenario_button.dart
            coaching_step_card.dart
            say_this_widget.dart
            dont_say_this_widget.dart

      # ------ Module 8: Gamification ------
      gamification/
        data/
          datasources/
            gamification_remote_datasource.dart
            gamification_local_datasource.dart
          models/
            gamification_model.dart
            streak_model.dart
            level_model.dart
          repositories/
            gamification_repository_impl.dart
        domain/
          entities/
            gamification_entity.dart            # XP, level, streak, consistency score
            streak_entity.dart                  # Current, longest, freeze available
            level_entity.dart                   # Level number, name, XP threshold
            consistency_score_entity.dart       # Score 0-100, component breakdown
          repositories/
            gamification_repository.dart
          usecases/
            get_gamification_stats_usecase.dart
            award_xp_usecase.dart
            get_weekly_summary_usecase.dart
            use_streak_freeze_usecase.dart
        presentation/
          providers/
            gamification_provider.dart
            gamification_state.dart
            streak_provider.dart
          screens/
            gamification_screen.dart
            weekly_summary_screen.dart
          widgets/
            streak_counter_widget.dart
            xp_display_widget.dart
            level_badge_widget.dart
            consistency_score_gauge.dart
            level_up_dialog.dart
            weekly_summary_card.dart

      # ------ Module 9: Memory Vault ------
      memory_vault/
        data/
          datasources/
            memory_remote_datasource.dart
            memory_local_datasource.dart
          models/
            memory_model.dart
            wish_list_item_model.dart
          repositories/
            memory_repository_impl.dart
        domain/
          entities/
            memory_entity.dart                  # Title, desc, date, photo, tags, encrypted
            wish_list_item_entity.dart          # Item, price, date mentioned, priority
          repositories/
            memory_repository.dart
          usecases/
            create_memory_usecase.dart
            get_memories_usecase.dart
            search_memories_usecase.dart
            create_wish_list_item_usecase.dart
            get_wish_list_usecase.dart
        presentation/
          providers/
            memory_provider.dart
            memory_state.dart
            wishlist_provider.dart
          screens/
            memories_screen.dart
            memory_create_screen.dart
            memory_detail_screen.dart
            wishlist_screen.dart
            wishlist_add_screen.dart
          widgets/
            memory_card_widget.dart
            memory_tag_chips.dart
            wish_list_item_card.dart
            encrypted_badge.dart

      # ------ Module 10: Core Infrastructure ------
      home/
        presentation/
          providers/
            home_provider.dart
            home_state.dart
          screens/
            home_screen.dart                    # Dashboard: card, streak, score, reminders
            main_shell_screen.dart              # Bottom navigation shell
          widgets/
            dashboard_action_card.dart
            dashboard_streak_bar.dart
            dashboard_score_widget.dart
            next_reminder_card.dart
            quick_access_row.dart               # Message + SOS shortcuts

      subscription/
        data/
          datasources/
            subscription_remote_datasource.dart  # RevenueCat SDK calls
            subscription_local_datasource.dart
          models/
            subscription_model.dart
            entitlement_model.dart
          repositories/
            subscription_repository_impl.dart
        domain/
          entities/
            subscription_entity.dart             # Tier, expiry, entitlements
          repositories/
            subscription_repository.dart
          usecases/
            get_subscription_usecase.dart
            purchase_subscription_usecase.dart
            restore_purchases_usecase.dart
            check_feature_access_usecase.dart
        presentation/
          providers/
            subscription_provider.dart
            subscription_state.dart
            feature_gate_provider.dart
          screens/
            subscription_screen.dart
            paywall_screen.dart
          widgets/
            tier_comparison_card.dart
            feature_gate_dialog.dart

      settings/
        presentation/
          providers/
            settings_provider.dart
          screens/
            settings_screen.dart
            privacy_settings_screen.dart
            data_export_screen.dart
          widgets/
            settings_tile_widget.dart
            language_switch_tile.dart
            theme_switch_tile.dart
            notification_toggle_tile.dart

    # ================================================================
    # L10N: Localization ARB files
    # ================================================================
    l10n/
      app_en.arb                        # English strings (baseline)
      app_ar.arb                        # Arabic strings (full RTL)
      app_ms.arb                        # Bahasa Melayu strings

  # ================================================================
  # ASSETS
  # ================================================================
  assets/
    images/
      logo/                             # App logo variants (light, dark, splash)
      onboarding/                       # Onboarding illustrations
      action_cards/                     # SAY/DO/BUY/GO card icons
      zodiac/                           # 12 zodiac sign illustrations
      gamification/                     # Level badges, streak flames
      empty_states/                     # Empty state illustrations per screen
    fonts/
      noto_naskh_arabic/                # Arabic font files (Regular, Bold)
      cairo/                            # Cairo Arabic font files
      tajawal/                          # Tajawal Arabic font files
    animations/
      lottie/                           # Lottie JSON animations
        loading.json
        level_up.json
        streak_flame.json
        card_complete.json
        sos_pulse.json
    icons/
      custom/                           # Custom SVG icons (RTL-aware)

  # ================================================================
  # TEST
  # ================================================================
  test/
    core/                               # Core utility tests
    features/
      auth/
        data/                           # Data source and repo tests
        domain/                         # Use case tests
        presentation/                   # Provider and widget tests
      # ... (mirrors lib/features/ structure for all modules)
    helpers/                            # Test utilities, mocks, fakes
    fixtures/                           # JSON fixtures for API responses
    golden/                             # Golden test reference images

  integration_test/
    auth_flow_test.dart
    onboarding_flow_test.dart
    message_generation_test.dart
    action_card_flow_test.dart
    sos_mode_flow_test.dart
    subscription_flow_test.dart
    rtl_layout_test.dart

  # ================================================================
  # CONFIG
  # ================================================================
  pubspec.yaml
  analysis_options.yaml                 # Lint rules (very_good_analysis)
  l10n.yaml                            # flutter gen-l10n config
  .env.development                     # Dev environment variables
  .env.staging                         # Staging environment variables
  .env.production                      # Production environment variables
  firebase.json                        # Firebase project config
  codemagic.yaml                       # Codemagic CI/CD pipeline
  .github/
    workflows/
      ci.yml                           # GitHub Actions: lint, test, build
      cd.yml                           # GitHub Actions: deploy to stores
```

---

## Section 4: Module Architecture

### Module 1: Onboarding & Account

**Feature Folder:** `lib/features/auth/` + `lib/features/onboarding/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `UserEntity` | uid, email, displayName, photoUrl, provider, createdAt |
| Entity | `OnboardingDataEntity` | userName, partnerName, zodiacSign, anniversaryDate, weddingDate, languageCode, step |
| Repository | `AuthRepository` | signInEmail, signInGoogle, signInApple, signOut, getCurrentUser, deleteAccount |
| Repository | `OnboardingRepository` | saveStep, completeOnboarding, getProgress |
| UseCase | `SignInWithGoogleUseCase` | Single call() -> Either<Failure, UserEntity> |
| UseCase | `CompleteOnboardingUseCase` | Validates all steps, saves to Firestore, marks complete |
| Provider | `AuthNotifier` | Manages auth state (unauthenticated, authenticating, authenticated, error) |
| Provider | `OnboardingNotifier` | Manages 5-step flow state, partial persistence |
| Screen | `WelcomeScreen` | Logo, social sign-in buttons, privacy link |
| Screen | `OnboardingScreen` | PageView with 5 sub-screens |

**Data Sources:**
- Remote: Firebase Auth SDK, Firestore (`users/{uid}`, `users/{uid}/onboarding`)
- Local: `flutter_secure_storage` for auth tokens, Hive for onboarding draft

**Dependencies:** None (foundation module)

---

### Module 2: Her Profile Engine

**Feature Folder:** `lib/features/her_profile/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `PartnerProfileEntity` | name, zodiacSign, birthday, loveLanguage, commStyle, status, completionPct |
| Entity | `FamilyMemberEntity` | name, relationship, birthday, interests, healthNotes |
| Entity | `ZodiacProfileEntity` | sign, traits[], commPrefs, emotionalTendencies, giftPrefs |
| Entity | `CulturalContextEntity` | background, religiousObservance, islamicCalendarEnabled |
| Entity | `PartnerPreferencesEntity` | favorites{}, dislikes[], hobbies[], stressCoping |
| Repository | `HerProfileRepository` | CRUD for partner profile, family members, cultural context |
| UseCase | `GetZodiacDefaultsUseCase` | Returns default traits for given zodiac sign |
| UseCase | `GetProfileCompletionUseCase` | Calculates % complete, identifies missing fields |
| Provider | `HerProfileNotifier` | Manages partner profile form state, validation |
| Provider | `FamilyMembersNotifier` | CRUD state for family member list |

**Data Sources:**
- Remote: Firestore (`users/{uid}/partner_profile`, `users/{uid}/family_members/{fid}`)
- Local: Hive (`partnerProfileBox`, `familyMembersBox`) for offline access

**Dependencies:**
- Auth module (requires uid)
- Provides data to: AI Messages, Action Cards, Gift Engine, SOS Mode

---

### Module 3: Smart Reminder Engine

**Feature Folder:** `lib/features/reminders/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `ReminderEntity` | title, date, type, recurrence, tiers[30d,14d,7d,3d,1d,0d], snoozed, dismissed |
| Entity | `PromiseEntity` | title, description, targetDate, priority, status(open/inProgress/completed/overdue) |
| Entity | `IslamicHolidayEntity` | name, hijriDate, gregorianDate, reminderStartDays |
| Repository | `RemindersRepository` | CRUD reminders, promises; getUpcoming; getIslamicHolidays |
| UseCase | `GetUpcomingRemindersUseCase` | Returns next 7 days of reminders sorted by urgency |
| UseCase | `SyncCalendarUseCase` | Imports from Google Calendar / Apple EventKit |
| UseCase | `CompletePromiseUseCase` | Marks complete + triggers XP award via gamification |
| Provider | `RemindersNotifier` | List state with filter (all/birthday/anniversary/custom/islamic) |
| Provider | `PromisesNotifier` | Promise list with status filter |

**Data Sources:**
- Remote: Firestore (`users/{uid}/reminders/{rid}`, `users/{uid}/promises/{pid}`)
- Local: Hive (`remindersBox`, `promisesBox`) + scheduled local notifications

**Dependencies:**
- Auth module (uid)
- Her Profile (partner birthday, cultural context for Islamic holidays)
- Core notification service (scheduling)
- Gamification (XP awards on promise completion)

---

### Module 4: AI Message Generator

**Feature Folder:** `lib/features/ai_messages/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `GeneratedMessageEntity` | content, mode, tone, length, language, modelUsed, timestamp |
| Entity | `MessageRequestEntity` | mode, tone, length, language, partnerContext, culturalContext, customPrompt |
| Repository | `MessageRepository` | generateMessage, regenerateMessage, rateMessage, getHistory, toggleFavorite |
| UseCase | `GenerateMessageUseCase` | Builds context from Her Profile + cultural settings, calls API |
| UseCase | `RegenerateMessageUseCase` | Same context, requests different output |
| UseCase | `RateMessageUseCase` | Thumbs up/down feedback for model improvement |
| Provider | `MessageNotifier` | Generation state (initial/loading/loaded/error), current message |
| Provider | `MessageModeProvider` | Selected mode, available modes based on subscription tier |
| Provider | `MessageHistoryNotifier` | Paginated history with search/filter |

**Data Sources:**
- Remote: Cloud Function (`/api/v1/messages/generate`, `/api/v1/messages/rate`)
- Local: Hive (`messageHistoryBox`) for offline history access

**Dependencies:**
- Auth module (uid, auth token)
- Her Profile (partner context for personalization)
- Subscription (tier determines available modes and monthly limits)
- Gamification (XP on message sent)

---

### Module 5: Smart Action Cards

**Feature Folder:** `lib/features/action_cards/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `ActionCardEntity` | id, type(SAY/DO/BUY/GO), content, suggestion, estimatedCost, estimatedTime, xpReward, status, createdAt |
| Repository | `ActionCardsRepository` | getDailyCards, completeCard, skipCard(reason), getHistory |
| UseCase | `GetDailyCardsUseCase` | Fetches today's cards (count based on tier) |
| UseCase | `CompleteCardUseCase` | Marks complete, triggers XP award |
| UseCase | `SkipCardUseCase` | Logs skip reason for algorithm improvement |
| Provider | `ActionCardsNotifier` | Today's cards state, completion tracking |

**Data Sources:**
- Remote: Cloud Function (`/api/v1/action-cards/daily`, `/api/v1/action-cards/complete`)
- Local: Hive (`actionCardsBox`) for today's cached cards

**Dependencies:**
- Auth module (uid)
- Her Profile (personalization context)
- Subscription (daily card limit: free=1, pro=3, legend=5)
- Gamification (XP on completion)
- AI Messages (SAY cards link to message generator)
- Gift Engine (BUY cards link to gift recommendations)

---

### Module 6: Gift Recommendation Engine

**Feature Folder:** `lib/features/gift_engine/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `GiftRecommendationEntity` | name, description, priceRange, reasoning, affiliateUrl, imageUrl |
| Entity | `GiftPackageEntity` | primaryGift, complementaryItems[], cardMessage, presentationIdea, totalBudget |
| Entity | `BudgetFilterEntity` | min, max, lowBudgetHighImpact, currency |
| Repository | `GiftRepository` | getRecommendations, getPackages, submitFeedback |
| UseCase | `GetGiftRecommendationsUseCase` | Passes occasion, budget, profile, cultural context to AI |
| UseCase | `SubmitGiftFeedbackUseCase` | "She loved it" / "Didn't like it" feedback |
| Provider | `GiftNotifier` | Recommendation list state, loading, pagination |
| Provider | `GiftFilterProvider` | Budget range, occasion, low-budget toggle |

**Data Sources:**
- Remote: Cloud Function (`/api/v1/gifts/recommend`, `/api/v1/gifts/packages`)
- Local: Hive (`giftHistoryBox`) for past recommendations

**Dependencies:**
- Auth module (uid)
- Her Profile (preferences, interests, dislikes for filtering)
- Memory Vault (wish list items surfaced as top recommendations)
- Subscription (request limits: free=2/mo, pro=10/mo, legend=unlimited)

---

### Module 7: SOS Mode

**Feature Folder:** `lib/features/sos_mode/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `SosResponseEntity` | steps[], sayThis[], dontSayThis[], bodyLanguageTips[], followUpTime |
| Entity | `CrisisScenarioEntity` | id, title, description, icon, offlineTips[] |
| Repository | `SosRepository` | getCoaching(scenario), getCachedTips, submitFollowup |
| UseCase | `GetSosCoachingUseCase` | Routes to Grok for real-time coaching; falls back to cached tips offline |
| UseCase | `GetCachedSosTipsUseCase` | Returns offline emergency responses |
| Provider | `SosNotifier` | Coaching state with step-by-step progression |

**Data Sources:**
- Remote: Cloud Function (`/api/v1/sos/coaching`) -- routes to Grok for speed
- Local: Pre-cached JSON (`assets/sos_offline_tips.json`) + Hive for user-specific cached responses

**Dependencies:**
- Auth module (uid)
- Her Profile (communication style, cultural context for calibrated coaching)
- Subscription (usage limits: free=1/mo, pro=3/mo, legend=unlimited; model quality: pro=standard, legend=premium)

---

### Module 8: Gamification

**Feature Folder:** `lib/features/gamification/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `GamificationEntity` | totalXp, currentLevel, streak, consistencyScore, weeklyChange |
| Entity | `StreakEntity` | currentStreak, longestStreak, lastActiveDate, freezeAvailable, freezeUsedThisMonth |
| Entity | `LevelEntity` | number(1-10), name, xpThreshold, nextLevelXp |
| Entity | `ConsistencyScoreEntity` | score(0-100), cardCompletion(30%), streak(20%), messages(15%), reminders(15%), promises(20%), percentile |
| Repository | `GamificationRepository` | getStats, awardXp, getWeeklySummary, useStreakFreeze |
| UseCase | `AwardXpUseCase` | Validates action, calculates XP, checks daily cap (100), updates |
| UseCase | `GetWeeklySummaryUseCase` | Aggregates weekly stats for summary report |
| Provider | `GamificationNotifier` | Real-time stats via Firestore stream |
| Provider | `StreakProvider` | Streak-specific state with daily check |

**Data Sources:**
- Remote: Firestore (`users/{uid}/gamification`) -- real-time stream
- Local: Hive (`gamificationBox`) for offline display

**Dependencies:**
- Auth module (uid)
- Receives XP triggers from: Action Cards, AI Messages, Reminders, Promises, Memory Vault, Her Profile

---

### Module 9: Memory Vault

**Feature Folder:** `lib/features/memory_vault/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `MemoryEntity` | id, title, description, date, photoUrls[], tags[], isEncrypted, createdAt |
| Entity | `WishListItemEntity` | id, description, approximatePrice, dateMentioned, priority, occasionLink |
| Repository | `MemoryRepository` | CRUD memories, search, CRUD wish list items |
| UseCase | `CreateMemoryUseCase` | Validates, encrypts, stores locally + remote |
| UseCase | `SearchMemoriesUseCase` | Full-text search across titles, descriptions, tags |
| Provider | `MemoryNotifier` | Memory list with sort/filter/search |
| Provider | `WishlistNotifier` | Wish list CRUD state |

**Data Sources:**
- Remote: Firestore (`users/{uid}/memories/{mid}`, `users/{uid}/wishlist/{wid}`)
- Local: Hive (encrypted box `memoryVaultBox`, `wishlistBox`)

**Dependencies:**
- Auth module (uid)
- Core encryption service (AES-256 for memory content)
- Gift Engine (wish list items surface in recommendations)
- Gamification (XP on memory logged)
- Subscription (memory limits: free=10, pro=50, legend=unlimited)

---

### Module 10: Core Infrastructure

**Feature Folders:** `lib/features/home/`, `lib/features/subscription/`, `lib/features/settings/`

**Key Classes:**

| Layer | Class | Responsibility |
|-------|-------|---------------|
| Entity | `SubscriptionEntity` | tier(free/pro/legend), expiryDate, entitlements[], isTrialing |
| Repository | `SubscriptionRepository` | getSubscription, purchase, restore, checkFeatureAccess |
| UseCase | `CheckFeatureAccessUseCase` | Given feature+tier, returns allowed/blocked with limit counts |
| Provider | `SubscriptionNotifier` | Current tier, entitlements, paywall trigger logic |
| Provider | `FeatureGateProvider` | Per-feature access checks used by all modules |
| Provider | `HomeNotifier` | Aggregates dashboard data: today's card, streak, score, next reminder |
| Screen | `HomeScreen` | Dashboard layout with card, streak bar, score, reminder, quick access |
| Screen | `MainShellScreen` | Scaffold with BottomNavigationBar (5 tabs), RTL-aware tab order |
| Screen | `PaywallScreen` | Feature comparison, pricing, trial CTA |
| Screen | `SettingsScreen` | Language, notifications, theme, subscription, privacy, account |

**Data Sources:**
- Remote: RevenueCat SDK for subscription state, Firestore for settings sync
- Local: Hive (`settingsBox`), `shared_preferences` for quick access settings

**Dependencies:**
- Auth module (uid)
- All feature modules depend on Subscription for feature gating
- Home aggregates data from: Action Cards, Gamification, Reminders

---

## Section 5: AI Integration Layer

### 5.1 AI Router Architecture

The AI Router is implemented as a Firebase Cloud Function that sits between the Flutter client and all AI providers. The client never calls AI APIs directly.

```
Client Request
    |
    v
Cloud Function: /api/v1/ai/route
    |
    v
+--------------------------------------------------+
|                  AI ROUTER                        |
|                                                   |
|  1. Authenticate (verify Firebase ID token)       |
|  2. Rate Limit (Redis: user tier limits)          |
|  3. Check Cache (Redis: locale-aware key)         |
|  4. Classify Request:                             |
|     - emotionalDepth: low/medium/high/crisis      |
|     - taskType: message/gift/coaching/analysis     |
|     - urgency: normal/high/critical               |
|  5. Route to optimal model                        |
|  6. Execute with timeout + retry                  |
|  7. Validate response (language check, safety)    |
|  8. Cache response (Redis, TTL per type)          |
|  9. Log cost (model, tokens, latency)             |
|  10. Return to client                             |
+--------------------------------------------------+
```

**Routing Matrix:**

| Request Type | Emotional Depth | Primary Model | Fallback Model | Timeout |
|-------------|----------------|---------------|----------------|---------|
| Message: Good Morning | Low | Claude Haiku | GPT-5 Mini | 5s |
| Message: Appreciation | Medium | Claude Haiku | GPT-5 Mini | 5s |
| Message: Romance | High | Claude Sonnet | Claude Haiku | 8s |
| Message: Apology | Very High | Claude Sonnet | Claude Haiku | 8s |
| Message: Comfort | Very High | Claude Sonnet | Claude Haiku | 8s |
| Gift Recommendations | Low (analytical) | Gemini Flash | GPT-5 Mini | 10s |
| Gift Packages | Medium | Gemini Flash | Claude Haiku | 10s |
| SOS Coaching | Crisis | Grok 4.1 Fast | Claude Haiku | 3s |
| Action Card Generation | Medium | Claude Haiku | GPT-5 Mini | 5s |
| Consistency Score Analysis | Low (analytical) | Gemini Flash | GPT-5 Mini | 5s |

### 5.2 Model-Specific Adapters

Each AI provider has a dedicated adapter that normalizes the request/response interface:

```dart
// Abstract adapter interface
abstract class AiModelAdapter {
  Future<AiResponse> generate(AiRequest request);
  String get modelId;
  double get costPerInputToken;
  double get costPerOutputToken;
}

// Claude adapter
class ClaudeAdapter implements AiModelAdapter {
  // Uses Anthropic Messages API
  // Supports system prompts for cultural context injection
  // Handles streaming for SOS real-time (future)
}

// Grok adapter
class GrokAdapter implements AiModelAdapter {
  // Uses xAI API
  // Optimized for low latency (SOS Mode)
  // Supports function calling for structured coaching steps
}

// Gemini adapter
class GeminiAdapter implements AiModelAdapter {
  // Uses Google AI API
  // Supports grounding for gift recommendations with real product data
  // Handles multi-modal (future: image-based gift matching)
}

// GPT adapter
class GptAdapter implements AiModelAdapter {
  // Uses OpenAI API
  // General-purpose fallback
  // Supports function calling for structured output
}
```

### 5.3 Request/Response DTOs

**AI Request DTO (sent to Cloud Function):**

```json
{
  "requestType": "message_generate",
  "mode": "apology",
  "parameters": {
    "tone": "warm",
    "length": "medium",
    "language": "ar",
    "dialect": "gulf"
  },
  "context": {
    "partnerName": "Noura",
    "relationshipStatus": "engaged",
    "zodiacSign": "leo",
    "loveLanguage": "quality_time",
    "culturalBackground": "gulf_arab",
    "religiousObservance": "high",
    "isRamadan": false,
    "isPregnant": false,
    "recentMemories": ["she mentioned wanting to visit Istanbul"],
    "currentEmotionalContext": "he forgot to call her after work"
  },
  "userId": "uid_xxx",
  "tier": "pro",
  "requestId": "req_abc123"
}
```

**AI Response DTO (returned to client):**

```json
{
  "requestId": "req_abc123",
  "content": "نورة، أعتذر إني ما اتصلت عليج بعد الدوام...",
  "metadata": {
    "modelUsed": "claude-sonnet",
    "language": "ar",
    "dialect": "gulf",
    "tokensUsed": { "input": 450, "output": 120 },
    "cost": 0.0023,
    "latencyMs": 2340,
    "cached": false
  },
  "alternatives": [],
  "safetyFlags": []
}
```

### 5.4 Caching Strategy (Redis Key Structure)

```
# Message cache (TTL: 0 -- messages are never cached identically, but similar requests are)
# Instead, we cache "template" responses for common low-emotional-depth requests
cache:msg:{language}:{mode}:{tone}:{length}:{hash(context)} -> response JSON
TTL: 1 hour for low emotional depth, 0 for high emotional depth

# Gift recommendation cache (TTL: 24 hours)
cache:gift:{language}:{occasion}:{budgetRange}:{hash(profilePrefs)} -> response JSON
TTL: 24 hours

# SOS offline tips (TTL: 7 days, refreshed on app open)
cache:sos:{language}:{scenario}:{culturalContext} -> response JSON
TTL: 7 days

# Action card daily cache (TTL: until next generation at 8 AM local)
cache:card:{userId}:{date} -> response JSON
TTL: until 08:00 next day (user local time)

# Rate limit counters
ratelimit:{userId}:msg:{month} -> count (TTL: end of month)
ratelimit:{userId}:gift:{month} -> count (TTL: end of month)
ratelimit:{userId}:sos:{month} -> count (TTL: end of month)
ratelimit:{userId}:card:{date} -> count (TTL: end of day)
```

### 5.5 Failover Logic

```
Primary Model Request
    |
    +--> Success? -> Return response
    |
    +--> Timeout (model-specific threshold)?
    |       |
    |       +--> Retry once with 50% shorter prompt
    |       |
    |       +--> Still timeout? -> Route to Fallback Model
    |
    +--> Rate Limited (429)?
    |       |
    |       +--> Route to Fallback Model immediately
    |
    +--> Server Error (5xx)?
    |       |
    |       +--> Retry once after 1s delay
    |       |
    |       +--> Still failing? -> Route to Fallback Model
    |
    +--> Fallback Model Request
            |
            +--> Success? -> Return response (log degraded service)
            |
            +--> Also failing? -> Return cached response if available
            |
            +--> No cache? -> Return localized error message to user
                              ("We're having trouble. Try again in a moment.")
```

**Fallback Chain:**
1. Claude Sonnet -> Claude Haiku -> GPT-5 Mini
2. Grok 4.1 Fast -> Claude Haiku -> cached offline tips
3. Gemini Flash -> GPT-5 Mini -> Claude Haiku

### 5.6 Cost Tracking

Every AI request logs cost data to PostgreSQL for budget monitoring:

```sql
CREATE TABLE ai_cost_log (
  id UUID PRIMARY KEY,
  user_id TEXT NOT NULL,
  request_id TEXT NOT NULL,
  model_id TEXT NOT NULL,          -- 'claude-sonnet', 'grok-4.1-fast', etc.
  request_type TEXT NOT NULL,       -- 'message', 'gift', 'sos', 'card'
  input_tokens INTEGER NOT NULL,
  output_tokens INTEGER NOT NULL,
  cost_usd DECIMAL(10, 6) NOT NULL,
  latency_ms INTEGER NOT NULL,
  was_cached BOOLEAN DEFAULT FALSE,
  was_fallback BOOLEAN DEFAULT FALSE,
  language TEXT NOT NULL,
  tier TEXT NOT NULL,               -- 'free', 'pro', 'legend'
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Daily cost summary view
CREATE MATERIALIZED VIEW daily_ai_costs AS
SELECT
  DATE(created_at) AS date,
  model_id,
  request_type,
  COUNT(*) AS request_count,
  SUM(cost_usd) AS total_cost,
  AVG(latency_ms) AS avg_latency,
  SUM(CASE WHEN was_fallback THEN 1 ELSE 0 END) AS fallback_count
FROM ai_cost_log
GROUP BY DATE(created_at), model_id, request_type;
```

**Budget Alerts:**
- Daily spend > $50: Warning notification to tech lead
- Daily spend > $100: Alert to tech lead + PM
- Per-user anomaly (>50 requests/day): Flag for review

---

## Section 6: Data Architecture

### 6.1 Firebase Firestore Schema

```
Firestore Root
|
+-- users/{uid}
|     |
|     +-- Fields:
|     |     email: string
|     |     displayName: string
|     |     photoUrl: string?
|     |     authProvider: string           // 'email', 'google', 'apple'
|     |     languageCode: string           // 'en', 'ar', 'ms'
|     |     onboardingComplete: boolean
|     |     subscriptionTier: string       // 'free', 'pro', 'legend'
|     |     createdAt: timestamp
|     |     updatedAt: timestamp
|     |     lastActiveAt: timestamp
|     |     fcmToken: string?
|     |     settings: map {
|     |       theme: string                // 'dark', 'light'
|     |       notificationsEnabled: boolean
|     |       quietHoursStart: string      // "22:00"
|     |       quietHoursEnd: string        // "07:00"
|     |       maxDailyNotifications: int   // default 3
|     |       biometricLockEnabled: boolean
|     |     }
|     |
|     +-- partner_profile (document)
|     |     name: string
|     |     zodiacSign: string?            // 'aries', 'taurus', ..., 'pisces'
|     |     birthday: timestamp?
|     |     loveLanguage: string?          // 'words', 'acts', 'gifts', 'time', 'touch'
|     |     communicationStyle: string?    // 'direct', 'indirect', 'mixed'
|     |     relationshipStatus: string     // 'dating', 'engaged', 'married'
|     |     relationshipStartDate: timestamp?
|     |     weddingDate: timestamp?
|     |     isPregnant: boolean
|     |     pregnancyMonth: int?
|     |     culturalBackground: string?    // 'gulf_arab', 'levantine', 'malay', etc.
|     |     religiousObservance: string?   // 'high', 'moderate', 'low', 'secular'
|     |     completionPercentage: int
|     |     preferences: map {
|     |       favorites: map {
|     |         flowers: string[]
|     |         food: string[]
|     |         music: string[]
|     |         movies: string[]
|     |         brands: string[]
|     |         colors: string[]
|     |       }
|     |       dislikes: string[]
|     |       hobbies: string[]
|     |       stressCoping: string?        // 'vent_first', 'space_first', 'distraction'
|     |       notes: string?               // Free-text observations
|     |     }
|     |     updatedAt: timestamp
|     |
|     +-- family_members/{fid}
|     |     name: string
|     |     relationship: string           // 'mother', 'father', 'sister', 'brother', 'other'
|     |     birthday: timestamp?
|     |     interests: string[]
|     |     healthNotes: string?
|     |     notes: string?
|     |     createdAt: timestamp
|     |
|     +-- reminders/{rid}
|     |     title: string
|     |     date: timestamp
|     |     type: string                   // 'birthday', 'anniversary', 'islamic', 'custom'
|     |     recurrence: string?            // 'none', 'daily', 'weekly', 'monthly', 'yearly'
|     |     recurrenceEndDate: timestamp?
|     |     notificationTiers: int[]       // [30, 14, 7, 3, 1, 0] days before
|     |     linkedOccasion: string?
|     |     isActive: boolean
|     |     createdAt: timestamp
|     |     updatedAt: timestamp
|     |
|     +-- promises/{pid}
|     |     title: string
|     |     description: string?
|     |     targetDate: timestamp
|     |     priority: string               // 'low', 'medium', 'high'
|     |     status: string                 // 'open', 'in_progress', 'completed', 'overdue'
|     |     completedAt: timestamp?
|     |     createdAt: timestamp
|     |
|     +-- messages/{mid}
|     |     content: string
|     |     mode: string                   // 'good_morning', 'appreciation', etc.
|     |     tone: string                   // 'formal', 'warm', 'casual', 'playful'
|     |     length: string                 // 'short', 'medium', 'long'
|     |     language: string               // 'en', 'ar', 'ms'
|     |     modelUsed: string
|     |     isFavorite: boolean
|     |     rating: int?                   // 1 (down) or 5 (up)
|     |     createdAt: timestamp
|     |
|     +-- action_cards/{cid}
|     |     type: string                   // 'say', 'do', 'buy', 'go'
|     |     content: string
|     |     suggestion: string
|     |     estimatedCost: string?
|     |     estimatedTime: string?
|     |     xpReward: int
|     |     status: string                 // 'pending', 'completed', 'skipped'
|     |     skipReason: string?
|     |     completedAt: timestamp?
|     |     date: timestamp                // The day this card was generated for
|     |     createdAt: timestamp
|     |
|     +-- memories/{mid}
|     |     title: string (encrypted)
|     |     description: string (encrypted)
|     |     date: timestamp
|     |     photoUrls: string[]
|     |     tags: string[]
|     |     encryptionKeyRef: string       // Reference to user's encryption key
|     |     createdAt: timestamp
|     |
|     +-- wishlist/{wid}
|     |     description: string
|     |     approximatePrice: double?
|     |     dateMentioned: timestamp
|     |     priority: string               // 'nice_to_have', 'really_wants'
|     |     occasionLink: string?          // Linked reminder ID
|     |     isPurchased: boolean
|     |     createdAt: timestamp
|     |
|     +-- gamification (document)
|     |     totalXp: int
|     |     currentLevel: int              // 1-10
|     |     levelName: string              // 'Beginner', 'Learner', ..., 'Soulmate'
|     |     currentStreak: int
|     |     longestStreak: int
|     |     lastActiveDate: timestamp
|     |     streakFreezeAvailable: boolean
|     |     streakFreezeUsedThisMonth: boolean
|     |     consistencyScore: int          // 0-100
|     |     weeklyScoreChange: int         // +/- from last week
|     |     percentile: int                // 0-100, updated weekly
|     |     dailyXpEarned: int             // Reset daily, cap at 100
|     |     updatedAt: timestamp
|     |
|     +-- gift_history/{ghid}
|           occasion: string
|           giftName: string
|           priceRange: string
|           feedback: string?              // 'loved', 'liked', 'neutral', 'disliked'
|           feedbackDate: timestamp?
|           createdAt: timestamp
|
+-- zodiac_profiles/{sign}                 # Static reference collection
|     traits: string[]
|     communicationPrefs: map
|     emotionalTendencies: map
|     giftPreferences: map
|     loveStyle: map
|
+-- islamic_holidays/{year}                # Reference collection, updated yearly
|     holidays: array of map {
|       name: string
|       nameAr: string
|       nameMs: string
|       hijriDate: string
|       gregorianDate: timestamp
|       reminderStartDays: int
|     }
|
+-- app_config/v1                          # Global app configuration
      minAppVersion: string
      maintenanceMode: boolean
      featureFlags: map
      aiModelConfig: map {
        defaultMessageModel: string
        defaultGiftModel: string
        defaultSosModel: string
      }
```

### 6.2 Local Storage Schema (Hive Boxes)

```
# User session (encrypted box)
Box: 'user_session'
  - authToken: String
  - refreshToken: String
  - uid: String
  - languageCode: String
  - subscriptionTier: String
  - onboardingComplete: bool

# Partner profile cache
Box: 'partner_profile'
  - Stores PartnerProfileModel (TypeAdapter)
  - Single entry, replaced on sync

# Family members cache
Box: 'family_members'
  - Key: family member ID
  - Value: FamilyMemberModel (TypeAdapter)

# Reminders cache
Box: 'reminders'
  - Key: reminder ID
  - Value: ReminderModel (TypeAdapter)
  - Synced on app open, push, and pull-to-refresh

# Promises cache
Box: 'promises'
  - Key: promise ID
  - Value: PromiseModel (TypeAdapter)

# Message history cache
Box: 'message_history'
  - Key: message ID
  - Value: GeneratedMessageModel (TypeAdapter)
  - Stores last 50 messages locally

# Action cards cache
Box: 'action_cards'
  - Key: date string (yyyy-MM-dd)
  - Value: List<ActionCardModel>
  - Today's cards cached for offline access

# Memory vault (encrypted box)
Box: 'memory_vault' (encrypted with user-specific key)
  - Key: memory ID
  - Value: MemoryModel (TypeAdapter, content encrypted)

# Wishlist cache
Box: 'wishlist'
  - Key: wishlist item ID
  - Value: WishListItemModel (TypeAdapter)

# Gamification cache
Box: 'gamification'
  - Single entry: GamificationModel (TypeAdapter)
  - Updated on every XP event and daily refresh

# Settings
Box: 'settings'
  - theme: String ('dark'/'light')
  - language: String ('en'/'ar'/'ms')
  - notificationsEnabled: bool
  - quietHoursStart: String
  - quietHoursEnd: String
  - biometricEnabled: bool

# SOS offline cache
Box: 'sos_cache'
  - Key: '{language}_{scenario}'
  - Value: SosResponseModel (pre-cached tips)
  - Refreshed weekly on app open
```

### 6.3 Relationship Memory Vault Encryption Approach

Memory Vault data is encrypted at rest using a layered approach:

```
User creates memory
    |
    v
Content encrypted with AES-256-GCM
    |
    Key: User-specific encryption key (derived from user password + uid salt)
    |
    Key stored in: flutter_secure_storage (Keychain on iOS, EncryptedSharedPreferences on Android)
    |
    v
Encrypted content stored in:
    - Local: Hive encrypted box (double encryption: box-level + content-level)
    - Remote: Firestore (encrypted blob, server cannot read plaintext)
    |
    v
Decryption only possible with:
    - User's device (key in secure storage)
    - Biometric unlock OR app password to access secure storage
```

**Key Management:**
- Encryption key generated on first memory creation
- Key derived using PBKDF2 (100,000 iterations) from user credential + uid
- Key stored exclusively in `flutter_secure_storage` (never transmitted)
- If user changes password: re-derive key, re-encrypt all memories (background task)
- If user loses device: key recovery via re-authentication + PBKDF2 re-derivation

### 6.4 Offline-First Sync Strategy

```
App Startup
    |
    v
1. Load all data from Hive local cache (instant UI)
    |
    v
2. Check network connectivity
    |
    +--> Offline: Display cached data with "Last updated X ago" badge
    |
    +--> Online:
          |
          v
3. Sync Strategy per data type:

   a) User Profile / Settings:
      - Pull from Firestore on app open
      - Push on every save (immediate)
      - Conflict: server wins (last write)

   b) Reminders / Promises:
      - Pull: Firestore listener (real-time)
      - Push: immediate on create/update/delete
      - Conflict: merge (timestamp-based, most recent wins)

   c) Messages / Action Cards:
      - Pull: on-demand (when screen opens) + daily refresh
      - Push: ratings/favorites pushed immediately
      - Conflict: N/A (read-heavy, server is source of truth)

   d) Memory Vault / Wishlist:
      - Pull: on app open (differential sync using updatedAt)
      - Push: immediate on create/update
      - Conflict: merge (keep both versions, user resolves)
      - Offline creates queued and pushed when online

   e) Gamification:
      - Pull: Firestore real-time listener
      - Push: XP events queued locally, batched push when online
      - Conflict: server recalculates from event log

4. Offline Queue:
   - All write operations queued in Hive 'sync_queue' box
   - Queue processed FIFO when connectivity restored
   - Failed items retried 3 times with exponential backoff
   - After 3 failures: logged to analytics, user notified
```

---

## Section 7: Authentication & Security

### 7.1 Firebase Auth Flow

```
+------------------+     +------------------+     +------------------+
|   Welcome Screen |     | Firebase Auth    |     | Cloud Function   |
|                  |     |                  |     |                  |
| [Sign in Google] +---->+ signInWithGoogle +---->+ onUserCreate     |
| [Sign in Apple]  |     | signInWithApple  |     | (trigger)        |
| [Email/Password] |     | createUserEmail  |     |                  |
+--------+---------+     +--------+---------+     +--------+---------+
         |                        |                        |
         |                        v                        v
         |               Firebase ID Token          Create Firestore
         |               (JWT, 1-hour expiry)       user document
         |                        |                 Initialize defaults
         |                        v                 Set free tier
         |               Store token in             Send welcome email
         |               flutter_secure_storage            |
         |                        |                        |
         v                        v                        v
+------------------+     +------------------+     +------------------+
| Onboarding       |     | API Requests     |     | Firestore Rules  |
| (if first login) |     | Auth header:     |     | Enforce uid      |
|                  |     | Bearer {token}   |     | ownership on all |
+------------------+     +------------------+     | reads/writes     |
                                                  +------------------+
```

**Auth Provider Support:**
- **Email/Password:** Firebase createUserWithEmailAndPassword, bcrypt hashing server-side
- **Google Sign-In:** google_sign_in package -> Firebase signInWithCredential
- **Apple Sign-In:** sign_in_with_apple package -> Firebase signInWithCredential
- **Duplicate Detection:** Cloud Function checks email across providers; links accounts if same email

**Token Refresh:**
- Firebase ID tokens expire after 1 hour
- Dio interceptor detects 401 responses
- Automatic refresh via Firebase Auth SDK `currentUser.getIdToken(forceRefresh: true)`
- If refresh fails: redirect to login screen

### 7.2 Biometric Lock for Memory Vault

```dart
// Biometric authentication flow
class BiometricService {
  final LocalAuthentication _localAuth;

  Future<bool> authenticateForVault() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();

    if (!canCheck || !isDeviceSupported) return false;

    return await _localAuth.authenticate(
      localizedReason: _getLocalizedReason(), // Per-locale biometric prompt
      options: const AuthenticationOptions(
        stickyAuth: true,       // Keep auth session if app goes to background
        biometricOnly: false,   // Allow PIN/pattern as fallback
      ),
    );
  }
}
```

**Biometric Scope:**
- App launch lock (optional, configured in settings)
- Memory Vault access (required if enabled)
- Subscription management (required for changes)
- Data export (required)

### 7.3 Data Encryption

| Layer | Method | Details |
|-------|--------|---------|
| **In Transit** | TLS 1.3 | All HTTP traffic via Dio uses HTTPS. Certificate pinning for API endpoints. |
| **At Rest (Device)** | AES-256 | Hive encrypted boxes for sensitive data (memories, auth tokens). flutter_secure_storage uses Keychain (iOS) / EncryptedSharedPreferences (Android). |
| **At Rest (Server)** | Firestore encryption | Google-managed encryption at rest. Memory Vault content additionally encrypted with user-specific AES-256-GCM key before storage. |
| **Auth Tokens** | flutter_secure_storage | Tokens never stored in SharedPreferences or plain Hive. |
| **API Keys** | Environment variables | AI provider keys stored in Cloud Functions env, never in client code. Client uses Firebase Auth tokens to authenticate with Cloud Functions. |

### 7.4 API Key Management

```
CLIENT (Flutter)                    SERVER (Cloud Functions)
+-------------------+              +----------------------------+
| No AI API keys    |   Firebase   | AI API keys in env vars:   |
| No secret keys    +---tokens---->+ ANTHROPIC_API_KEY          |
| Only Firebase     |              | XAI_API_KEY                |
| project config    |              | GOOGLE_AI_API_KEY          |
+-------------------+              | OPENAI_API_KEY             |
                                   | PINECONE_API_KEY           |
                                   | REVENUECAT_API_KEY         |
                                   +----------------------------+
                                   | Accessed via:               |
                                   | functions.config()          |
                                   | or Secret Manager           |
                                   +----------------------------+
```

**Rules:**
- Client NEVER contains any AI provider API keys
- Client authenticates with Firebase Auth (ID token)
- Cloud Functions validate ID token, then use server-side API keys
- API keys rotated quarterly via Google Secret Manager
- Separate keys for dev/staging/production environments

### 7.5 User Data Privacy (GDPR / PDPA Compliance)

| Requirement | Implementation |
|------------|----------------|
| **Right to Access** | Data export feature (Settings > Export Data). Generates JSON/CSV of all user data. |
| **Right to Deletion** | Account deletion in Settings. Triggers Cloud Function that: deletes Firestore docs, deletes Firebase Auth account, purges Redis cache, logs deletion event. 30-day grace period with recovery option. |
| **Data Minimization** | All profile fields optional except name. Minimal data collected during onboarding. |
| **Consent** | Privacy policy acceptance during onboarding. Granular notification consent. Analytics opt-out toggle. |
| **Data Portability** | Export as JSON (machine-readable) or PDF (human-readable). |
| **Breach Notification** | Firebase Security Rules prevent unauthorized access. Cloud Function monitoring for anomalous access patterns. Incident response plan with 72-hour notification commitment. |
| **PDPA (Malaysia)** | Bahasa Melayu privacy policy. Data processing notice in onboarding. Cross-border data transfer disclosure (Firebase servers). |
| **Children** | Age verification (13+ / 18+ depending on jurisdiction) during onboarding. No account creation for minors. |

---

## Section 8: Third-Party Integrations

### 8.1 Calendar Sync (Google Calendar API, Apple EventKit)

```
+-------------------+        +-------------------+        +-------------------+
| Google Calendar   |        | LOLO Reminders    |        | Apple Calendar    |
| API v3            |<------>| Engine            |<------>| EventKit          |
+-------------------+        +-------------------+        +-------------------+
       |                            |                            |
       | OAuth 2.0                  | Bidirectional              | Native iOS
       | Scopes:                    | Sync:                      | permission
       | calendar.readonly          |                            |
       | calendar.events            | Import: birthdays,         |
       |                            |   anniversaries from       |
       |                            |   device calendar          |
       |                            |                            |
       |                            | Export: LOLO reminders     |
       |                            |   as calendar events       |
       |                            |   (with discreet titles)   |
       +----------------------------+----------------------------+
```

**Implementation:**
- Package: `device_calendar` (cross-platform) or platform-specific (googleapis + EventKit)
- Import: Scan for events with keywords ("birthday", "anniversary") in title
- Export: Create events with discreet titles ("LOLO Reminder" not "Jessica's Birthday Gift Deadline")
- Sync frequency: On app open + manual pull-to-refresh
- Permissions: Requested during onboarding (optional), can be enabled later in Settings

### 8.2 Payment (RevenueCat)

```
+-------------------+        +-------------------+        +-------------------+
| Flutter Client    |        | RevenueCat SDK    |        | App Stores        |
|                   |        |                   |        |                   |
| purchases         +------->+ Offerings         +------->+ Google Play       |
| package           |        | Entitlements      |        | Billing v6        |
|                   |        | Subscriber info   |        |                   |
|                   |        |                   |        | Apple StoreKit 2  |
+-------------------+        +---+---------------+        +-------------------+
                                 |
                                 | Webhooks
                                 v
                          +-------------------+
                          | Cloud Function    |
                          | /webhooks/revenue |
                          |                   |
                          | Updates Firestore |
                          | subscriptionTier  |
                          | Logs MRR event    |
                          +-------------------+
```

**RevenueCat Configuration:**
- Products: `lolo_pro_monthly`, `lolo_pro_annual`, `lolo_legend_monthly`, `lolo_legend_annual`
- Offerings: Default (standard pricing), Malaysia (regional pricing)
- Entitlements: `pro_access`, `legend_access`
- Introductory offers: 7-day free trial for Pro
- Webhook: Notifies Cloud Function on subscription changes (new, renewal, cancellation, billing issue)

### 8.3 Push Notifications (FCM + APNs)

```
+-------------------+        +-------------------+        +-------------------+
| Notification      |        | Firebase Cloud    |        | Device            |
| Scheduler         |        | Messaging (FCM)   |        |                   |
| (Cloud Function)  +------->+                   +------->+ Android: FCM      |
|                   |        | Topic: reminders  |        | iOS: APNs via FCM |
| Scheduled jobs:   |        | Topic: streaks    |        |                   |
| - Daily card push |        | Topic: system     |        | Local notifs for  |
| - Reminder tiers  |        |                   |        | offline reminders |
| - Streak alerts   |        +-------------------+        +-------------------+
| - Weekly summary  |
+-------------------+
```

**Notification Privacy:**
- Title: "LOLO" (always, never varies)
- Body: Never contains partner name or relationship content on lock screen
- Content available after unlock only
- Quiet hours respected (default 10 PM - 7 AM, configurable)
- Category toggles: Reminders, Action Cards, Streak Alerts, System Updates
- Maximum 3 per day (configurable)

### 8.4 E-Commerce Affiliate APIs

| Market | Affiliate Program | API/Integration | Revenue Share |
|--------|------------------|-----------------|---------------|
| English (US/UK) | Amazon Associates | Product Advertising API 5.0 | 1-10% depending on category |
| Arabic (GCC) | Noon.com Partners | Noon Affiliate API | 3-8% |
| Malay (MY) | Shopee Affiliate | Shopee Open Platform API | 2-6% |
| Malay (MY) | Lazada Affiliate | Lazada Open Platform API | 2-5% |
| All markets | Generic fallback | Custom link with UTM tracking | Varies |

**Integration Approach:**
- Gift Engine AI includes affiliate product matching
- Cloud Function resolves affiliate links per user locale
- Click tracking via UTM parameters + analytics events
- Conversion tracking via affiliate program webhooks (where available)

### 8.5 WhatsApp Business API

**Phase 1 (MVP):** Share-to-WhatsApp via deep links only
```dart
// Share generated message to WhatsApp
final url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
launchUrl(Uri.parse(url));
```

**Phase 2 (Post-MVP):** WhatsApp Business API for automated reminders
- Opt-in message delivery for reminder notifications
- Template messages for Eid greetings, birthday reminders
- Requires WhatsApp Business account verification

---

## Section 9: Performance Targets

### 9.1 Performance Budgets

| Metric | Target | Measurement | Tooling |
|--------|--------|-------------|---------|
| **App Startup (cold)** | < 2s | Time from tap to interactive home screen | Firebase Performance Monitoring |
| **App Startup (warm)** | < 500ms | Time from background resume to interactive | Firebase Performance Monitoring |
| **Frame Rate** | 60fps sustained | No jank during scrolling, navigation, animations | Flutter DevTools, Impeller |
| **APK Size (Android)** | < 50MB | Download size on Play Store | `flutter build appbundle --analyze-size` |
| **IPA Size (iOS)** | < 60MB | Download size on App Store | Xcode size report |
| **Memory Usage** | < 150MB | Peak RSS during normal usage | Flutter DevTools memory profiler |
| **API Response (p50)** | < 1s | Cloud Function response time (non-AI) | Firebase Performance, custom traces |
| **API Response (p95)** | < 3s | Cloud Function response time (including AI) | Firebase Performance, custom traces |
| **AI Message Generation** | < 5s | Time from tap to message displayed | Custom performance trace |
| **SOS Mode Launch** | < 1s | Time from SOS tap to scenario screen | Custom performance trace |
| **SOS Coaching Response** | < 3s | Time from scenario select to first coaching step | Custom performance trace |
| **Offline Load** | < 500ms | Time to display cached data when offline | Local measurement |
| **Battery Impact** | < 3%/hour | Battery consumption during active use | Platform battery profiling |

### 9.2 Impeller Rendering Engine

LOLO uses Flutter's Impeller rendering engine (default on iOS, opt-in on Android) for:
- Consistent 60fps rendering without shader compilation jank
- Smoother animations for card transitions, level-up celebrations, SOS pulse
- Better performance on mid-range Android devices (Hafiz's Samsung Galaxy A55)

### 9.3 Offline Capability Requirements

| Feature | Offline Capability | Data Source |
|---------|-------------------|-------------|
| Home Dashboard | Full (cached data) | Hive: gamification, action cards, reminders |
| Action Cards (view) | Full (today's cached cards) | Hive: action_cards box |
| Action Cards (generate new) | None (requires AI) | -- |
| Message History | Full (cached history) | Hive: message_history box |
| Message Generation | None (requires AI) | -- |
| Her Profile (view/edit) | Full (local cache, syncs when online) | Hive: partner_profile box |
| Reminders (view) | Full | Hive: reminders box |
| Reminders (create) | Queued (syncs when online) | Hive: sync_queue box |
| Memory Vault | Full (encrypted local) | Hive: memory_vault box |
| SOS Mode | Partial (cached tips per scenario) | Hive: sos_cache box |
| Gamification (view) | Full (cached stats) | Hive: gamification box |
| Gift Engine | None (requires AI) | -- |
| Subscription | Full (cached tier info) | Hive: user_session box |

### 9.4 Image and Asset Optimization

- All raster images in WebP format (30-50% smaller than PNG)
- SVG for icons (scales without quality loss, smaller file size)
- Lottie for animations (JSON-based, dramatically smaller than video/GIF)
- Arabic fonts: subset only used glyphs to reduce bundle size
- Lazy loading for images in lists (cached_network_image)
- Maximum image upload size: 5MB (compressed before upload)

---

## Section 10: Testing Strategy Overview

### 10.1 Unit Test Targets

**Coverage Target: >80% for core logic (domain + data layers)**

| Layer | Coverage Target | Focus Areas |
|-------|----------------|-------------|
| Domain (Entities) | 95% | Immutability, equality, serialization |
| Domain (Use Cases) | 90% | Business logic, edge cases, error handling |
| Data (Repositories) | 85% | Offline/online branching, sync logic, error mapping |
| Data (Data Sources) | 80% | API call construction, response parsing, cache behavior |
| Core (Utils) | 90% | Validators, formatters, date utils, encryption |

**Testing Approach:**
- Use `mocktail` for mocking (simpler than mockito, no code generation)
- Use `freezed` entities for predictable test data
- Use `Either<Failure, T>` pattern for testable error handling
- Golden file tests for JSON serialization/deserialization

### 10.2 Widget Tests

**Every screen has a corresponding widget test that verifies:**
- Correct widgets render for each state (loading, loaded, error, empty)
- User interactions trigger correct provider methods
- Navigation occurs correctly
- RTL layout renders correctly (separate test variants for Arabic)
- Accessibility labels are present

```dart
// Example widget test pattern
testWidgets('HomeScreen shows action card when loaded', (tester) async {
  // Arrange: override provider with mock state
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        homeProvider.overrideWith(() => MockHomeNotifier(loadedState)),
      ],
      child: const MaterialApp(home: HomeScreen()),
    ),
  );

  // Assert: card widget is displayed
  expect(find.byType(DashboardActionCard), findsOneWidget);
  expect(find.text('SAY'), findsOneWidget);
});
```

### 10.3 Integration Tests

**Critical flows tested end-to-end:**

| Test | Screens Covered | Key Assertions |
|------|----------------|----------------|
| Auth Flow | Welcome -> Login -> Home | User can sign in, token stored, redirected to home |
| Onboarding Flow | 5 onboarding screens -> Home | All steps save, first card displayed, profile created |
| Message Generation | Messages -> Generate -> Result | Mode selection, tone/length controls, message displayed, copy works |
| Action Card Flow | Home -> Card Detail -> Complete | Card displays, complete button works, XP awarded |
| SOS Mode | Any screen -> SOS -> Scenario -> Coaching | 2-tap access, scenario selection, coaching steps render < 3s |
| Subscription | Paywall -> Purchase -> Feature Access | Paywall displays at limit, purchase completes, feature unlocks |
| RTL Layout | Full app flow in Arabic | All screens render correctly in RTL, no layout overflow |

### 10.4 Golden Tests for UI Consistency

Golden tests capture pixel-perfect screenshots of widgets and compare against reference images:

```dart
testWidgets('ActionCard golden test - SAY type', (tester) async {
  await tester.pumpWidget(
    testableWidget(
      child: ActionCardWidget(
        card: testSayCard,
        locale: const Locale('en'),
      ),
    ),
  );
  await expectLater(
    find.byType(ActionCardWidget),
    matchesGoldenFile('golden/action_card_say_en.png'),
  );
});

testWidgets('ActionCard golden test - SAY type (Arabic RTL)', (tester) async {
  await tester.pumpWidget(
    testableWidget(
      locale: const Locale('ar'),
      textDirection: TextDirection.rtl,
      child: ActionCardWidget(
        card: testSayCardArabic,
        locale: const Locale('ar'),
      ),
    ),
  );
  await expectLater(
    find.byType(ActionCardWidget),
    matchesGoldenFile('golden/action_card_say_ar.png'),
  );
});
```

**Golden test coverage:**
- Every card type (SAY/DO/BUY/GO) x 3 languages
- Home dashboard x 3 languages
- Bottom navigation x 2 directions (LTR, RTL)
- Paywall screen x 3 languages (with regional pricing)
- SOS scenario buttons x 3 languages
- All empty states x 3 languages

### 10.5 RTL-Specific Test Approach

| Test Type | What We Verify | Tool |
|-----------|---------------|------|
| Layout Direction | All widgets respect `Directionality.of(context)` | Widget tests with RTL override |
| EdgeInsets | `EdgeInsetsDirectional` used instead of `EdgeInsets` | Lint rule + code review |
| Icons | Directional icons (arrows, back, forward) mirror correctly | Golden tests |
| Text Alignment | `TextAlign.start`/`.end` used instead of `.left`/`.right` | Lint rule |
| Navigation | Tab order mirrors in RTL, back button on correct side | Integration tests |
| Numbers | Arabic-Indic numerals display when Arabic locale active | Widget tests |
| Scrolling | Horizontal scroll direction mirrors in RTL | Integration tests |
| Calendar | Hijri calendar displays correctly alongside Gregorian | Widget tests |
| Input Fields | Cursor starts on right side for Arabic input | Manual testing checklist |

### 10.6 Test Infrastructure

```
test/
  helpers/
    test_helpers.dart              # Common test setup utilities
    mock_providers.dart            # Pre-configured mock Riverpod providers
    fake_repositories.dart         # In-memory fake repository implementations
    test_data_factory.dart         # Factory methods for test entities
    golden_test_helpers.dart       # Golden test wrapper with locale support
  fixtures/
    user_response.json
    partner_profile_response.json
    generated_message_response.json
    action_cards_response.json
    gift_recommendations_response.json
    sos_coaching_response.json
    gamification_response.json
```

**CI Test Pipeline (GitHub Actions):**
```yaml
# Runs on every PR and push to main
- flutter analyze (lint)
- flutter test --coverage (unit + widget tests)
- flutter test --coverage --tags=golden (golden tests, Linux runner for consistency)
- lcov coverage report (fail if core coverage < 80%)
- flutter drive --driver=test_driver/integration_test.dart (integration tests on emulator)
```

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | February 14, 2026 | Omar Al-Rashidi, Tech Lead | Initial architecture document |

---

*Omar Al-Rashidi, Tech Lead & Senior Flutter Developer*
*LOLO -- "She won't know why you got so thoughtful. We won't tell."*

---

### References

- LOLO Feature Backlog MoSCoW (Sarah Chen, February 2026)
- LOLO User Personas & Journey Maps (Sarah Chen, February 2026)
- LOLO Competitive Analysis Report (Sarah Chen, February 2026)
- LOLO Emotional State Framework (Dr. Elena Vasquez, February 2026)
- LOLO Zodiac Master Profiles (Maya Starling, February 2026)
- Flutter Clean Architecture (Reso Coder, adapted)
- Riverpod 2.x Documentation (riverpod.dev)
- GoRouter Documentation (pub.dev/packages/go_router)
- Firebase Flutter Documentation (firebase.flutter.dev)
- RevenueCat Flutter SDK Documentation (revenuecat.com/docs)
