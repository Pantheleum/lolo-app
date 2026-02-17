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
import 'package:lolo/generated/l10n/app_localizations.dart';

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

    final isGenerating = generationState == const MessageGenerationState.generating();

    // Navigate to result on success
    ref.listen<MessageGenerationState>(
      messageGenerationNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          success: (msg) => context.pushNamed(
            'message-detail',
            pathParameters: {'id': msg.id},
          ),
        );
      },
    );

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.generate_configureMessage,
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
                      l10n.generate_tone,
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
                      label: l10n.generate_humorLevel,
                      valueDisplay: _humorLevel <= 20
                          ? l10n.generate_serious
                          : _humorLevel >= 80
                              ? l10n.generate_funny
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
                            l10n.generate_serious,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextTertiary
                                  : LoloColors.lightTextTertiary,
                            ),
                          ),
                          Text(
                            l10n.generate_funny,
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
                      l10n.generate_messageLength,
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
                      l10n.generate_language,
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
                      label: l10n.generate_includeHerName,
                      description: l10n.generate_includeHerNameDesc,
                    ),

                    const SizedBox(height: LoloSpacing.spaceXl),

                    // Context input
                    LoloTextField(
                      label: l10n.generate_contextOptional,
                      controller: _contextController,
                      hint: l10n.generate_contextHint,
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context).generate_button,
                      style: const TextStyle(
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
