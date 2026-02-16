import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lolo/features/auth/presentation/providers/auth_provider.dart';

/// Provider that checks whether the user has completed onboarding.
final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_complete') ?? false;
});

/// Route guard that handles authentication and onboarding redirects.
///
/// Logic:
/// 1. If user is NOT authenticated and NOT on an auth route -> redirect to /welcome
/// 2. If user IS authenticated but NOT onboarded and NOT on onboarding -> redirect to /onboarding
/// 3. If user IS authenticated and IS onboarded and on an auth route -> redirect to /
/// 4. Otherwise -> no redirect (return null)
String? routeGuard(Ref ref, GoRouterState state) {
  final authState = ref.read(authStateProvider);
  final isAuthenticated = authState.valueOrNull != null;

  final isOnboarded =
      ref.read(onboardingCompleteProvider).valueOrNull ?? false;

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
