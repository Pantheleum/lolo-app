import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/sos_mode/presentation/providers/sos_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Resolution screen after SOS coaching is complete.
///
/// Lets the user rate the experience, add resolution notes,
/// and optionally save the event to Memory Vault.
class SosCompleteScreen extends ConsumerStatefulWidget {
  const SosCompleteScreen({super.key});

  @override
  ConsumerState<SosCompleteScreen> createState() => _SosCompleteScreenState();
}

class _SosCompleteScreenState extends ConsumerState<SosCompleteScreen> {
  int _rating = 0;
  bool _saveToMemoryVault = false;
  final _resolutionController = TextEditingController();

  @override
  void dispose() {
    _resolutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final sosState = ref.watch(sosNotifierProvider);

    ref.listen<SosState>(sosNotifierProvider, (prev, next) {
      if (next.isComplete && !(prev?.isComplete ?? false)) {
        _showSuccessAndNavigate();
      }
    });

    return Scaffold(
      appBar: LoloAppBar(title: l10n.sos_feedbackTitle, showBackButton: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: LoloSpacing.space3xl),

            // Success icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LoloColors.colorSuccess.withValues(alpha: 0.15),
              ),
              child: const Icon(
                Icons.favorite,
                size: 40,
                color: LoloColors.colorSuccess,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            Text(
              l10n.sos_coachingComplete,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            Text(
              l10n.sos_situationResult,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? LoloColors.darkTextSecondary
                    : LoloColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: LoloSpacing.space2xl),

            // Star rating
            Text(
              l10n.sos_rateSession,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceSm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNum = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => _rating = starNum),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      starNum <= _rating ? Icons.star : Icons.star_outline,
                      size: 40,
                      color: LoloColors.colorAccent,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Resolution notes
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                l10n.sos_resolutionNotes,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            TextField(
              controller: _resolutionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: l10n.sos_resolutionHint,
                filled: true,
                fillColor: isDark
                    ? LoloColors.darkBgTertiary
                    : LoloColors.lightBgTertiary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDark
                        ? LoloColors.darkBorderDefault
                        : LoloColors.lightBorderDefault,
                  ),
                ),
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceMd),

            // Save to memory vault toggle
            GestureDetector(
              onTap: () =>
                  setState(() => _saveToMemoryVault = !_saveToMemoryVault),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                decoration: BoxDecoration(
                  color: _saveToMemoryVault
                      ? LoloColors.colorAccent.withValues(alpha: 0.1)
                      : (isDark
                          ? LoloColors.darkSurfaceElevated1
                          : LoloColors.lightSurfaceElevated1),
                  borderRadius:
                      BorderRadius.circular(LoloSpacing.cardBorderRadius),
                  border: Border.all(
                    color: _saveToMemoryVault
                        ? LoloColors.colorAccent
                        : (isDark
                            ? LoloColors.darkBorderDefault
                            : LoloColors.lightBorderDefault),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _saveToMemoryVault
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: _saveToMemoryVault
                          ? LoloColors.colorAccent
                          : (isDark
                              ? LoloColors.darkTextSecondary
                              : LoloColors.lightTextSecondary),
                    ),
                    const SizedBox(width: LoloSpacing.spaceSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.sos_saveToMemoryVault,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            l10n.sos_saveToMemoryVaultDesc,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextSecondary
                                  : LoloColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: LoloSpacing.space2xl),

            // Error display
            if (sosState.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: LoloSpacing.spaceMd),
                child: Text(
                  sosState.error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: LoloColors.colorError,
                  ),
                ),
              ),

            LoloPrimaryButton(
              label: l10n.sos_completeButton,
              icon: Icons.check,
              isLoading: sosState.isLoading,
              isEnabled: _rating > 0,
              onPressed: _rating == 0
                  ? null
                  : () {
                      ref.read(sosNotifierProvider.notifier).completeSession(
                            rating: _rating,
                            resolution:
                                _resolutionController.text.trim().isEmpty
                                    ? null
                                    : _resolutionController.text.trim(),
                            saveToMemoryVault: _saveToMemoryVault,
                          );
                    },
            ),
            const SizedBox(height: LoloSpacing.screenBottomPaddingNoNav),
          ],
        ),
      ),
    );
  }

  void _showSuccessAndNavigate() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.sos_sessionSaved),
        backgroundColor: LoloColors.colorSuccess,
      ),
    );
    ref.read(sosNotifierProvider.notifier).reset();
    context.go('/');
  }
}
