
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/auth/presentation/providers/auth_provider.dart';

/// Login screen with email/password, social auth, and forgot password.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await ref.read(authNotifierProvider.notifier).signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    if (success && mounted) {
      context.go('/');
    }
  }

  Future<void> _handleGoogleLogin() async {
    final success =
        await ref.read(authNotifierProvider.notifier).signInWithGoogle();
    if (success && mounted) {
      context.go('/');
    }
  }

  Future<void> _handleAppleLogin() async {
    final success =
        await ref.read(authNotifierProvider.notifier).signInWithApple();
    if (success && mounted) {
      context.go('/');
    }
  }

  void _handleForgotPassword() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your email first')),
      );
      return;
    }
    ref.read(authNotifierProvider.notifier).sendPasswordReset(email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset email sent')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isLoading = authState.isLoading;
    final errorMessage = authState.hasError ? authState.error.toString() : null;

    return Scaffold(
      appBar: LoloAppBar(title: 'Log In'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: LoloSpacing.space2xl),

                // Header
                Text(
                  'Welcome back',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceXs),
                Text(
                  'Sign in to continue your journey',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: LoloSpacing.space2xl),

                // Error banner
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(LoloSpacing.spaceSm),
                    decoration: BoxDecoration(
                      color: LoloColors.colorError.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(LoloSpacing.cardBorderRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: LoloColors.colorError, size: 20),
                        const SizedBox(width: LoloSpacing.spaceXs),
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: LoloColors.colorError,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceMd),
                ],

                // Email field
                LoloTextField(
                  label: 'Email',
                  controller: _emailController,
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  enabled: !isLoading,
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                // Password field
                LoloTextField(
                  label: 'Password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  enabled: !isLoading,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  onSubmitted: (_) => _handleEmailLogin(),
                ),
                const SizedBox(height: LoloSpacing.spaceXs),

                // Forgot password
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: isLoading ? null : _handleForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: LoloColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                // Login button
                LoloPrimaryButton(
                  label: 'Log In',
                  onPressed: _handleEmailLogin,
                  isLoading: isLoading,
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? LoloColors.darkBorderDefault
                            : LoloColors.lightBorderDefault,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: LoloSpacing.spaceMd),
                      child: Text(
                        'or continue with',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? LoloColors.darkTextTertiary
                              : LoloColors.lightTextTertiary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? LoloColors.darkBorderDefault
                            : LoloColors.lightBorderDefault,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Social buttons
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        icon: Icons.g_mobiledata,
                        label: 'Google',
                        onTap: isLoading ? null : _handleGoogleLogin,
                      ),
                    ),
                    const SizedBox(width: LoloSpacing.spaceMd),
                    Expanded(
                      child: _SocialButton(
                        icon: Icons.apple,
                        label: 'Apple',
                        onTap: isLoading ? null : _handleAppleLogin,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: LoloSpacing.space2xl),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed('onboarding'),
                      child: Text(
                        'Sign Up',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: LoloColors.colorPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: LoloSpacing.space2xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark
          ? LoloColors.darkSurfaceElevated1
          : LoloColors.lightBgTertiary,
      borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
            border: Border.all(
              color: isDark
                  ? LoloColors.darkBorderDefault
                  : LoloColors.lightBorderDefault,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: LoloSpacing.spaceXs),
              Text(label, style: theme.textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
