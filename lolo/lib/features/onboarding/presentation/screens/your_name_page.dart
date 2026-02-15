import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 3: "What should we call you?" -- single text input for user name.
///
/// Pre-filled if name was obtained from Google/Apple sign-in.
/// Validates minimum 2 characters.
class YourNamePage extends ConsumerStatefulWidget {
  const YourNamePage({super.key});

  @override
  ConsumerState<YourNamePage> createState() => _YourNamePageState();
}

class _YourNamePageState extends ConsumerState<YourNamePage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Pre-fill from social auth if available
    final state = ref.read(onboardingNotifierProvider);
    state.whenOrNull(
      active: (data, _, __) {
        if (data.userName != null) {
          _nameController.text = data.userName!;
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),

            Text(
              l10n.onboarding_name_title,
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LoloSpacing.space2xl),

            LoloTextField(
              controller: _nameController,
              hint: l10n.onboarding_name_hint,
              textInputAction: TextInputAction.done,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().length < 2) {
                  return 'Please enter at least 2 characters';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submit(),
            ),

            const Spacer(flex: 3),

            LoloPrimaryButton(
              label: l10n.common_button_continue,
              onPressed: _submit,
            ),
            const SizedBox(height: LoloSpacing.space2xl),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(onboardingNotifierProvider.notifier).setUserName(
            _nameController.text.trim(),
          );
    }
  }
}
