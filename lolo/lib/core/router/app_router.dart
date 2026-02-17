import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/router/route_guards.dart';

// Auth
import 'package:lolo/features/auth/presentation/screens/welcome_screen.dart';
import 'package:lolo/features/auth/presentation/screens/login_screen.dart';

// Onboarding
import 'package:lolo/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_name_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_partner_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_anniversary_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_privacy_screen.dart';
import 'package:lolo/features/onboarding/presentation/screens/onboarding_first_card_screen.dart';

// Dashboard
import 'package:lolo/features/dashboard/presentation/screens/home_screen.dart';
import 'package:lolo/features/dashboard/presentation/screens/main_shell_screen.dart';

// Action Cards
import 'package:lolo/features/action_cards/presentation/screens/action_card_detail_screen.dart';

// AI Messages
import 'package:lolo/features/ai_messages/presentation/screens/messages_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/generate_message_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/message_history_screen.dart';
import 'package:lolo/features/ai_messages/presentation/screens/message_detail_screen.dart';

// Gift Engine
import 'package:lolo/features/gift_engine/presentation/screens/gifts_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gift_detail_screen.dart';
import 'package:lolo/features/gift_engine/presentation/screens/gift_history_screen.dart';

// Memory Vault
import 'package:lolo/features/memory_vault/presentation/screens/memories_screen.dart';

// Her Profile
import 'package:lolo/features/her_profile/presentation/screens/her_profile_screen.dart';
import 'package:lolo/features/her_profile/presentation/screens/profile_edit_screen.dart';
import 'package:lolo/features/her_profile/presentation/screens/preferences_screen.dart';

// Settings
import 'package:lolo/features/settings/presentation/screens/settings_screen.dart';

// Subscription
import 'package:lolo/features/subscription/presentation/screens/paywall_screen.dart';

// Reminders
import 'package:lolo/features/reminders/presentation/screens/reminders_screen.dart';
import 'package:lolo/features/reminders/presentation/screens/create_reminder_screen.dart';

// SOS
import 'package:lolo/features/sos_mode/presentation/screens/sos_screen.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_activation_screen.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_assessment_screen.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_coaching_screen.dart';
import 'package:lolo/features/sos_mode/presentation/screens/sos_complete_screen.dart';

// Gamification
import 'package:lolo/features/gamification/presentation/screens/gamification_hub_screen.dart';

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
                builder: (_, state) => ActionCardDetailScreen(
                  cardId: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: 'weekly-summary',
                name: RouteNames.weeklySummary,
                builder: (_, __) => const GamificationHubScreen(),
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
                builder: (_, __) => const GiftsScreen(),
              ),
              GoRoute(
                path: 'packages',
                name: RouteNames.giftPackages,
                builder: (_, __) => const GiftHistoryScreen(),
              ),
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.giftDetail,
                builder: (_, state) => GiftDetailScreen(
                  giftId: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: 'budget',
                name: RouteNames.giftBudget,
                builder: (_, __) => const GiftHistoryScreen(),
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
                builder: (_, __) => const MemoriesScreen(),
              ),
              GoRoute(
                path: 'detail/:id',
                name: RouteNames.memoryDetail,
                builder: (_, state) => const MemoriesScreen(),
              ),
              GoRoute(
                path: 'wishlist',
                name: RouteNames.wishlist,
                builder: (_, __) => const MemoriesScreen(),
              ),
              GoRoute(
                path: 'wishlist/add',
                name: RouteNames.wishlistAdd,
                builder: (_, __) => const MemoriesScreen(),
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
                builder: (_, state) => HerProfileScreen(
                  profileId: state.extra as String? ?? 'default',
                ),
              ),
              GoRoute(
                path: 'her-profile/zodiac',
                name: RouteNames.herProfileZodiac,
                builder: (_, state) => ProfileEditScreen(
                  profileId: state.extra as String? ?? 'default',
                ),
              ),
              GoRoute(
                path: 'her-profile/family',
                name: RouteNames.familyProfiles,
                builder: (_, state) => PreferencesScreen(
                  profileId: state.extra as String? ?? 'default',
                ),
              ),
              GoRoute(
                path: 'her-profile/family/:id',
                name: RouteNames.familyMember,
                builder: (_, state) => PreferencesScreen(
                  profileId: state.pathParameters['id'] ?? 'default',
                ),
              ),
              GoRoute(
                path: 'settings',
                name: RouteNames.settings,
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: 'subscription',
                name: RouteNames.subscription,
                builder: (_, __) => const PaywallScreen(),
              ),
              GoRoute(
                path: 'gamification',
                name: RouteNames.gamification,
                builder: (_, __) => const GamificationHubScreen(),
              ),
              GoRoute(
                path: 'privacy-settings',
                name: RouteNames.privacySettings,
                builder: (_, __) => const SettingsScreen(),
              ),
              GoRoute(
                path: 'data-export',
                name: RouteNames.dataExport,
                builder: (_, __) => const SettingsScreen(),
              ),
            ],
          ),
          // === SOS ROUTES (inside shell to keep bottom nav) ===
          GoRoute(
            path: '/sos',
            name: RouteNames.sos,
            builder: (_, __) => const SosScreen(),
            routes: [
              GoRoute(
                path: 'scenario',
                name: RouteNames.sosScenario,
                builder: (_, __) => const SosActivationScreen(),
              ),
              GoRoute(
                path: 'assessment',
                name: RouteNames.sosAssessment,
                builder: (_, __) => const SosAssessmentScreen(),
              ),
              GoRoute(
                path: 'coaching',
                name: RouteNames.sosCoaching,
                builder: (_, __) => const SosCoachingScreen(),
              ),
              GoRoute(
                path: 'complete',
                name: RouteNames.sosFollowup,
                builder: (_, __) => const SosCompleteScreen(),
              ),
            ],
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
            builder: (_, __) => const CreateReminderScreen(),
          ),
          GoRoute(
            path: 'promises',
            name: RouteNames.promises,
            builder: (_, __) => const RemindersScreen(),
          ),
          GoRoute(
            path: 'promises/create',
            name: RouteNames.promiseCreate,
            builder: (_, __) => const CreateReminderScreen(),
          ),
        ],
      ),

      // === PAYWALL ===
      GoRoute(
        path: '/paywall',
        name: RouteNames.paywall,
        builder: (_, __) => const PaywallScreen(),
      ),
    ],
  );
}
