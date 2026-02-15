import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/core/utils/validators.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_state.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 2: Sign-up page with Google, Apple, and email options.
///
/// Social sign-in buttons are at the top (highest conversion rate),
/// followed by an "or" divider and email/password form below.
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(onboardingNotifierProvider);
    final isLoading = state is AsyncLoading ||
        state == const OnboardingState.authenticating();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
        vertical: LoloSpacing.spaceXl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: LoloSpacing.space2xl),

          Text(
            l10n.onboarding_signup_heading,
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoloSpacing.space2xl),

          // Google Sign-In
          _SocialSignInButton(
            label: l10n.onboarding_signup_button_google,
            iconAsset: 'assets/icons/custom/google_logo.svg',
            onPressed: isLoading
                ? null
                : () => ref
                    .read(onboardingNotifierProvider.notifier)
                    .signInWithGoogle(),
          ),
          const SizedBox(height: LoloSpacing.spaceSm),

          // Apple Sign-In
          _SocialSignInButton(
            label: l10n.onboarding_signup_button_apple,
            iconAsset: 'assets/icons/custom/apple_logo.svg',
            onPressed: isLoading
                ? null
                : () => ref
                    .read(onboardingNotifierProvider.notifier)
                    .signInWithApple(),
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // "or" divider
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LoloSpacing.spaceMd,
                ),
                child: Text(
                  l10n.onboarding_signup_divider,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // Email form
          Form(
            key: _formKey,
            child: Column(
              children: [
                LoloTextField(
                  controller: _emailController,
                  label: l10n.onboarding_signup_label_email,
                  hint: l10n.onboarding_signup_hint_email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                LoloTextField(
                  controller: _passwordController,
                  label: l10n.onboarding_signup_label_password,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                LoloTextField(
                  controller: _confirmPasswordController,
                  label: l10n.onboarding_signup_label_confirmPassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                LoloPrimaryButton(
                  label: l10n.onboarding_signup_button_create,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submitEmail,
                ),
              ],
            ),
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          // Legal text
          Text.rich(
            TextSpan(
              text: l10n.onboarding_signup_legal(
                l10n.onboarding_signup_legal_terms,
                l10n.onboarding_signup_legal_privacy,
              ),
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: LoloColors.darkTextTertiary,
            ),
            textAlign: TextAlign.center,
          ),

          // Error display
          state.maybeWhen(
            error: (message, _) => Padding(
              padding: const EdgeInsets.only(top: LoloSpacing.spaceMd),
              child: Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.colorError,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _submitEmail() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(onboardingNotifierProvider.notifier).signUpWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }
}

class _SocialSignInButton extends StatelessWidget {
  const _SocialSignInButton({
    required this.label,
    required this.iconAsset,
    required this.onPressed,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          iconAsset.replaceAll('.svg', '.png'),
          width: 24,
          height: 24,
        ),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LoloSpacing.cardBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
