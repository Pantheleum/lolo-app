# LOLO Flutter Project Scaffold & Clean Architecture Setup

**Task ID:** S1-01
**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 1 -- Foundation (Weeks 9-10)
**Dependencies:** Architecture Document v1.0, API Contracts v1.0, Flutter Feasibility Review v1.0, Design System v1.0, Developer Handoff v1.0, Localization Architecture v1.0

---

## Table of Contents

1. [Project Initialization Commands](#1-project-initialization-commands)
2. [Complete Folder Structure](#2-complete-folder-structure)
3. [Core Infrastructure Code](#3-core-infrastructure-code)
4. [Base Feature Module Template (Onboarding)](#4-base-feature-module-template)
5. [Shared Widget Stubs](#5-shared-widget-stubs)
6. [Complete pubspec.yaml](#6-complete-pubspecyaml)

---

## 1. Project Initialization Commands

### 1.1 Flutter Create

```bash
flutter create \
  --org com.loloapp \
  --project-name lolo \
  --description "LOLO - Your Secret Relationship Wingman" \
  --platforms android,ios \
  --template app \
  lolo
```

### 1.2 Post-Create Setup

```bash
cd lolo

# Enable code generation
dart pub global activate build_runner

# Generate l10n
flutter gen-l10n

# Run build_runner for freezed, riverpod_generator, json_serializable
dart run build_runner build --delete-conflicting-outputs

# Verify project compiles
flutter analyze
flutter test
```

### 1.3 analysis_options.yaml

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    invalid_annotation_target: ignore
    missing_required_param: error
    missing_return: error
    todo: ignore
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.gen.dart"
    - "lib/generated/**"
    - "lib/l10n/**"
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  plugins:
    - custom_lint

linter:
  rules:
    # === Error Prevention ===
    - always_use_package_imports
    - avoid_dynamic_calls
    - avoid_print
    - avoid_relative_lib_imports
    - avoid_slow_async_io
    - avoid_type_to_string
    - cancel_subscriptions
    - close_sinks
    - discarded_futures
    - literal_only_boolean_expressions
    - no_adjacent_strings_in_list
    - test_types_in_equals
    - throw_in_finally
    - unnecessary_statements
    - unsafe_html

    # === Style ===
    - always_declare_return_types
    - always_put_required_named_parameters_first
    - annotate_overrides
    - avoid_annotating_with_dynamic
    - avoid_bool_literals_in_conditional_expressions
    - avoid_catches_without_on_clauses
    - avoid_catching_errors
    - avoid_classes_with_only_static_members
    - avoid_double_and_int_checks
    - avoid_equals_and_hash_code_on_mutable_classes
    - avoid_escaping_inner_quotes
    - avoid_field_initializers_in_const_classes
    - avoid_final_parameters
    - avoid_implementing_value_types
    - avoid_multiple_declarations_per_line
    - avoid_positional_boolean_parameters
    - avoid_private_typedef_functions
    - avoid_redundant_argument_values
    - avoid_returning_null_for_void
    - avoid_returning_this
    - avoid_setters_without_getters
    - avoid_types_on_closure_parameters
    - avoid_unnecessary_containers
    - avoid_unused_constructor_parameters
    - avoid_void_async
    - cascade_invocations
    - cast_nullable_to_non_nullable
    - combinators_ordering
    - conditional_uri_does_not_exist
    - deprecated_consistency
    - directives_ordering
    - eol_at_end_of_file
    - join_return_with_assignment
    - leading_newlines_in_multiline_strings
    - missing_whitespace_between_adjacent_strings
    - no_default_cases
    - no_runtimeType_toString
    - noop_primitive_operations
    - omit_local_variable_types
    - one_member_abstracts
    - only_throw_errors
    - parameter_assignments
    - prefer_asserts_in_initializer_lists
    - prefer_asserts_with_message
    - prefer_constructors_over_static_methods
    - prefer_expression_function_bodies
    - prefer_final_in_for_each
    - prefer_final_locals
    - prefer_if_elements_to_conditional_expressions
    - prefer_int_literals
    - prefer_mixin
    - prefer_null_aware_method_calls
    - prefer_single_quotes
    - require_trailing_commas
    - sized_box_for_whitespace
    - sort_child_properties_last
    - sort_constructors_first
    - sort_unnamed_constructors_first
    - type_annotate_public_apis
    - unawaited_futures
    - unnecessary_await_in_return
    - unnecessary_breaks
    - unnecessary_lambdas
    - unnecessary_null_aware_assignments
    - unnecessary_null_checks
    - unnecessary_parenthesis
    - unnecessary_raw_strings
    - unnecessary_to_list_in_spreads
    - unreachable_from_main
    - use_colored_box
    - use_decorated_box
    - use_enums
    - use_if_null_to_convert_nulls
    - use_is_even_rather_than_modulo
    - use_late_for_private_fields_and_variables
    - use_named_constants
    - use_raw_strings
    - use_setters_to_change_properties
    - use_string_buffers
    - use_super_parameters
    - use_to_and_as_if_applicable

    # === RTL Enforcement (custom lint rules via custom_lint) ===
    # Enforced via custom_lint package configuration:
    # - Disallow EdgeInsets (force EdgeInsetsDirectional)
    # - Disallow Alignment (force AlignmentDirectional)
    # - Disallow TextAlign.left/right (force TextAlign.start/end)
    # - Warn on hardcoded Offset with non-zero x values
```

### 1.4 l10n.yaml

```yaml
# l10n.yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/generated/l10n
synthetic-package: false
nullable-getter: false
preferred-supported-locales:
  - en
  - ar
  - ms
```

---

## 2. Complete Folder Structure

```
lolo/
  lib/
    main.dart
    app.dart
    bootstrap.dart

    # ================================================================
    # CORE: Shared utilities, configs, cross-cutting concerns
    # ================================================================
    core/
      constants/
        app_constants.dart
        api_endpoints.dart
        asset_paths.dart
        hive_box_names.dart
        firestore_collections.dart

      enums/
        language_enum.dart
        subscription_tier_enum.dart
        relationship_status_enum.dart
        cultural_background_enum.dart
        religious_observance_enum.dart
        action_card_type_enum.dart
        message_mode_enum.dart
        crisis_scenario_enum.dart
        emotional_state_enum.dart

      errors/
        failures.dart
        exceptions.dart
        error_handler.dart

      extensions/
        context_extensions.dart
        string_extensions.dart
        date_extensions.dart
        num_extensions.dart

      network/
        dio_client.dart
        api_interceptor.dart
        error_interceptor.dart
        cache_interceptor.dart
        network_info.dart
        api_response.dart
        network_exceptions.dart

      router/
        app_router.dart
        route_names.dart
        route_guards.dart

      theme/
        lolo_theme.dart
        lolo_colors.dart
        lolo_typography.dart
        lolo_gradients.dart
        lolo_spacing.dart
        lolo_shadows.dart
        typography/
          arabic_typography.dart
          latin_typography.dart

      localization/
        locale_provider.dart
        hijri_calendar.dart
        locale_aware_formatters.dart
        cultural_context.dart

      storage/
        local_storage_service.dart
        secure_storage_service.dart
        hive_setup.dart
        isar_setup.dart

      services/
        encryption_service.dart
        biometric_service.dart
        notification_service.dart
        analytics_service.dart
        connectivity_service.dart
        calendar_service.dart
        share_service.dart

      di/
        providers.dart
        provider_logger.dart

      utils/
        validators.dart
        debouncer.dart
        throttler.dart
        result.dart
        date_utils.dart
        text_direction_utils.dart

      widgets/
        lolo_bottom_nav.dart
        lolo_app_bar.dart
        lolo_primary_button.dart
        lolo_text_field.dart
        lolo_toast.dart
        lolo_skeleton.dart
        lolo_empty_state.dart
        lolo_chip_group.dart
        lolo_dialog.dart
        lolo_progress_bar.dart
        lolo_streak_display.dart
        lolo_avatar.dart
        lolo_badge.dart
        stat_card.dart
        action_card.dart
        reminder_tile.dart
        memory_card.dart
        gift_card.dart
        badge_card.dart
        sos_coaching_card.dart
        lolo_error_widget.dart
        lolo_loading_widget.dart
        lolo_shimmer_wrapper.dart
        paginated_list_view.dart

    # ================================================================
    # FEATURES: Each module is self-contained with Clean Architecture
    # ================================================================
    features/

      # ------ Module 1: Auth ------
      auth/
        data/
          datasources/
            auth_remote_datasource.dart
            auth_local_datasource.dart
          models/
            user_model.dart
          repositories/
            auth_repository_impl.dart
        domain/
          entities/
            user_entity.dart
          repositories/
            auth_repository.dart
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

      # ------ Module 2: Onboarding ------
      onboarding/
        data/
          datasources/
            onboarding_remote_datasource.dart
            onboarding_local_datasource.dart
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
            onboarding_screen.dart
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

      # ------ Module 3: Her Profile Engine ------
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
            partner_profile_entity.dart
            family_member_entity.dart
            zodiac_profile_entity.dart
            cultural_context_entity.dart
            partner_preferences_entity.dart
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

      # ------ Module 4: Smart Reminders ------
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
            reminder_entity.dart
            promise_entity.dart
            islamic_holiday_entity.dart
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

      # ------ Module 5: AI Message Generator ------
      ai_messages/
        data/
          datasources/
            message_remote_datasource.dart
            message_local_datasource.dart
          models/
            generated_message_model.dart
            message_request_model.dart
            message_feedback_model.dart
          repositories/
            message_repository_impl.dart
        domain/
          entities/
            generated_message_entity.dart
            message_request_entity.dart
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
            messages_screen.dart
            generate_message_screen.dart
            message_history_screen.dart
            message_detail_screen.dart
          widgets/
            message_mode_card.dart
            tone_slider_widget.dart
            length_selector_widget.dart
            message_result_card.dart
            copy_share_bar.dart
            message_feedback_widget.dart

      # ------ Module 6: Smart Action Cards ------
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
            action_card_entity.dart
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
            action_card_widget.dart
            say_card_content.dart
            do_card_content.dart
            buy_card_content.dart
            go_card_content.dart
            card_type_badge.dart
            card_completion_button.dart
            card_skip_sheet.dart

      # ------ Module 7: Gift Engine ------
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
            gift_recommendation_entity.dart
            gift_package_entity.dart
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

      # ------ Module 8: SOS Mode ------
      sos_mode/
        data/
          datasources/
            sos_remote_datasource.dart
            sos_local_datasource.dart
          models/
            sos_response_model.dart
            crisis_scenario_model.dart
          repositories/
            sos_repository_impl.dart
        domain/
          entities/
            sos_response_entity.dart
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
            sos_screen.dart
            sos_scenario_screen.dart
            sos_coaching_screen.dart
            sos_follow_up_screen.dart
          widgets/
            crisis_scenario_button.dart
            coaching_step_card.dart
            say_this_widget.dart
            dont_say_this_widget.dart

      # ------ Module 9: Gamification ------
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
            gamification_entity.dart
            streak_entity.dart
            level_entity.dart
            consistency_score_entity.dart
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

      # ------ Module 10: Memory Vault ------
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
            memory_entity.dart
            wish_list_item_entity.dart
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

      # ------ Module 11: Dashboard / Home ------
      dashboard/
        presentation/
          providers/
            home_provider.dart
            home_state.dart
          screens/
            home_screen.dart
            main_shell_screen.dart
          widgets/
            dashboard_action_card.dart
            dashboard_streak_bar.dart
            dashboard_score_widget.dart
            next_reminder_card.dart
            quick_access_row.dart

      # ------ Module 12: Subscription ------
      subscription/
        data/
          datasources/
            subscription_remote_datasource.dart
            subscription_local_datasource.dart
          models/
            subscription_model.dart
            entitlement_model.dart
          repositories/
            subscription_repository_impl.dart
        domain/
          entities/
            subscription_entity.dart
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

      # ------ Module 13: Settings ------
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
      app_en.arb
      app_ar.arb
      app_ms.arb

    # ================================================================
    # GENERATED: Code generation outputs
    # ================================================================
    generated/
      l10n/
        app_localizations.dart
        app_localizations_en.dart
        app_localizations_ar.dart
        app_localizations_ms.dart

  # ================================================================
  # ASSETS
  # ================================================================
  assets/
    images/
      logo/
      onboarding/
      action_cards/
      zodiac/
      gamification/
      empty_states/
    fonts/
      inter/
      cairo/
      noto_naskh_arabic/
      noto_sans/
    animations/
      lottie/
      rive/
    icons/
      custom/

  # ================================================================
  # TEST
  # ================================================================
  test/
    core/
      network/
        dio_client_test.dart
      theme/
        lolo_theme_test.dart
      utils/
        validators_test.dart
    features/
      auth/
        data/
          auth_repository_impl_test.dart
        domain/
          sign_in_with_email_usecase_test.dart
        presentation/
          auth_provider_test.dart
      onboarding/
        data/
          onboarding_repository_impl_test.dart
        domain/
          complete_onboarding_usecase_test.dart
        presentation/
          onboarding_provider_test.dart
    helpers/
      test_helpers.dart
      mock_providers.dart
    fixtures/
      user_fixture.json
      onboarding_fixture.json
    golden/

  integration_test/
    auth_flow_test.dart
    onboarding_flow_test.dart
    rtl_layout_test.dart
```

---

## 3. Core Infrastructure Code

### 3a. App Entry Point

#### `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/bootstrap.dart';
import 'package:lolo/app.dart';
import 'package:lolo/core/di/provider_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait on phones
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for dark theme default
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF161B22),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize all services (Firebase, Hive, Isar, etc.)
  await bootstrap();

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const LoloApp(),
    ),
  );
}
```

#### `lib/bootstrap.dart`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/core/storage/hive_setup.dart';
import 'package:lolo/core/storage/isar_setup.dart';
import 'package:lolo/core/services/notification_service.dart';

/// Initializes all app-level services before the widget tree is built.
///
/// Order matters:
/// 1. Firebase (auth, firestore, messaging depend on it)
/// 2. Hive (local key-value cache for settings, drafts)
/// 3. Isar (structured local DB for memories, reminders)
/// 4. Notifications (FCM + local notification channels)
Future<void> bootstrap() async {
  // 1. Firebase
  await Firebase.initializeApp();

  // 2. Hive (key-value storage)
  await Hive.initFlutter();
  await HiveSetup.init();

  // 3. Isar (local database)
  await IsarSetup.init();

  // 4. Notification channels
  await NotificationService.init();
}
```

#### `lib/app.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/router/app_router.dart';
import 'package:lolo/core/theme/lolo_theme.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LoloApp extends ConsumerWidget {
  const LoloApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'LOLO',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: LoloTheme.light(),
      darkTheme: LoloTheme.dark(),
      themeMode: themeMode,

      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Navigation
      routerConfig: router,
    );
  }
}
```

### 3b. Theme System

#### `lib/core/theme/lolo_colors.dart`

```dart
import 'package:flutter/material.dart';

/// LOLO Design System color tokens.
///
/// Every color used in the app MUST come from this class.
/// No inline hex values anywhere in the codebase.
abstract final class LoloColors {
  // === Brand Colors ===
  static const Color colorPrimary = Color(0xFF4A90D9);
  static const Color colorAccent = Color(0xFFC9A96E);

  // === Semantic Colors ===
  static const Color colorSuccess = Color(0xFF3FB950);
  static const Color colorSuccessLight = Color(0xFF1A7F37);
  static const Color colorWarning = Color(0xFFD29922);
  static const Color colorWarningLight = Color(0xFFBF8700);
  static const Color colorError = Color(0xFFF85149);
  static const Color colorErrorLight = Color(0xFFCF222E);
  static const Color colorInfo = Color(0xFF58A6FF);
  static const Color colorInfoLight = Color(0xFF0969DA);

  // === Dark Mode Palette (Default) ===
  static const Color darkBgPrimary = Color(0xFF0D1117);
  static const Color darkBgSecondary = Color(0xFF161B22);
  static const Color darkBgTertiary = Color(0xFF21262D);
  static const Color darkSurfaceElevated1 = Color(0xFF282E36);
  static const Color darkSurfaceElevated2 = Color(0xFF30363D);
  static const Color darkSurfaceOverlay = Color(0xB30D1117); // 70% opacity
  static const Color darkTextPrimary = Color(0xFFF0F6FC);
  static const Color darkTextSecondary = Color(0xFF8B949E);
  static const Color darkTextTertiary = Color(0xFF484F58);
  static const Color darkTextDisabled = Color(0xFF30363D);
  static const Color darkBorderDefault = Color(0xFF30363D);
  static const Color darkBorderMuted = Color(0xFF21262D);
  static const Color darkBorderAccent = Color(0xFF4A90D9);

  // === Light Mode Palette ===
  static const Color lightBgPrimary = Color(0xFFFFFFFF);
  static const Color lightBgSecondary = Color(0xFFF6F8FA);
  static const Color lightBgTertiary = Color(0xFFEAEEF2);
  static const Color lightSurfaceElevated1 = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated2 = Color(0xFFFFFFFF);
  static const Color lightSurfaceOverlay = Color(0x801F2328); // 50% opacity
  static const Color lightTextPrimary = Color(0xFF1F2328);
  static const Color lightTextSecondary = Color(0xFF656D76);
  static const Color lightTextTertiary = Color(0xFF8C959F);
  static const Color lightTextDisabled = Color(0xFFAFB8C1);
  static const Color lightBorderDefault = Color(0xFFD0D7DE);
  static const Color lightBorderMuted = Color(0xFFEAEEF2);
  static const Color lightBorderAccent = Color(0xFF4A90D9);

  // === Gray Scale ===
  static const Color gray0 = Color(0xFFF0F6FC);
  static const Color gray1 = Color(0xFFC9D1D9);
  static const Color gray2 = Color(0xFFB1BAC4);
  static const Color gray3 = Color(0xFF8B949E);
  static const Color gray4 = Color(0xFF6E7681);
  static const Color gray5 = Color(0xFF484F58);
  static const Color gray6 = Color(0xFF30363D);
  static const Color gray7 = Color(0xFF21262D);
  static const Color gray8 = Color(0xFF161B22);
  static const Color gray9 = Color(0xFF0D1117);

  // === Action Card Type Colors ===
  static const Color cardTypeSay = Color(0xFF4A90D9);
  static const Color cardTypeDo = Color(0xFF3FB950);
  static const Color cardTypeBuy = Color(0xFFC9A96E);
  static const Color cardTypeGo = Color(0xFF8957E5);
}
```

#### `lib/core/theme/lolo_typography.dart`

```dart
import 'package:flutter/material.dart';

/// LOLO type scale with locale-aware font switching.
///
/// English/Malay: Inter family
/// Arabic: Cairo (headings) + Noto Naskh Arabic (body)
abstract final class LoloTypography {
  // === English/Malay Type Scale (Inter) ===
  static const String _latinHeadingFamily = 'Inter';
  static const String _latinBodyFamily = 'Inter';

  // === Arabic Type Scale ===
  static const String _arabicHeadingFamily = 'Cairo';
  static const String _arabicBodyFamily = 'NotoNaskhArabic';

  // ----------------------------------------------------------------
  // English / Malay (Latin) TextTheme
  // ----------------------------------------------------------------

  static TextTheme get latinTextTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
          letterSpacing: -0.02,
        ),
        headlineLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.33,
          letterSpacing: -0.01,
        ),
        headlineMedium: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.40,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.44,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.50,
          letterSpacing: 0.01,
        ),
        titleMedium: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.43,
          letterSpacing: 0.01,
        ),
        bodyLarge: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.50,
          letterSpacing: 0,
        ),
        bodyMedium: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.43,
          letterSpacing: 0.01,
        ),
        bodySmall: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
          letterSpacing: 0.03,
        ),
        labelLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.14,
          letterSpacing: 0.02,
        ),
        labelMedium: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.45,
          letterSpacing: 0.08,
        ),
        labelSmall: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1.40,
          letterSpacing: 0.04,
        ),
      );

  // ----------------------------------------------------------------
  // Arabic TextTheme (+2sp headings, +1sp body per RTL guidelines)
  // ----------------------------------------------------------------

  static TextTheme get arabicTextTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 34, // +2sp
          fontWeight: FontWeight.w700,
          height: 1.40,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 26, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.46,
          letterSpacing: 0,
        ),
        headlineMedium: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 22, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.50,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 20, // +2sp
          fontWeight: FontWeight.w500,
          height: 1.50,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 18, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.56,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w600,
          height: 1.47,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 17, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.65,
          letterSpacing: 0,
        ),
        bodyMedium: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.60,
          letterSpacing: 0,
        ),
        bodySmall: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 13, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.54,
          letterSpacing: 0,
        ),
        labelLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w600,
          height: 1.20,
          letterSpacing: 0,
        ),
        labelMedium: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 12, // +1sp
          fontWeight: FontWeight.w500,
          height: 1.50,
          letterSpacing: 0,
        ),
        labelSmall: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 11, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.45,
          letterSpacing: 0,
        ),
      );

  /// Returns the correct TextTheme for the given locale.
  static TextTheme forLocale(Locale locale) {
    if (locale.languageCode == 'ar') {
      return arabicTextTheme;
    }
    return latinTextTheme;
  }
}
```

#### `lib/core/theme/lolo_gradients.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// LOLO gradient definitions from the design system.
abstract final class LoloGradients {
  /// Premium: Level-up celebrations, premium badges, paywall CTA
  static const LinearGradient premium = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LoloColors.colorPrimary, LoloColors.colorAccent],
  );

  /// SOS: SOS mode activation, urgent alerts, danger pulse
  static const LinearGradient sos = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LoloColors.colorError, LoloColors.colorWarning],
  );

  /// Achievement: Badge unlocks, milestone cards, gold accents
  static const LinearGradient achievement = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC9A96E), Color(0xFFE8D5A3)],
  );

  /// Cool: Background subtle depth, app bar fade, onboarding backgrounds
  static const LinearGradient cool = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF161B22), Color(0xFF0D1117)],
  );

  /// Success: Streak milestones, completion celebrations
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3FB950), Color(0xFF56D364)],
  );

  /// Card Shimmer: Loading skeleton animation
  static const LinearGradient shimmerDark = LinearGradient(
    colors: [Color(0xFF21262D), Color(0xFF30363D), Color(0xFF21262D)],
  );

  /// Card Shimmer (light mode)
  static const LinearGradient shimmerLight = LinearGradient(
    colors: [Color(0xFFEAEEF2), Color(0xFFF6F8FA), Color(0xFFEAEEF2)],
  );
}
```

#### `lib/core/theme/lolo_spacing.dart`

```dart
/// LOLO 8px grid spacing system.
///
/// All spacing, sizing, and positioning values snap to this grid.
abstract final class LoloSpacing {
  static const double space2xs = 4;
  static const double spaceXs = 8;
  static const double spaceSm = 12;
  static const double spaceMd = 16;
  static const double spaceLg = 20;
  static const double spaceXl = 24;
  static const double space2xl = 32;
  static const double space3xl = 40;
  static const double space4xl = 48;
  static const double space5xl = 64;

  // Screen layout constants
  static const double screenHorizontalPadding = 16;
  static const double screenTopPadding = 8;
  static const double screenBottomPadding = 16;
  static const double screenBottomPaddingNoNav = 32;

  // Card constants
  static const double cardOuterMarginH = 16;
  static const double cardOuterMarginV = 8;
  static const double cardInnerPadding = 16;
  static const double cardContentGap = 12;
  static const double cardBorderRadius = 12;
  static const double cardBorderWidth = 1;

  // Component sizes
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 64;
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double touchTargetMin = 48;
  static const double avatarSizeSmall = 32;
  static const double avatarSizeMedium = 48;
  static const double avatarSizeLarge = 72;
}
```

#### `lib/core/theme/lolo_shadows.dart`

```dart
import 'package:flutter/material.dart';

/// LOLO shadow definitions.
///
/// Dark mode relies on background layering for depth (minimal shadows).
/// Light mode uses traditional elevation shadows.
abstract final class LoloShadows {
  // Light mode shadows
  static List<BoxShadow> get elevation1Light => [
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation2Light => [
        const BoxShadow(
          color: Color(0x1A1F2328),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation3Light => [
        const BoxShadow(
          color: Color(0x261F2328),
          blurRadius: 12,
          offset: Offset(0, 8),
        ),
        const BoxShadow(
          color: Color(0x0D1F2328),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ];

  // Dark mode shadows (subtle, used sparingly)
  static List<BoxShadow> get elevation1Dark => [
        const BoxShadow(
          color: Color(0x33000000),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get elevation2Dark => [
        const BoxShadow(
          color: Color(0x40000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ];
}
```

#### `lib/core/theme/lolo_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_typography.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Builds the complete ThemeData for light and dark modes.
///
/// Always use `LoloTheme.dark()` or `LoloTheme.light()`.
/// The default theme mode is dark.
abstract final class LoloTheme {
  static ThemeData dark({Locale locale = const Locale('en')}) {
    final textTheme = LoloTypography.forLocale(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Colors
      colorScheme: const ColorScheme.dark(
        primary: LoloColors.colorPrimary,
        secondary: LoloColors.colorAccent,
        surface: LoloColors.darkBgSecondary,
        error: LoloColors.colorError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: LoloColors.darkTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: LoloColors.darkBgPrimary,

      // Typography
      textTheme: textTheme.apply(
        bodyColor: LoloColors.darkTextPrimary,
        displayColor: LoloColors.darkTextPrimary,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: LoloColors.darkBgSecondary,
        foregroundColor: LoloColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: LoloColors.darkTextPrimary,
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LoloColors.darkBgSecondary,
        selectedItemColor: LoloColors.colorPrimary,
        unselectedItemColor: LoloColors.darkTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Cards
      cardTheme: CardTheme(
        color: LoloColors.darkBgTertiary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          side: const BorderSide(
            color: LoloColors.darkBorderDefault,
            width: LoloSpacing.cardBorderWidth,
          ),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LoloColors.darkBgTertiary,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: LoloColors.darkTextTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.darkBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.darkBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(
            color: LoloColors.darkBorderAccent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.colorError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.spaceMd,
          vertical: LoloSpacing.spaceSm,
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LoloColors.colorPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: LoloColors.darkBorderMuted,
        thickness: 1,
        space: 1,
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LoloColors.darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: LoloColors.darkSurfaceElevated1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: LoloColors.darkBgTertiary,
        selectedColor: LoloColors.colorPrimary.withValues(alpha: 0.15),
        side: const BorderSide(color: LoloColors.darkBorderDefault),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: textTheme.bodyMedium,
      ),
    );
  }

  static ThemeData light({Locale locale = const Locale('en')}) {
    final textTheme = LoloTypography.forLocale(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: LoloColors.colorPrimary,
        secondary: LoloColors.colorAccent,
        surface: LoloColors.lightBgSecondary,
        error: LoloColors.colorErrorLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: LoloColors.lightTextPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: LoloColors.lightBgPrimary,

      textTheme: textTheme.apply(
        bodyColor: LoloColors.lightTextPrimary,
        displayColor: LoloColors.lightTextPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: LoloColors.lightBgSecondary,
        foregroundColor: LoloColors.lightTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: LoloColors.lightTextPrimary,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LoloColors.lightBgSecondary,
        selectedItemColor: LoloColors.colorPrimary,
        unselectedItemColor: LoloColors.lightTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      cardTheme: CardTheme(
        color: LoloColors.lightBgTertiary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          side: const BorderSide(
            color: LoloColors.lightBorderDefault,
            width: LoloSpacing.cardBorderWidth,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LoloColors.lightBgTertiary,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: LoloColors.lightTextTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.lightBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.lightBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(
            color: LoloColors.lightBorderAccent,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: const BorderSide(color: LoloColors.colorErrorLight),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.spaceMd,
          vertical: LoloSpacing.spaceSm,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LoloColors.colorPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: LoloColors.lightBorderMuted,
        thickness: 1,
        space: 1,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LoloColors.lightBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: LoloColors.lightSurfaceElevated1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: LoloColors.lightBgTertiary,
        selectedColor: LoloColors.colorPrimary.withValues(alpha: 0.10),
        side: const BorderSide(color: LoloColors.lightBorderDefault),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: textTheme.bodyMedium,
      ),
    );
  }
}
```

### 3c. Localization Setup

#### `lib/l10n/app_en.arb`

```json
{
  "@@locale": "en",

  "appName": "LOLO",
  "@appName": { "description": "Application name" },

  "onboarding_language_title": "Choose Your Language",
  "onboarding_language_english": "English",
  "onboarding_language_arabic": "العربية",
  "onboarding_language_malay": "Bahasa Melayu",

  "onboarding_welcome_tagline": "She won't know why you got so thoughtful.\nWe won't tell.",
  "onboarding_welcome_benefit1_title": "Smart Reminders",
  "onboarding_welcome_benefit1_subtitle": "Never forget what matters to her",
  "onboarding_welcome_benefit2_title": "AI Messages",
  "onboarding_welcome_benefit2_subtitle": "Say the right thing, every time",
  "onboarding_welcome_benefit3_title": "SOS Mode",
  "onboarding_welcome_benefit3_subtitle": "Emergency help when she's upset",
  "onboarding_welcome_button_start": "Get Started",
  "onboarding_welcome_link_login": "Already have an account? Log in",

  "onboarding_signup_title": "Sign Up",
  "onboarding_signup_heading": "Create your account",
  "onboarding_signup_button_google": "Continue with Google",
  "onboarding_signup_button_apple": "Continue with Apple",
  "onboarding_signup_divider": "or",
  "onboarding_signup_label_email": "Email",
  "onboarding_signup_hint_email": "you@example.com",
  "onboarding_signup_label_password": "Password",
  "onboarding_signup_label_confirmPassword": "Confirm Password",
  "onboarding_signup_button_create": "Create Account",
  "onboarding_signup_legal": "By signing up you agree to our {terms} and {privacy}",
  "@onboarding_signup_legal": {
    "placeholders": {
      "terms": { "type": "String" },
      "privacy": { "type": "String" }
    }
  },
  "onboarding_signup_legal_terms": "Terms of Service",
  "onboarding_signup_legal_privacy": "Privacy Policy",

  "onboarding_login_title": "Log In",
  "onboarding_login_heading": "Welcome back",
  "onboarding_login_button_login": "Log In",
  "onboarding_login_link_forgot": "Forgot password?",
  "onboarding_login_link_signup": "Don't have an account? Sign up",

  "onboarding_profile_title": "Your Profile",
  "onboarding_profile_heading": "Tell us about you",
  "onboarding_profile_label_name": "Your Name",

  "common_button_continue": "Continue",
  "common_button_back": "Back",
  "common_button_skip": "Skip",
  "common_button_save": "Save",
  "common_button_cancel": "Cancel",
  "common_button_delete": "Delete",
  "common_button_done": "Done",
  "common_button_retry": "Retry",
  "common_button_close": "Close",
  "common_button_confirm": "Confirm",

  "nav_home": "Home",
  "nav_reminders": "Reminders",
  "nav_messages": "Messages",
  "nav_gifts": "Gifts",
  "nav_more": "More",

  "error_generic": "Something went wrong. Please try again.",
  "error_network": "No internet connection. Check your network.",
  "error_timeout": "Request timed out. Please try again.",
  "error_server": "Server error. We're working on it.",
  "error_unauthorized": "Session expired. Please log in again.",
  "error_rate_limited": "Too many requests. Please wait a moment.",
  "error_tier_exceeded": "Upgrade your plan to unlock this feature.",

  "empty_reminders_title": "No reminders yet",
  "empty_reminders_subtitle": "Add important dates so you never forget",
  "empty_messages_title": "No messages yet",
  "empty_messages_subtitle": "Generate your first AI message",
  "empty_memories_title": "No memories yet",
  "empty_memories_subtitle": "Start saving moments that matter"
}
```

#### `lib/l10n/app_ar.arb`

```json
{
  "@@locale": "ar",

  "appName": "LOLO",

  "onboarding_language_title": "اختر لغتك",
  "onboarding_language_english": "English",
  "onboarding_language_arabic": "العربية",
  "onboarding_language_malay": "Bahasa Melayu",

  "onboarding_welcome_tagline": "لن تعرف لماذا أصبحت أكثر اهتماماً.\nلن نخبرها.",
  "onboarding_welcome_benefit1_title": "تذكيرات ذكية",
  "onboarding_welcome_benefit1_subtitle": "لا تنسَ ما يهمها أبداً",
  "onboarding_welcome_benefit2_title": "رسائل ذكية",
  "onboarding_welcome_benefit2_subtitle": "قل الشيء الصحيح، في كل مرة",
  "onboarding_welcome_benefit3_title": "وضع الطوارئ",
  "onboarding_welcome_benefit3_subtitle": "مساعدة فورية عندما تكون منزعجة",
  "onboarding_welcome_button_start": "ابدأ الآن",
  "onboarding_welcome_link_login": "لديك حساب بالفعل؟ تسجيل الدخول",

  "onboarding_signup_title": "إنشاء حساب",
  "onboarding_signup_heading": "أنشئ حسابك",
  "onboarding_signup_button_google": "المتابعة مع Google",
  "onboarding_signup_button_apple": "المتابعة مع Apple",
  "onboarding_signup_divider": "أو",
  "onboarding_signup_label_email": "البريد الإلكتروني",
  "onboarding_signup_hint_email": "you@example.com",
  "onboarding_signup_label_password": "كلمة المرور",
  "onboarding_signup_label_confirmPassword": "تأكيد كلمة المرور",
  "onboarding_signup_button_create": "إنشاء حساب",
  "onboarding_signup_legal": "بالتسجيل أنت توافق على {terms} و{privacy}",
  "@onboarding_signup_legal": {
    "placeholders": {
      "terms": { "type": "String" },
      "privacy": { "type": "String" }
    }
  },
  "onboarding_signup_legal_terms": "شروط الخدمة",
  "onboarding_signup_legal_privacy": "سياسة الخصوصية",

  "onboarding_login_title": "تسجيل الدخول",
  "onboarding_login_heading": "أهلاً بعودتك",
  "onboarding_login_button_login": "تسجيل الدخول",
  "onboarding_login_link_forgot": "نسيت كلمة المرور؟",
  "onboarding_login_link_signup": "ليس لديك حساب؟ سجّل الآن",

  "onboarding_profile_title": "ملفك الشخصي",
  "onboarding_profile_heading": "أخبرنا عنك",
  "onboarding_profile_label_name": "اسمك",

  "common_button_continue": "متابعة",
  "common_button_back": "رجوع",
  "common_button_skip": "تخطي",
  "common_button_save": "حفظ",
  "common_button_cancel": "إلغاء",
  "common_button_delete": "حذف",
  "common_button_done": "تم",
  "common_button_retry": "إعادة المحاولة",
  "common_button_close": "إغلاق",
  "common_button_confirm": "تأكيد",

  "nav_home": "الرئيسية",
  "nav_reminders": "التذكيرات",
  "nav_messages": "الرسائل",
  "nav_gifts": "الهدايا",
  "nav_more": "المزيد",

  "error_generic": "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
  "error_network": "لا يوجد اتصال بالإنترنت. تحقق من شبكتك.",
  "error_timeout": "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.",
  "error_server": "خطأ في الخادم. نحن نعمل على حله.",
  "error_unauthorized": "انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.",
  "error_rate_limited": "طلبات كثيرة جداً. يرجى الانتظار لحظة.",
  "error_tier_exceeded": "قم بترقية خطتك لفتح هذه الميزة.",

  "empty_reminders_title": "لا توجد تذكيرات بعد",
  "empty_reminders_subtitle": "أضف التواريخ المهمة حتى لا تنسى",
  "empty_messages_title": "لا توجد رسائل بعد",
  "empty_messages_subtitle": "أنشئ أول رسالة ذكية",
  "empty_memories_title": "لا توجد ذكريات بعد",
  "empty_memories_subtitle": "ابدأ بحفظ اللحظات المهمة"
}
```

#### `lib/l10n/app_ms.arb`

```json
{
  "@@locale": "ms",

  "appName": "LOLO",

  "onboarding_language_title": "Pilih Bahasa Anda",
  "onboarding_language_english": "English",
  "onboarding_language_arabic": "العربية",
  "onboarding_language_malay": "Bahasa Melayu",

  "onboarding_welcome_tagline": "Dia tak akan tahu kenapa kamu jadi lebih perhatian.\nKami tak akan bagitahu.",
  "onboarding_welcome_benefit1_title": "Peringatan Pintar",
  "onboarding_welcome_benefit1_subtitle": "Jangan lupa apa yang penting baginya",
  "onboarding_welcome_benefit2_title": "Mesej AI",
  "onboarding_welcome_benefit2_subtitle": "Cakap benda yang betul, setiap masa",
  "onboarding_welcome_benefit3_title": "Mod SOS",
  "onboarding_welcome_benefit3_subtitle": "Bantuan kecemasan bila dia sedih",
  "onboarding_welcome_button_start": "Mula",
  "onboarding_welcome_link_login": "Sudah ada akaun? Log masuk",

  "onboarding_signup_title": "Daftar",
  "onboarding_signup_heading": "Cipta akaun anda",
  "onboarding_signup_button_google": "Teruskan dengan Google",
  "onboarding_signup_button_apple": "Teruskan dengan Apple",
  "onboarding_signup_divider": "atau",
  "onboarding_signup_label_email": "Emel",
  "onboarding_signup_hint_email": "you@example.com",
  "onboarding_signup_label_password": "Kata Laluan",
  "onboarding_signup_label_confirmPassword": "Sahkan Kata Laluan",
  "onboarding_signup_button_create": "Cipta Akaun",
  "onboarding_signup_legal": "Dengan mendaftar anda bersetuju dengan {terms} dan {privacy} kami",
  "@onboarding_signup_legal": {
    "placeholders": {
      "terms": { "type": "String" },
      "privacy": { "type": "String" }
    }
  },
  "onboarding_signup_legal_terms": "Terma Perkhidmatan",
  "onboarding_signup_legal_privacy": "Dasar Privasi",

  "onboarding_login_title": "Log Masuk",
  "onboarding_login_heading": "Selamat kembali",
  "onboarding_login_button_login": "Log Masuk",
  "onboarding_login_link_forgot": "Lupa kata laluan?",
  "onboarding_login_link_signup": "Belum ada akaun? Daftar",

  "onboarding_profile_title": "Profil Anda",
  "onboarding_profile_heading": "Beritahu kami tentang anda",
  "onboarding_profile_label_name": "Nama Anda",

  "common_button_continue": "Teruskan",
  "common_button_back": "Kembali",
  "common_button_skip": "Langkau",
  "common_button_save": "Simpan",
  "common_button_cancel": "Batal",
  "common_button_delete": "Padam",
  "common_button_done": "Selesai",
  "common_button_retry": "Cuba Semula",
  "common_button_close": "Tutup",
  "common_button_confirm": "Sahkan",

  "nav_home": "Utama",
  "nav_reminders": "Peringatan",
  "nav_messages": "Mesej",
  "nav_gifts": "Hadiah",
  "nav_more": "Lagi",

  "error_generic": "Sesuatu tidak kena. Sila cuba lagi.",
  "error_network": "Tiada sambungan internet. Semak rangkaian anda.",
  "error_timeout": "Permintaan tamat masa. Sila cuba lagi.",
  "error_server": "Ralat pelayan. Kami sedang menyelesaikannya.",
  "error_unauthorized": "Sesi tamat. Sila log masuk semula.",
  "error_rate_limited": "Terlalu banyak permintaan. Sila tunggu sebentar.",
  "error_tier_exceeded": "Naik taraf pelan anda untuk membuka ciri ini.",

  "empty_reminders_title": "Tiada peringatan lagi",
  "empty_reminders_subtitle": "Tambah tarikh penting supaya tidak lupa",
  "empty_messages_title": "Tiada mesej lagi",
  "empty_messages_subtitle": "Jana mesej AI pertama anda",
  "empty_memories_title": "Tiada kenangan lagi",
  "empty_memories_subtitle": "Mula simpan detik yang bermakna"
}
```

#### `lib/core/localization/locale_provider.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Supported locales for the LOLO app.
const supportedLocales = [
  Locale('en'),
  Locale('ar'),
  Locale('ms'),
];

/// Persisted locale preference key in Hive.
const _kLocaleKey = 'app_locale';
const _kSettingsBox = 'settings';

/// Provides the current app locale with persistence.
///
/// Reads from Hive on initialization, writes on change.
/// The [LoloApp] widget watches this provider to set [MaterialApp.locale].
@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final box = Hive.box(_kSettingsBox);
    final stored = box.get(_kLocaleKey, defaultValue: 'en') as String;
    return Locale(stored);
  }

  /// Change the app locale at runtime.
  ///
  /// Persists to Hive and triggers a full widget tree rebuild
  /// via MaterialApp.locale.
  void setLocale(Locale locale) {
    final box = Hive.box(_kSettingsBox);
    box.put(_kLocaleKey, locale.languageCode);
    state = locale;
  }

  /// Whether the current locale is RTL.
  bool get isRtl => state.languageCode == 'ar';
}

/// Convenience provider that exposes just the locale value.
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localeNotifierProvider);
});

/// Theme mode provider with persistence.
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _kThemeKey = 'theme_mode';

  @override
  ThemeMode build() {
    final box = Hive.box(_kSettingsBox);
    final stored = box.get(_kThemeKey, defaultValue: 'dark') as String;
    return stored == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void setThemeMode(ThemeMode mode) {
    final box = Hive.box(_kSettingsBox);
    box.put(_kThemeKey, mode == ThemeMode.light ? 'light' : 'dark');
    state = mode;
  }

  void toggle() {
    setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}

/// Convenience provider for ThemeMode.
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeNotifierProvider);
});
```

### 3d. Network Layer

#### `lib/core/network/dio_client.dart`

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/network/api_interceptor.dart';
import 'package:lolo/core/network/error_interceptor.dart';
import 'package:lolo/core/constants/app_constants.dart';

part 'dio_client.g.dart';

/// Singleton Dio instance with LOLO interceptors.
///
/// Interceptor chain (order matters):
/// 1. ApiInterceptor -- injects auth token, Accept-Language, X-Client-Version
/// 2. ErrorInterceptor -- maps HTTP errors to typed Failures
/// 3. LogInterceptor -- debug-only request/response logging
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // 1. Auth + headers interceptor
  dio.interceptors.add(
    ApiInterceptor(ref: ref),
  );

  // 2. Error mapping interceptor
  dio.interceptors.add(
    ErrorInterceptor(),
  );

  // 3. Logging (debug only)
  assert(
    () {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => print('[DIO] $obj'),
        ),
      );
      return true;
    }(),
  );

  return dio;
}
```

#### `lib/core/network/api_interceptor.dart`

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/core/storage/secure_storage_service.dart';
import 'package:lolo/core/constants/app_constants.dart';

/// Injects authentication token and standard headers into every request.
///
/// Headers added:
/// - Authorization: Bearer <token>
/// - Accept-Language: en|ar|ms
/// - X-Client-Version: app version
/// - X-Platform: ios|android
/// - X-Request-Id: UUID v4 per request
class ApiInterceptor extends Interceptor {
  final Ref _ref;

  ApiInterceptor({required Ref ref}) : _ref = ref;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Auth token
    final token = await SecureStorageService.getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Locale
    final locale = _ref.read(localeProvider);
    options.headers['Accept-Language'] = locale.languageCode;

    // Client metadata
    options.headers['X-Client-Version'] = AppConstants.appVersion;
    options.headers['X-Platform'] = AppConstants.platform;
    options.headers['X-Request-Id'] = _generateRequestId();

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401: attempt token refresh
    if (err.response?.statusCode == 401) {
      final refreshed = await _attemptTokenRefresh();
      if (refreshed) {
        // Retry the original request with new token
        final token = await SecureStorageService.getAuthToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.next(retryError);
        }
      }
    }
    handler.next(err);
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await Dio().post(
        '${AppConstants.baseUrl}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        await SecureStorageService.saveAuthToken(data['idToken'] as String);
        await SecureStorageService.saveRefreshToken(
          data['refreshToken'] as String,
        );
        return true;
      }
    } catch (_) {
      // Refresh failed -- user will need to re-authenticate
    }
    return false;
  }

  String _generateRequestId() {
    // Simple UUID v4 approximation
    final now = DateTime.now().microsecondsSinceEpoch;
    return '$now-${now.hashCode.toRadixString(16)}';
  }
}
```

#### `lib/core/network/error_interceptor.dart`

```dart
import 'package:dio/dio.dart';
import 'package:lolo/core/network/network_exceptions.dart';

/// Maps Dio errors to typed [NetworkException] instances.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioError(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
      ),
    );
  }

  NetworkException _mapDioError(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return const NetworkException.timeout();
    }

    if (err.type == DioExceptionType.connectionError) {
      return const NetworkException.noConnection();
    }

    final statusCode = err.response?.statusCode;
    final errorBody = err.response?.data;
    final errorCode = errorBody is Map ? errorBody['error']?['code'] : null;
    final errorMessage =
        errorBody is Map ? errorBody['error']?['message'] : null;

    return switch (statusCode) {
      400 => NetworkException.badRequest(
          message: errorMessage as String? ?? 'Invalid request',
          code: errorCode as String?,
        ),
      401 => const NetworkException.unauthorized(),
      403 => NetworkException.forbidden(
          code: errorCode as String? ?? 'PERMISSION_DENIED',
          message: errorMessage as String? ?? 'Access denied',
        ),
      404 => NetworkException.notFound(
          message: errorMessage as String? ?? 'Not found',
        ),
      409 => NetworkException.conflict(
          message: errorMessage as String? ?? 'Conflict',
          code: errorCode as String?,
        ),
      429 => const NetworkException.rateLimited(),
      500 || 502 || 503 => NetworkException.serverError(
          message: errorMessage as String? ?? 'Server error',
        ),
      _ => NetworkException.unknown(
          message: err.message ?? 'Unknown error',
        ),
    };
  }
}
```

#### `lib/core/network/network_exceptions.dart`

```dart
/// Typed network exceptions for the LOLO app.
///
/// Each variant maps to a specific HTTP error category.
/// Use pattern matching to handle different error types in the UI.
sealed class NetworkException implements Exception {
  const NetworkException();

  const factory NetworkException.noConnection() = NoConnectionException;
  const factory NetworkException.timeout() = TimeoutException;
  const factory NetworkException.unauthorized() = UnauthorizedException;
  const factory NetworkException.forbidden({
    required String code,
    String? message,
  }) = ForbiddenException;
  const factory NetworkException.badRequest({
    String? message,
    String? code,
  }) = BadRequestException;
  const factory NetworkException.notFound({String? message}) =
      NotFoundException;
  const factory NetworkException.conflict({
    String? message,
    String? code,
  }) = ConflictException;
  const factory NetworkException.rateLimited() = RateLimitedException;
  const factory NetworkException.serverError({String? message}) =
      ServerErrorException;
  const factory NetworkException.unknown({String? message}) =
      UnknownNetworkException;

  String get userMessage;
}

class NoConnectionException extends NetworkException {
  const NoConnectionException();

  @override
  String get userMessage => 'No internet connection. Check your network.';
}

class TimeoutException extends NetworkException {
  const TimeoutException();

  @override
  String get userMessage => 'Request timed out. Please try again.';
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException();

  @override
  String get userMessage => 'Session expired. Please log in again.';
}

class ForbiddenException extends NetworkException {
  final String code;
  @override
  final String? userMessage;

  const ForbiddenException({required this.code, String? message})
      : userMessage = message ?? 'Access denied.';
}

class BadRequestException extends NetworkException {
  @override
  final String? userMessage;
  final String? code;

  const BadRequestException({String? message, this.code})
      : userMessage = message ?? 'Invalid request.';
}

class NotFoundException extends NetworkException {
  @override
  final String? userMessage;

  const NotFoundException({String? message})
      : userMessage = message ?? 'Resource not found.';
}

class ConflictException extends NetworkException {
  @override
  final String? userMessage;
  final String? code;

  const ConflictException({String? message, this.code})
      : userMessage = message ?? 'Conflict detected.';
}

class RateLimitedException extends NetworkException {
  const RateLimitedException();

  @override
  String get userMessage => 'Too many requests. Please wait a moment.';
}

class ServerErrorException extends NetworkException {
  @override
  final String? userMessage;

  const ServerErrorException({String? message})
      : userMessage = message ?? 'Server error. We are working on it.';
}

class UnknownNetworkException extends NetworkException {
  @override
  final String? userMessage;

  const UnknownNetworkException({String? message})
      : userMessage = message ?? 'Something went wrong.';
}
```

#### `lib/core/network/api_response.dart`

```dart
/// Generic wrapper for API responses.
///
/// Usage:
/// ```dart
/// final response = ApiResponse<UserModel>.fromJson(
///   json,
///   (data) => UserModel.fromJson(data as Map<String, dynamic>),
/// );
/// ```
class ApiResponse<T> {
  final T? data;
  final PaginationMeta? pagination;

  const ApiResponse({this.data, this.pagination});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      pagination: json['pagination'] != null
          ? PaginationMeta.fromJson(
              json['pagination'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Pagination metadata from cursor-based API responses.
class PaginationMeta {
  final bool hasMore;
  final String? lastDocId;
  final int? totalCount;

  const PaginationMeta({
    required this.hasMore,
    this.lastDocId,
    this.totalCount,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      hasMore: json['hasMore'] as bool,
      lastDocId: json['lastDocId'] as String?,
      totalCount: json['totalCount'] as int?,
    );
  }
}
```

#### `lib/core/constants/api_endpoints.dart`

```dart
/// All REST API endpoint paths as constants.
///
/// Base URL is configured in [AppConstants.baseUrl].
/// Total: 69 endpoints across 12 modules.
abstract final class ApiEndpoints {
  // === Module 1: Auth & Account (8 endpoints) ===
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authSocial = '/auth/social';
  static const String authRefreshToken = '/auth/refresh-token';
  static const String authDeleteAccount = '/auth/account';
  static const String authProfile = '/auth/profile';
  static const String authLanguage = '/auth/language';
  static const String authOnboarding = '/auth/onboarding';

  // === Module 2: Her Profile Engine (7 endpoints) ===
  static const String profiles = '/profiles';
  static String profileById(String id) => '/profiles/$id';
  static String profilePreferences(String id) => '/profiles/$id/preferences';
  static String profileCulturalContext(String id) =>
      '/profiles/$id/cultural-context';
  static String profileZodiacDefaults(String id) =>
      '/profiles/$id/zodiac-defaults';
  static String profileFamilyMembers(String id) =>
      '/profiles/$id/family-members';
  static String profileFamilyMember(String profileId, String memberId) =>
      '/profiles/$profileId/family-members/$memberId';

  // === Module 3: Smart Reminders (8 endpoints) ===
  static const String reminders = '/reminders';
  static String reminderById(String id) => '/reminders/$id';
  static String reminderSnooze(String id) => '/reminders/$id/snooze';
  static String reminderComplete(String id) => '/reminders/$id/complete';
  static const String remindersUpcoming = '/reminders/upcoming';
  static const String promises = '/reminders/promises';
  static String promiseById(String id) => '/reminders/promises/$id';
  static const String islamicHolidays = '/reminders/islamic-holidays';

  // === Module 4: AI Message Generator (6 endpoints) ===
  static const String aiMessagesGenerate = '/ai/messages/generate';
  static const String aiMessagesModes = '/ai/messages/modes';
  static const String aiMessagesHistory = '/ai/messages/history';
  static const String aiMessagesUsage = '/ai/messages/usage';
  static String aiMessageFavorite(String id) => '/ai/messages/$id/favorite';
  static String aiMessageFeedback(String id) => '/ai/messages/$id/feedback';

  // === Module 5: Gift Recommendation Engine (5 endpoints) ===
  static const String giftsRecommend = '/gifts/recommend';
  static const String giftsCategories = '/gifts/categories';
  static const String giftsHistory = '/gifts/history';
  static String giftFeedback(String id) => '/gifts/$id/feedback';
  static const String giftsWishlist = '/gifts/wishlist';

  // === Module 6: SOS Mode (5 endpoints) ===
  static const String sosActivate = '/sos/activate';
  static const String sosAssess = '/sos/assess';
  static const String sosCoach = '/sos/coach';
  static String sosSession(String id) => '/sos/$id';
  static String sosFollowup(String id) => '/sos/$id/followup';

  // === Module 7: Gamification (7 endpoints) ===
  static const String gamificationStats = '/gamification/stats';
  static const String gamificationStreak = '/gamification/streak';
  static const String gamificationStreakFreeze = '/gamification/streak/freeze';
  static const String gamificationBadges = '/gamification/badges';
  static const String gamificationLeaderboard = '/gamification/leaderboard';
  static const String gamificationWeeklySummary = '/gamification/weekly-summary';
  static const String gamificationXpHistory = '/gamification/xp-history';

  // === Module 8: Smart Action Cards (6 endpoints) ===
  static const String actionCardsToday = '/action-cards/today';
  static String actionCardById(String id) => '/action-cards/$id';
  static String actionCardComplete(String id) => '/action-cards/$id/complete';
  static String actionCardSkip(String id) => '/action-cards/$id/skip';
  static String actionCardSave(String id) => '/action-cards/$id/save';
  static const String actionCardsHistory = '/action-cards/history';

  // === Module 9: Memory Vault (7 endpoints) ===
  static const String memories = '/memories';
  static String memoryById(String id) => '/memories/$id';
  static const String memoriesSearch = '/memories/search';
  static const String wishlist = '/memories/wishlist';
  static String wishlistItemById(String id) => '/memories/wishlist/$id';
  static const String memoriesExport = '/memories/export';
  static const String memoriesTimeline = '/memories/timeline';

  // === Module 10: Settings & Subscriptions (5 endpoints) ===
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsPrivacy = '/settings/privacy';
  static const String settingsDataExport = '/settings/data-export';
  static const String subscriptionStatus = '/subscription/status';
  static const String subscriptionVerify = '/subscription/verify';

  // === Module 11: Notifications (5 endpoints) ===
  static const String notificationsRegisterDevice = '/notifications/device';
  static const String notificationsList = '/notifications';
  static String notificationMarkRead(String id) => '/notifications/$id/read';
  static const String notificationsMarkAllRead = '/notifications/read-all';
  static const String notificationsPreferences = '/notifications/preferences';
}
```

#### `lib/core/constants/app_constants.dart`

```dart
/// App-wide constants.
abstract final class AppConstants {
  // API
  static const String baseUrl =
      'https://us-central1-lolo-app.cloudfunctions.net/api/v1';
  static const String appVersion = '1.0.0';
  static const String platform = 'android'; // Resolved at runtime

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache durations (seconds)
  static const int cacheTtlShort = 60;
  static const int cacheTtlMedium = 300;
  static const int cacheTtlLong = 3600;
  static const int cacheTtlDay = 86400;

  // Animation durations (milliseconds)
  static const int animFast = 150;
  static const int animNormal = 300;
  static const int animSlow = 500;
  static const int typewriterCharDelay = 30;

  // Rate limits (client-side throttle)
  static const int apiThrottleMs = 500;

  // Subscription tiers
  static const int freeMessageLimit = 10;
  static const int proMessageLimit = 100;
  static const int freeSosLimit = 2;
  static const int proSosLimit = 10;
  static const int freeActionCardsPerDay = 3;
  static const int proActionCardsPerDay = 10;
}
```

### 3e. Router

#### `lib/core/router/app_router.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/router/route_guards.dart';

// Feature screen imports (stubs -- will be implemented per sprint)
import 'package:lolo/features/auth/presentation/screens/welcome_screen.dart';
import 'package:lolo/features/auth/presentation/screens/login_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_name_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_partner_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_anniversary_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_privacy_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_first_card_screen.dart';
import 'package:lolo/features/dashboard/presentation/screens/home_screen.dart';
import 'package:lolo/features/dashboard/presentation/screens/main_shell_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/messages_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gifts_screen.dart';
import 'package:lolo/features/memory_vault/presentation/screens/memories_screen.dart';
import 'package:lolo/features/settings/presentation/screens/settings_screen.dart';
import 'package:lolo/features/subscription/presentation/screens/paywall_screen.dart';
import 'package:lolo/features/reminders/presentation/screens/reminders_screen.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) => routeGuard(ref, state),
    routes: [
      // === AUTH ROUTES ===
      GoRoute(
        path: '/welcome',
        name: RouteNames.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),

      // === ONBOARDING ROUTES ===
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (_, __) => const OnboardingScreen(),
        routes: [
          GoRoute(
            path: 'name',
            name: RouteNames.onboardingName,
            builder: (_, __) => const OnboardingNameScreen(),
          ),
          GoRoute(
            path: 'partner',
            name: RouteNames.onboardingPartner,
            builder: (_, __) => const OnboardingPartnerScreen(),
          ),
          GoRoute(
            path: 'anniversary',
            name: RouteNames.onboardingAnniversary,
            builder: (_, __) => const OnboardingAnniversaryScreen(),
          ),
          GoRoute(
            path: 'privacy',
            name: RouteNames.onboardingPrivacy,
            builder: (_, __) => const OnboardingPrivacyScreen(),
          ),
          GoRoute(
            path: 'first-card',
            name: RouteNames.onboardingFirstCard,
            builder: (_, __) => const OnboardingFirstCardScreen(),
          ),
        ],
      ),

      // === MAIN SHELL (Bottom Navigation) ===
      ShellRoute(
        builder: (_, __, child) => MainShellScreen(child: child),
        routes: [
          // Tab 1: Home
          GoRoute(
            path: '/',
            name: RouteNames.home,
            builder: (_, __) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'action-card/:id',
                name: RouteNames.actionCardDetail,
                builder: (_, state) => Placeholder(), // ActionCardDetailScreen
              ),
              GoRoute(
                path: 'weekly-summary',
                name: RouteNames.weeklySummary,
                builder: (_, __) => const Placeholder(), // WeeklySummaryScreen
              ),
            ],
          ),

          // Tab 2: Messages
          GoRoute(
            path: '/messages',
            name: RouteNames.messages,
            builder: (_, __) => const MessagesScreen(),
            routes: [
              GoRoute(
                path: 'generate',
                name: RouteNames.generateMessage,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'history',
                name: RouteNames.messageHistory,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.messageDetail,
                builder: (_, state) => const Placeholder(),
              ),
            ],
          ),

          // Tab 3: Gifts
          GoRoute(
            path: '/gifts',
            name: RouteNames.gifts,
            builder: (_, __) => const GiftsScreen(),
            routes: [
              GoRoute(
                path: 'recommend',
                name: RouteNames.giftRecommend,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'packages',
                name: RouteNames.giftPackages,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.giftDetail,
                builder: (_, state) => const Placeholder(),
              ),
              GoRoute(
                path: 'budget',
                name: RouteNames.giftBudget,
                builder: (_, __) => const Placeholder(),
              ),
            ],
          ),

          // Tab 4: Memories
          GoRoute(
            path: '/memories',
            name: RouteNames.memories,
            builder: (_, __) => const MemoriesScreen(),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.memoryCreate,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.memoryDetail,
                builder: (_, state) => const Placeholder(),
              ),
              GoRoute(
                path: 'wishlist',
                name: RouteNames.wishlist,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'wishlist/add',
                name: RouteNames.wishlistAdd,
                builder: (_, __) => const Placeholder(),
              ),
            ],
          ),

          // Tab 5: Profile / More
          GoRoute(
            path: '/profile',
            name: RouteNames.profile,
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'her-profile',
                name: RouteNames.herProfile,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'her-profile/zodiac',
                name: RouteNames.herProfileZodiac,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'her-profile/family',
                name: RouteNames.familyProfiles,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'her-profile/family/:id',
                name: RouteNames.familyMember,
                builder: (_, state) => const Placeholder(),
              ),
              GoRoute(
                path: 'settings',
                name: RouteNames.settings,
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: 'subscription',
                name: RouteNames.subscription,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'gamification',
                name: RouteNames.gamification,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'privacy-settings',
                name: RouteNames.privacySettings,
                builder: (_, __) => const Placeholder(),
              ),
              GoRoute(
                path: 'data-export',
                name: RouteNames.dataExport,
                builder: (_, __) => const Placeholder(),
              ),
            ],
          ),
        ],
      ),

      // === OVERLAY ROUTES (outside shell) ===
      GoRoute(
        path: '/sos',
        name: RouteNames.sos,
        builder: (_, __) => const SosScreen(),
        routes: [
          GoRoute(
            path: 'scenario',
            name: RouteNames.sosScenario,
            builder: (_, __) => const Placeholder(),
          ),
          GoRoute(
            path: 'coaching',
            name: RouteNames.sosCoaching,
            builder: (_, __) => const Placeholder(),
          ),
          GoRoute(
            path: 'followup',
            name: RouteNames.sosFollowup,
            builder: (_, __) => const Placeholder(),
          ),
        ],
      ),

      // === REMINDERS (accessible from multiple tabs) ===
      GoRoute(
        path: '/reminders',
        name: RouteNames.reminders,
        builder: (_, __) => const RemindersScreen(),
        routes: [
          GoRoute(
            path: 'create',
            name: RouteNames.reminderCreate,
            builder: (_, __) => const Placeholder(),
          ),
          GoRoute(
            path: 'promises',
            name: RouteNames.promises,
            builder: (_, __) => const Placeholder(),
          ),
          GoRoute(
            path: 'promises/create',
            name: RouteNames.promiseCreate,
            builder: (_, __) => const Placeholder(),
          ),
        ],
      ),

      // === PAYWALL ===
      GoRoute(
        path: '/paywall',
        name: RouteNames.paywall,
        builder: (_, state) => PaywallScreen(
          triggerFeature: state.extra as String?,
        ),
      ),
    ],
  );
}
```

#### `lib/core/router/route_names.dart`

```dart
/// All route name constants for GoRouter named navigation.
abstract final class RouteNames {
  // Auth
  static const String welcome = 'welcome';
  static const String login = 'login';

  // Onboarding
  static const String onboarding = 'onboarding';
  static const String onboardingName = 'onboarding-name';
  static const String onboardingPartner = 'onboarding-partner';
  static const String onboardingAnniversary = 'onboarding-anniversary';
  static const String onboardingPrivacy = 'onboarding-privacy';
  static const String onboardingFirstCard = 'onboarding-first-card';

  // Main tabs
  static const String home = 'home';
  static const String messages = 'messages';
  static const String gifts = 'gifts';
  static const String memories = 'memories';
  static const String profile = 'profile';

  // Home sub-routes
  static const String actionCardDetail = 'action-card-detail';
  static const String weeklySummary = 'weekly-summary';

  // Messages sub-routes
  static const String generateMessage = 'generate-message';
  static const String messageHistory = 'message-history';
  static const String messageDetail = 'message-detail';

  // Gifts sub-routes
  static const String giftRecommend = 'gift-recommend';
  static const String giftPackages = 'gift-packages';
  static const String giftDetail = 'gift-detail';
  static const String giftBudget = 'gift-budget';

  // Memories sub-routes
  static const String memoryCreate = 'memory-create';
  static const String memoryDetail = 'memory-detail';
  static const String wishlist = 'wishlist';
  static const String wishlistAdd = 'wishlist-add';

  // Profile sub-routes
  static const String herProfile = 'her-profile';
  static const String herProfileZodiac = 'her-profile-zodiac';
  static const String familyProfiles = 'family-profiles';
  static const String familyMember = 'family-member';
  static const String settings = 'settings';
  static const String subscription = 'subscription';
  static const String gamification = 'gamification';
  static const String privacySettings = 'privacy-settings';
  static const String dataExport = 'data-export';

  // SOS
  static const String sos = 'sos';
  static const String sosScenario = 'sos-scenario';
  static const String sosCoaching = 'sos-coaching';
  static const String sosFollowup = 'sos-followup';

  // Reminders
  static const String reminders = 'reminders';
  static const String reminderCreate = 'reminder-create';
  static const String promises = 'promises';
  static const String promiseCreate = 'promise-create';

  // Paywall
  static const String paywall = 'paywall';
}
```

#### `lib/core/router/route_guards.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Route guard that handles authentication and onboarding redirects.
///
/// Logic:
/// 1. If user is NOT authenticated and NOT on an auth route -> redirect to /welcome
/// 2. If user IS authenticated but NOT onboarded and NOT on onboarding -> redirect to /onboarding
/// 3. If user IS authenticated and IS onboarded and on an auth route -> redirect to /
/// 4. Otherwise -> no redirect (return null)
String? routeGuard(Ref ref, GoRouterState state) {
  // TODO: Replace with actual auth state provider reads
  // final authState = ref.read(authProvider);
  // final isAuthenticated = authState.isAuthenticated;
  // final isOnboarded = authState.user?.onboardingComplete ?? false;

  // Placeholder: allow all routes during initial scaffold
  const isAuthenticated = false;
  const isOnboarded = false;

  final location = state.matchedLocation;
  final isAuthRoute =
      location.startsWith('/welcome') || location.startsWith('/login');
  final isOnboardingRoute = location.startsWith('/onboarding');

  // 1. Not authenticated -> send to welcome
  if (!isAuthenticated && !isAuthRoute) {
    return '/welcome';
  }

  // 2. Authenticated but not onboarded -> send to onboarding
  if (isAuthenticated && !isOnboarded && !isOnboardingRoute) {
    return '/onboarding';
  }

  // 3. Authenticated + onboarded but on auth route -> send home
  if (isAuthenticated && isOnboarded && isAuthRoute) {
    return '/';
  }

  // 4. No redirect needed
  return null;
}
```

### 3f. Local Storage

#### `lib/core/storage/hive_setup.dart`

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/core/constants/hive_box_names.dart';

/// Initializes all Hive boxes used by the app.
///
/// Called once during [bootstrap()].
abstract final class HiveSetup {
  static Future<void> init() async {
    // Settings (locale, theme, notification preferences)
    await Hive.openBox(HiveBoxNames.settings);

    // Onboarding draft (partial progress persistence)
    await Hive.openBox(HiveBoxNames.onboardingDraft);

    // Message history cache
    await Hive.openBox(HiveBoxNames.messageCache);

    // Action cards cache (today's cards for offline)
    await Hive.openBox(HiveBoxNames.actionCardsCache);

    // General API response cache
    await Hive.openBox(HiveBoxNames.apiCache);
  }
}
```

#### `lib/core/constants/hive_box_names.dart`

```dart
/// Hive box name constants.
abstract final class HiveBoxNames {
  static const String settings = 'settings';
  static const String onboardingDraft = 'onboarding_draft';
  static const String messageCache = 'message_cache';
  static const String actionCardsCache = 'action_cards_cache';
  static const String apiCache = 'api_cache';
}
```

#### `lib/core/storage/isar_setup.dart`

```dart
/// Isar local database initialization.
///
/// Used for structured data that needs querying:
/// - Reminders (filter by date, type, status)
/// - Memories (search, timeline, tags)
/// - Wish list items
///
/// Fallback: If Isar proves unmaintained, migrate to Drift (SQLite).
abstract final class IsarSetup {
  static Future<void> init() async {
    // TODO: Initialize Isar with schemas once entity models are defined
    // final dir = await getApplicationDocumentsDirectory();
    // await Isar.open(
    //   [ReminderSchema, MemorySchema, WishListItemSchema],
    //   directory: dir.path,
    // );
  }
}
```

#### `lib/core/storage/secure_storage_service.dart`

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure token storage using platform keychain/keystore.
///
/// Stores:
/// - Firebase auth token
/// - Firebase refresh token
/// - Biometric lock preference
abstract final class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _kAuthToken = 'auth_token';
  static const _kRefreshToken = 'refresh_token';

  static Future<void> saveAuthToken(String token) =>
      _storage.write(key: _kAuthToken, value: token);

  static Future<String?> getAuthToken() =>
      _storage.read(key: _kAuthToken);

  static Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _kRefreshToken, value: token);

  static Future<String?> getRefreshToken() =>
      _storage.read(key: _kRefreshToken);

  static Future<void> clearAll() => _storage.deleteAll();
}
```

#### `lib/core/storage/local_storage_service.dart`

```dart
import 'package:hive_flutter/hive_flutter.dart';

/// Abstraction over Hive for simple key-value local storage.
///
/// Use this for caching API responses and storing app preferences.
/// For structured data (queries, indexes), use Isar instead.
class LocalStorageService {
  final Box _box;

  LocalStorageService(this._box);

  T? get<T>(String key) => _box.get(key) as T?;

  Future<void> put<T>(String key, T value) => _box.put(key, value);

  Future<void> delete(String key) => _box.delete(key);

  Future<void> clear() => _box.clear();

  bool containsKey(String key) => _box.containsKey(key);
}
```

#### `lib/core/di/providers.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/constants/hive_box_names.dart';
import 'package:lolo/core/storage/local_storage_service.dart';
import 'package:lolo/core/network/network_info.dart';

part 'providers.g.dart';

/// Global Hive settings box provider.
@Riverpod(keepAlive: true)
LocalStorageService settingsStorage(Ref ref) {
  return LocalStorageService(Hive.box(HiveBoxNames.settings));
}

/// Global API cache storage provider.
@Riverpod(keepAlive: true)
LocalStorageService apiCacheStorage(Ref ref) {
  return LocalStorageService(Hive.box(HiveBoxNames.apiCache));
}

/// Network connectivity info provider.
@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) {
  return NetworkInfoImpl();
}
```

#### `lib/core/di/provider_logger.dart`

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Debug-only Riverpod observer that logs provider lifecycle events.
class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('[Riverpod] CREATED: ${provider.name ?? provider.runtimeType}');
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] DISPOSED: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] UPDATED: ${provider.name ?? provider.runtimeType}',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[Riverpod] ERROR: ${provider.name ?? provider.runtimeType} -> $error',
      );
    }
  }
}
```

#### `lib/core/network/network_info.dart`

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstraction for checking network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
```

#### `lib/core/utils/result.dart`

```dart
import 'package:lolo/core/errors/failures.dart';

/// Either type for use case return values.
///
/// Convention: Left = Failure, Right = Success value.
///
/// Usage:
/// ```dart
/// final result = await useCase.call(params);
/// result.fold(
///   (failure) => state = ErrorState(failure.message),
///   (data) => state = LoadedState(data),
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Failure failure) = Err<T>;

  /// Fold the result into a single value.
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess);
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) =>
      onSuccess(data);
}

class Err<T> extends Result<T> {
  final Failure failure;
  const Err(this.failure);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) =>
      onFailure(failure);
}
```

#### `lib/core/errors/failures.dart`

```dart
/// Failure types for Clean Architecture error handling.
///
/// Use cases return `Result<T>` which wraps either a [Failure] or success data.
sealed class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
}

class TierLimitFailure extends Failure {
  final String requiredTier;

  const TierLimitFailure({
    required super.message,
    required this.requiredTier,
    super.code,
  });
}
```

---

## 4. Base Feature Module Template (Onboarding)

This section demonstrates the complete onboarding module as the canonical pattern. Every other feature module follows this identical structure.

### Domain Layer (Pure Dart -- zero Flutter imports)

#### `lib/features/onboarding/domain/entities/onboarding_data_entity.dart`

```dart
/// Immutable domain entity for onboarding state.
///
/// This class has ZERO external dependencies.
/// It represents the user's progress through the 5 onboarding steps.
class OnboardingDataEntity {
  final String? userName;
  final String? partnerName;
  final String? zodiacSign;
  final String? loveLanguage;
  final String? communicationStyle;
  final String? relationshipStatus;
  final DateTime? anniversaryDate;
  final int currentStep;
  final bool isComplete;

  const OnboardingDataEntity({
    this.userName,
    this.partnerName,
    this.zodiacSign,
    this.loveLanguage,
    this.communicationStyle,
    this.relationshipStatus,
    this.anniversaryDate,
    this.currentStep = 0,
    this.isComplete = false,
  });

  OnboardingDataEntity copyWith({
    String? userName,
    String? partnerName,
    String? zodiacSign,
    String? loveLanguage,
    String? communicationStyle,
    String? relationshipStatus,
    DateTime? anniversaryDate,
    int? currentStep,
    bool? isComplete,
  }) {
    return OnboardingDataEntity(
      userName: userName ?? this.userName,
      partnerName: partnerName ?? this.partnerName,
      zodiacSign: zodiacSign ?? this.zodiacSign,
      loveLanguage: loveLanguage ?? this.loveLanguage,
      communicationStyle: communicationStyle ?? this.communicationStyle,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      anniversaryDate: anniversaryDate ?? this.anniversaryDate,
      currentStep: currentStep ?? this.currentStep,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
```

#### `lib/features/onboarding/domain/repositories/onboarding_repository.dart`

```dart
import 'package:lolo/core/utils/result.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

/// Abstract repository contract for onboarding.
///
/// Implemented in the Data layer. Domain layer only depends on this interface.
abstract class OnboardingRepository {
  /// Save a single onboarding step's data.
  Future<Result<void>> saveStep({
    required int step,
    required Map<String, dynamic> data,
  });

  /// Mark onboarding as complete and trigger first action card generation.
  Future<Result<void>> completeOnboarding(OnboardingDataEntity data);

  /// Get partial onboarding progress (for resume after app kill).
  Future<Result<OnboardingDataEntity>> getProgress();
}
```

#### `lib/features/onboarding/domain/usecases/save_onboarding_step_usecase.dart`

```dart
import 'package:lolo/core/utils/result.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Saves a single onboarding step.
///
/// Use cases have a single public [call] method per Clean Architecture.
class SaveOnboardingStepUseCase {
  final OnboardingRepository _repository;

  const SaveOnboardingStepUseCase({required OnboardingRepository repository})
      : _repository = repository;

  Future<Result<void>> call({
    required int step,
    required Map<String, dynamic> data,
  }) {
    return _repository.saveStep(step: step, data: data);
  }
}
```

#### `lib/features/onboarding/domain/usecases/complete_onboarding_usecase.dart`

```dart
import 'package:lolo/core/utils/result.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Validates all onboarding steps are complete, saves to backend,
/// and marks the user as onboarded.
class CompleteOnboardingUseCase {
  final OnboardingRepository _repository;

  const CompleteOnboardingUseCase({
    required OnboardingRepository repository,
  }) : _repository = repository;

  Future<Result<void>> call(OnboardingDataEntity data) {
    // Domain validation: ensure minimum required fields are present
    if (data.userName == null || data.userName!.isEmpty) {
      return Future.value(
        const Result.failure(
          ValidationFailure(message: 'Name is required'),
        ),
      );
    }

    if (data.relationshipStatus == null) {
      return Future.value(
        const Result.failure(
          ValidationFailure(message: 'Relationship status is required'),
        ),
      );
    }

    return _repository.completeOnboarding(data);
  }
}
```

### Data Layer (Implements domain contracts)

#### `lib/features/onboarding/data/models/onboarding_data_model.dart`

```dart
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

/// DTO for onboarding data serialization.
///
/// Maps between JSON (API/Hive) and domain [OnboardingDataEntity].
class OnboardingDataModel {
  final String? userName;
  final String? partnerName;
  final String? zodiacSign;
  final String? loveLanguage;
  final String? communicationStyle;
  final String? relationshipStatus;
  final String? anniversaryDate;
  final int currentStep;
  final bool isComplete;

  const OnboardingDataModel({
    this.userName,
    this.partnerName,
    this.zodiacSign,
    this.loveLanguage,
    this.communicationStyle,
    this.relationshipStatus,
    this.anniversaryDate,
    this.currentStep = 0,
    this.isComplete = false,
  });

  factory OnboardingDataModel.fromJson(Map<String, dynamic> json) {
    return OnboardingDataModel(
      userName: json['userName'] as String?,
      partnerName: json['partnerName'] as String?,
      zodiacSign: json['zodiacSign'] as String?,
      loveLanguage: json['loveLanguage'] as String?,
      communicationStyle: json['communicationStyle'] as String?,
      relationshipStatus: json['relationshipStatus'] as String?,
      anniversaryDate: json['anniversaryDate'] as String?,
      currentStep: json['currentStep'] as int? ?? 0,
      isComplete: json['isComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'partnerName': partnerName,
      'zodiacSign': zodiacSign,
      'loveLanguage': loveLanguage,
      'communicationStyle': communicationStyle,
      'relationshipStatus': relationshipStatus,
      'anniversaryDate': anniversaryDate,
      'currentStep': currentStep,
      'isComplete': isComplete,
    };
  }

  /// Convert DTO to domain entity.
  OnboardingDataEntity toEntity() {
    return OnboardingDataEntity(
      userName: userName,
      partnerName: partnerName,
      zodiacSign: zodiacSign,
      loveLanguage: loveLanguage,
      communicationStyle: communicationStyle,
      relationshipStatus: relationshipStatus,
      anniversaryDate:
          anniversaryDate != null ? DateTime.tryParse(anniversaryDate!) : null,
      currentStep: currentStep,
      isComplete: isComplete,
    );
  }

  /// Create DTO from domain entity.
  factory OnboardingDataModel.fromEntity(OnboardingDataEntity entity) {
    return OnboardingDataModel(
      userName: entity.userName,
      partnerName: entity.partnerName,
      zodiacSign: entity.zodiacSign,
      loveLanguage: entity.loveLanguage,
      communicationStyle: entity.communicationStyle,
      relationshipStatus: entity.relationshipStatus,
      anniversaryDate: entity.anniversaryDate?.toIso8601String(),
      currentStep: entity.currentStep,
      isComplete: entity.isComplete,
    );
  }
}
```

#### `lib/features/onboarding/data/datasources/onboarding_remote_datasource.dart`

```dart
import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';

/// Remote data source for onboarding API calls.
abstract class OnboardingRemoteDataSource {
  Future<void> saveStep(int step, Map<String, dynamic> data);
  Future<void> completeOnboarding(OnboardingDataModel model);
  Future<OnboardingDataModel> getProgress();
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  final Dio _dio;

  const OnboardingRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<void> saveStep(int step, Map<String, dynamic> data) async {
    await _dio.put(
      ApiEndpoints.authOnboarding,
      data: {'step': step, ...data},
    );
  }

  @override
  Future<void> completeOnboarding(OnboardingDataModel model) async {
    await _dio.post(
      ApiEndpoints.authOnboarding,
      data: model.toJson(),
    );
  }

  @override
  Future<OnboardingDataModel> getProgress() async {
    final response = await _dio.get(ApiEndpoints.authOnboarding);
    return OnboardingDataModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
```

#### `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart`

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/core/constants/hive_box_names.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';

/// Local data source for persisting partial onboarding progress.
///
/// Ensures progress is not lost if the user kills the app mid-onboarding.
abstract class OnboardingLocalDataSource {
  Future<void> saveDraft(OnboardingDataModel model);
  OnboardingDataModel? getDraft();
  Future<void> clearDraft();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box _box = Hive.box(HiveBoxNames.onboardingDraft);

  @override
  Future<void> saveDraft(OnboardingDataModel model) async {
    await _box.put('draft', model.toJson());
  }

  @override
  OnboardingDataModel? getDraft() {
    final data = _box.get('draft');
    if (data == null) return null;
    return OnboardingDataModel.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
  }

  @override
  Future<void> clearDraft() async {
    await _box.delete('draft');
  }
}
```

#### `lib/features/onboarding/data/repositories/onboarding_repository_impl.dart`

```dart
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/network_info.dart';
import 'package:lolo/core/utils/result.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Concrete implementation of [OnboardingRepository].
///
/// Offline-first: saves locally always, syncs remotely when connected.
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource _remote;
  final OnboardingLocalDataSource _local;
  final NetworkInfo _networkInfo;

  const OnboardingRepositoryImpl({
    required OnboardingRemoteDataSource remote,
    required OnboardingLocalDataSource local,
    required NetworkInfo networkInfo,
  })  : _remote = remote,
        _local = local,
        _networkInfo = networkInfo;

  @override
  Future<Result<void>> saveStep({
    required int step,
    required Map<String, dynamic> data,
  }) async {
    try {
      // Always save locally first
      final current = _local.getDraft() ?? const OnboardingDataModel();
      final updated = OnboardingDataModel.fromJson({
        ...current.toJson(),
        ...data,
        'currentStep': step,
      });
      await _local.saveDraft(updated);

      // Sync remotely if connected
      if (await _networkInfo.isConnected) {
        await _remote.saveStep(step, data);
      }

      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        CacheFailure(message: 'Failed to save onboarding step: $e'),
      );
    }
  }

  @override
  Future<Result<void>> completeOnboarding(OnboardingDataEntity data) async {
    try {
      final model = OnboardingDataModel.fromEntity(data);

      if (await _networkInfo.isConnected) {
        await _remote.completeOnboarding(model);
        await _local.clearDraft();
        return const Result.success(null);
      } else {
        return const Result.failure(
          NetworkFailure(
            message: 'Internet connection required to complete onboarding.',
          ),
        );
      }
    } catch (e) {
      return Result.failure(
        ServerFailure(message: 'Failed to complete onboarding: $e'),
      );
    }
  }

  @override
  Future<Result<OnboardingDataEntity>> getProgress() async {
    try {
      // Try local first
      final localDraft = _local.getDraft();
      if (localDraft != null) {
        return Result.success(localDraft.toEntity());
      }

      // Fall back to remote
      if (await _networkInfo.isConnected) {
        final remote = await _remote.getProgress();
        await _local.saveDraft(remote);
        return Result.success(remote.toEntity());
      }

      return const Result.success(OnboardingDataEntity());
    } catch (e) {
      return Result.failure(
        CacheFailure(message: 'Failed to load onboarding progress: $e'),
      );
    }
  }
}
```

### Presentation Layer (Riverpod + Screens)

#### `lib/features/onboarding/presentation/providers/onboarding_state.dart`

```dart
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

/// Onboarding flow state.
sealed class OnboardingState {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

class OnboardingInProgress extends OnboardingState {
  final OnboardingDataEntity data;
  const OnboardingInProgress(this.data);
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

class OnboardingError extends OnboardingState {
  final String message;
  const OnboardingError(this.message);
}
```

#### `lib/features/onboarding/presentation/providers/onboarding_provider.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/usecases/save_onboarding_step_usecase.dart';
import 'package:lolo/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_state.dart';

part 'onboarding_provider.g.dart';

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() => const OnboardingInProgress(OnboardingDataEntity());

  /// Update a single field and advance to the next step.
  Future<void> updateStep(int step, Map<String, dynamic> data) async {
    final current = state is OnboardingInProgress
        ? (state as OnboardingInProgress).data
        : const OnboardingDataEntity();

    // Merge new data into entity
    final updated = current.copyWith(
      userName: data['userName'] as String? ?? current.userName,
      partnerName: data['partnerName'] as String? ?? current.partnerName,
      zodiacSign: data['zodiacSign'] as String? ?? current.zodiacSign,
      loveLanguage: data['loveLanguage'] as String? ?? current.loveLanguage,
      communicationStyle: data['communicationStyle'] as String? ??
          current.communicationStyle,
      relationshipStatus: data['relationshipStatus'] as String? ??
          current.relationshipStatus,
      currentStep: step,
    );

    state = OnboardingInProgress(updated);

    // Persist via use case
    // TODO: Wire up after DI providers are generated
    // final useCase = ref.read(saveOnboardingStepUseCaseProvider);
    // await useCase.call(step: step, data: data);
  }

  /// Complete onboarding and navigate to home.
  Future<void> complete() async {
    if (state is! OnboardingInProgress) return;

    final data = (state as OnboardingInProgress).data;
    state = const OnboardingLoading();

    // TODO: Wire up after DI providers are generated
    // final useCase = ref.read(completeOnboardingUseCaseProvider);
    // final result = await useCase.call(data);
    // result.fold(
    //   (failure) => state = OnboardingError(failure.message),
    //   (_) => state = const OnboardingCompleted(),
    // );

    state = const OnboardingCompleted();
  }
}
```

#### `lib/features/onboarding/presentation/screens/onboarding_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Main onboarding screen with PageView for 5 onboarding steps.
///
/// Steps:
/// 1. Your Name / Age / Status
/// 2. Her Name / Zodiac
/// 3. Anniversary Date
/// 4. Privacy Assurance
/// 5. First Action Card Preview
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: LoloSpacing.screenHorizontalPadding,
                vertical: LoloSpacing.spaceXs,
              ),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 5,
                backgroundColor: LoloColors.darkBgTertiary,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  LoloColors.colorPrimary,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: const [
                  // TODO: Replace with actual step screens
                  Placeholder(), // Step 1: Name
                  Placeholder(), // Step 2: Partner
                  Placeholder(), // Step 3: Anniversary
                  Placeholder(), // Step 4: Privacy
                  Placeholder(), // Step 5: First Card
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToNextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
```

---

## 5. Shared Widget Stubs

All 24 reusable components from the Developer Handoff, with class skeleton and documented parameters.

#### `lib/core/widgets/lolo_bottom_nav.dart`

```dart
import 'package:flutter/material.dart';

/// 5-tab bottom navigation bar. Persistent across all non-onboarding screens.
///
/// Height: 64dp (excluding safe area). Background: darkBgSecondary / lightBgSecondary.
/// Tabs: Home, Reminders, Messages, Gifts, More.
class LoloBottomNav extends StatelessWidget {
  /// Currently selected tab index (0-4).
  final int currentIndex;

  /// Callback when a tab is tapped.
  final ValueChanged<int> onTabChanged;

  /// Optional badge counts per tab index. Key = tab index, Value = count.
  final Map<int, int> badgeCounts;

  const LoloBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
    this.badgeCounts = const {},
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement per Developer Handoff Section 2.1
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_app_bar.dart`

```dart
import 'package:flutter/material.dart';

/// Top app bar with back navigation, title, and up to 2 trailing actions.
///
/// Height: 56dp. Elevation: 0. Bottom border: 1dp.
class LoloAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final bool showLogo;

  const LoloAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.actions = const [],
    this.showLogo = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement per Developer Handoff Section 2.1
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_primary_button.dart`

```dart
import 'package:flutter/material.dart';

/// Primary CTA button with loading state.
///
/// Min height: 48dp. Full width by default. Border radius: 12dp.
class LoloPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const LoloPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_text_field.dart`

```dart
import 'package:flutter/material.dart';

/// Styled text input field with label, hint, error, and RTL support.
///
/// Wraps [TextFormField] with LOLO theming. Phone/email fields force LTR.
class LoloTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool forceLtr;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;

  const LoloTextField({
    super.key,
    required this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.forceLtr = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_toast.dart`

```dart
import 'package:flutter/material.dart';

/// Toast notification overlay for XP gains, copy confirmations, errors.
///
/// Auto-dismisses after 2000ms. Slides in from top with fade.
class LoloToast {
  static void show(
    BuildContext context, {
    required String message,
    LoloToastType type = LoloToastType.info,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    // TODO: Implement using OverlayEntry
  }
}

enum LoloToastType { info, success, error, xp }
```

#### `lib/core/widgets/lolo_skeleton.dart`

```dart
import 'package:flutter/material.dart';

/// Shimmer loading placeholder.
///
/// Wraps children in a shimmer gradient animation.
/// Dark mode: #21262D -> #30363D. Light mode: #EAEEF2 -> #F6F8FA.
class LoloSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const LoloSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with shimmer package
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_empty_state.dart`

```dart
import 'package:flutter/material.dart';

/// Reusable empty state widget with illustration, title, subtitle, and CTA.
///
/// Used across: Reminders, Messages, Memories, Gifts, Action Cards, Wishes.
class LoloEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? illustrationAsset;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;

  const LoloEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.illustrationAsset,
    this.ctaLabel,
    this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_chip_group.dart`

```dart
import 'package:flutter/material.dart';

/// Selectable chip group with single or multi-select mode.
///
/// Used in: Profile, Messages (tone), Gifts (category), Action Cards, SOS.
class LoloChipGroup extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;
  final bool multiSelect;

  const LoloChipGroup({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.multiSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with Wrap + FilterChip
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_dialog.dart`

```dart
import 'package:flutter/material.dart';

/// Confirmation dialog with title, body, and action buttons.
///
/// Used for: delete confirm, logout, discard changes, subscription prompts.
class LoloDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) {
    // TODO: Implement with showDialog
    return Future.value(null);
  }
}
```

#### `lib/core/widgets/lolo_progress_bar.dart`

```dart
import 'package:flutter/material.dart';

/// Animated horizontal progress bar.
///
/// Used in: Dashboard (streak), Gamification (XP), Profile (completion).
class LoloProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? color;
  final double height;
  final String? label;

  const LoloProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 8,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_streak_display.dart`

```dart
import 'package:flutter/material.dart';

/// Streak counter with flame icon and day count.
///
/// Integrates with Rive flame animation at 4 intensity levels.
class LoloStreakDisplay extends StatelessWidget {
  final int streakDays;
  final bool showFlame;

  const LoloStreakDisplay({
    super.key,
    required this.streakDays,
    this.showFlame = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with Rive animation
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_avatar.dart`

```dart
import 'package:flutter/material.dart';

/// Circular avatar with optional online indicator and fallback initials.
class LoloAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final bool showBorder;

  const LoloAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with CachedNetworkImage fallback
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_badge.dart`

```dart
import 'package:flutter/material.dart';

/// Achievement badge with icon, glow animation, and locked state.
class LoloBadge extends StatelessWidget {
  final String name;
  final String? iconAsset;
  final bool isUnlocked;
  final bool showGlow;

  const LoloBadge({
    super.key,
    required this.name,
    this.iconAsset,
    this.isUnlocked = false,
    this.showGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/stat_card.dart`

```dart
import 'package:flutter/material.dart';

/// Small stat display card with label, value, and optional icon.
///
/// Used in: Dashboard, Gamification, Profile.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? accentColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/action_card.dart`

```dart
import 'package:flutter/material.dart';

/// Swipeable SAY/DO/BUY/GO action card.
///
/// Supports: swipe right (complete), swipe left (skip), pull down (save).
/// Has compact variant for dashboard.
class ActionCard extends StatelessWidget {
  final String type; // SAY, DO, BUY, GO
  final String title;
  final String body;
  final String? contextText;
  final int difficulty; // 1-3
  final int xpValue;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final VoidCallback? onSave;
  final bool isCompact;

  const ActionCard({
    super.key,
    required this.type,
    required this.title,
    required this.body,
    this.contextText,
    required this.difficulty,
    required this.xpValue,
    this.onComplete,
    this.onSkip,
    this.onSave,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with swipe physics
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/reminder_tile.dart`

```dart
import 'package:flutter/material.dart';

/// Compact reminder list item with urgency accent bar and countdown badge.
///
/// Accent bar colors by urgency: green (7+d), amber (3-6d), red (1-2d/today).
class ReminderTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final String category;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const ReminderTile({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    this.icon,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement per Developer Handoff
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/memory_card.dart`

```dart
import 'package:flutter/material.dart';

/// Memory vault entry card with optional thumbnail and timeline connector.
class MemoryCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String? preview;
  final ImageProvider? thumbnail;
  final List<String> tags;
  final VoidCallback? onTap;

  const MemoryCard({
    super.key,
    required this.title,
    required this.date,
    this.preview,
    this.thumbnail,
    this.tags = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/gift_card.dart`

```dart
import 'package:flutter/material.dart';

/// Gift recommendation card with image, name, price, and save action.
///
/// Supports grid (200dp tall) and list (96dp tall) layouts.
class GiftCard extends StatelessWidget {
  final String name;
  final String priceRange;
  final String? imageUrl;
  final double matchScore;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final bool isGridLayout;

  const GiftCard({
    super.key,
    required this.name,
    required this.priceRange,
    this.imageUrl,
    this.matchScore = 0,
    this.isSaved = false,
    this.onTap,
    this.onSave,
    this.isGridLayout = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/badge_card.dart`

```dart
import 'package:flutter/material.dart';

/// Badge display card for the badges gallery.
class BadgeCard extends StatelessWidget {
  final String name;
  final String description;
  final String? iconAsset;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final VoidCallback? onTap;

  const BadgeCard({
    super.key,
    required this.name,
    required this.description,
    this.iconAsset,
    this.isUnlocked = false,
    this.unlockedAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/sos_coaching_card.dart`

```dart
import 'package:flutter/material.dart';

/// SOS coaching card with 3 variants: say_this, do_not_say, body_language.
///
/// Supports typewriter text animation for streaming content.
class SosCoachingCard extends StatelessWidget {
  final String type; // say_this, do_not_say, body_language
  final String content;
  final bool isStreaming;

  const SosCoachingCard({
    super.key,
    required this.type,
    required this.content,
    this.isStreaming = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement per Feasibility Review Section 2.2
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_error_widget.dart`

```dart
import 'package:flutter/material.dart';

/// Error display widget with message and retry button.
class LoloErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const LoloErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_loading_widget.dart`

```dart
import 'package:flutter/material.dart';

/// Centered loading indicator with optional message.
class LoloLoadingWidget extends StatelessWidget {
  final String? message;

  const LoloLoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/lolo_shimmer_wrapper.dart`

```dart
import 'package:flutter/material.dart';

/// Wraps any widget in a shimmer animation effect.
///
/// Uses [shimmer] package with theme-aware gradient colors.
class LoloShimmerWrapper extends StatelessWidget {
  final Widget child;

  const LoloShimmerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with shimmer package
    return const Placeholder();
  }
}
```

#### `lib/core/widgets/paginated_list_view.dart`

```dart
import 'package:flutter/material.dart';

/// Reusable paginated list view with infinite scroll.
///
/// Triggers [onLoadMore] when scroll position reaches 80%.
/// Shows loading indicator at bottom during fetch.
class PaginatedListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoading;
  final Widget? emptyWidget;
  final Widget? errorWidget;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.hasMore = false,
    this.isLoading = false,
    this.emptyWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement with ScrollController at 80% trigger
    return const Placeholder();
  }
}
```

---

## 6. Complete pubspec.yaml

```yaml
name: lolo
description: "LOLO - Your Secret Relationship Wingman"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: '>=3.22.0'

dependencies:
  flutter:
    sdk: flutter

  # === State Management & DI ===
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  hooks_riverpod: ^2.5.1

  # === Navigation ===
  go_router: ^14.2.0

  # === Networking ===
  dio: ^5.4.3+1
  http: ^1.2.1                    # For SSE streaming in SOS mode

  # === Firebase ===
  firebase_core: ^2.31.0
  firebase_auth: ^4.19.5
  cloud_firestore: ^4.17.3
  firebase_messaging: ^14.9.1
  firebase_analytics: ^10.10.5

  # === Local Storage ===
  hive_flutter: ^1.1.0
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  flutter_secure_storage: ^9.0.0
  path_provider: ^2.1.3

  # === Localization ===
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

  # === Authentication ===
  google_sign_in: ^6.2.1
  sign_in_with_apple: ^6.1.0

  # === Subscriptions ===
  purchases_flutter: ^6.29.0
  # purchases_ui_flutter: ^6.29.0  # Optional RevenueCat paywall UI

  # === Networking Utilities ===
  connectivity_plus: ^6.0.3

  # === Image & Media ===
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.10+1
  image_picker: ^1.1.1

  # === Animations ===
  rive: ^0.13.4
  lottie: ^3.1.0
  shimmer: ^3.0.0
  confetti: ^0.7.0

  # === Charts ===
  fl_chart: ^0.68.0

  # === Calendar ===
  table_calendar: ^3.1.1

  # === Notifications ===
  flutter_local_notifications: ^17.1.2

  # === Utilities ===
  url_launcher: ^6.2.6
  share_plus: ^9.0.0
  permission_handler: ^11.3.1
  uuid: ^4.4.0

  # === Data Classes ===
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  equatable: ^2.0.5

  # === Fonts ===
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  # === Code Generation ===
  build_runner: ^2.4.9
  riverpod_generator: ^2.4.0
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  isar_generator: ^3.1.0+1

  # === Linting ===
  flutter_lints: ^3.0.2
  custom_lint: ^0.6.4
  riverpod_lint: ^2.3.10

  # === Testing ===
  mocktail: ^1.0.3
  golden_toolkit: ^0.15.0

flutter:
  uses-material-design: true
  generate: true

  assets:
    - assets/images/logo/
    - assets/images/onboarding/
    - assets/images/action_cards/
    - assets/images/zodiac/
    - assets/images/gamification/
    - assets/images/empty_states/
    - assets/animations/lottie/
    - assets/animations/rive/
    - assets/icons/custom/

  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/inter/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/inter/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/inter/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/inter/Inter-Bold.ttf
          weight: 700

    - family: Cairo
      fonts:
        - asset: assets/fonts/cairo/Cairo-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/cairo/Cairo-Bold.ttf
          weight: 700

    - family: NotoNaskhArabic
      fonts:
        - asset: assets/fonts/noto_naskh_arabic/NotoNaskhArabic-Regular.ttf
          weight: 400
        - asset: assets/fonts/noto_naskh_arabic/NotoNaskhArabic-Medium.ttf
          weight: 500

    - family: NotoSans
      fonts:
        - asset: assets/fonts/noto_sans/NotoSans-Regular.ttf
          weight: 400
        - asset: assets/fonts/noto_sans/NotoSans-Medium.ttf
          weight: 500
```

---

## Implementation Notes

### Build Order for Sprint 1

Execute this specification in the following sequence:

1. **Day 1:** Run `flutter create`, apply `pubspec.yaml`, `analysis_options.yaml`, `l10n.yaml`. Run `flutter pub get`. Verify compilation.
2. **Day 1:** Create the complete `core/` folder structure. Implement `lolo_colors.dart`, `lolo_spacing.dart`, `lolo_gradients.dart`, `lolo_shadows.dart`, `lolo_typography.dart`, `lolo_theme.dart`. Verify themes render in a test app.
3. **Day 2:** Implement `dio_client.dart`, `api_interceptor.dart`, `error_interceptor.dart`, `network_exceptions.dart`, `api_response.dart`, `api_endpoints.dart`. Implement `hive_setup.dart`, `secure_storage_service.dart`.
4. **Day 2:** Implement `locale_provider.dart`, ARB files. Run `flutter gen-l10n`. Verify EN/AR/MS locale switching.
5. **Day 3:** Implement `app_router.dart`, `route_names.dart`, `route_guards.dart`. Create stub screens for all routes (return `Scaffold` with route name as title). Verify navigation flow.
6. **Day 3:** Implement `main.dart`, `bootstrap.dart`, `app.dart`. Wire everything together. Verify: app launches, shows welcome screen, theme renders, locale switches.
7. **Day 4-5:** Implement onboarding feature module (domain -> data -> presentation). This is the reference implementation for all future feature modules.
8. **Day 6-7:** Create all shared widget stubs. Implement `LoloBottomNav`, `LoloAppBar`, `LoloPrimaryButton`, `LoloTextField` fully (these are needed by every screen).

### Dependency Import Rules (Enforced via PR Review)

```
Presentation -> Domain (allowed)
Presentation -> Core (allowed)
Domain -> NOTHING (no Flutter, no packages, no other layers)
Data -> Domain (allowed, implements interfaces)
Data -> Core (allowed, uses Dio, Hive, etc.)
Data -> Presentation (FORBIDDEN)
Domain -> Data (FORBIDDEN)
Core -> Features (FORBIDDEN)
```

### Code Generation Commands

```bash
# Run once after creating/modifying freezed classes, riverpod providers, or json_serializable models:
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development:
dart run build_runner watch --delete-conflicting-outputs

# Regenerate localization after ARB file changes:
flutter gen-l10n
```

---

**End of S1-01 Flutter Project Scaffold Specification.**
