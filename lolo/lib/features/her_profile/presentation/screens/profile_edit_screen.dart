import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_slider.dart';
import 'package:lolo/features/her_profile/presentation/providers/her_profile_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Profile edit screen: zodiac display, trait sliders, conflict style.
///
/// Shows zodiac-derived traits that the user can fine-tune with sliders.
/// Each slider adjusts how much a default zodiac trait applies to their partner.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({required this.profileId, super.key});

  final String profileId;

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  String? _selectedLoveLanguage;
  String? _selectedCommStyle;
  bool _hasChanges = false;

  static const _loveLanguages = [
    ('words', 'Words of Affirmation'),
    ('acts', 'Acts of Service'),
    ('gifts', 'Receiving Gifts'),
    ('time', 'Quality Time'),
    ('touch', 'Physical Touch'),
  ];

  static const _commStyles = [
    ('direct', 'Direct'),
    ('indirect', 'Indirect'),
    ('mixed', 'Mixed'),
  ];

  @override
  Widget build(BuildContext context) {
    final profileAsync =
        ref.watch(herProfileNotifierProvider(widget.profileId));
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.profile_edit_title,
        showBackButton: true,
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) {
          _selectedLoveLanguage ??= profile.loveLanguage;
          _selectedCommStyle ??= profile.communicationStyle;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(
              LoloSpacing.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Zodiac display
                if (profile.zodiacTraits != null) ...[
                  Text(l10n.profile_edit_zodiac_traits,
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: LoloSpacing.spaceSm),

                  // Personality traits
                  ...profile.zodiacTraits!.personality.map(
                    (trait) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: LoloSpacing.spaceXs,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome,
                              size: 16, color: LoloColors.colorAccent),
                          const SizedBox(width: LoloSpacing.spaceXs),
                          Expanded(
                            child: Text(trait,
                                style: theme.textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXl),
                ],

                // Love Language selector
                Text(l10n.profile_edit_loveLanguage,
                    style: theme.textTheme.titleLarge),
                const SizedBox(height: LoloSpacing.spaceSm),
                Wrap(
                  spacing: LoloSpacing.spaceXs,
                  runSpacing: LoloSpacing.spaceXs,
                  children: _loveLanguages.map((ll) {
                    final (key, label) = ll;
                    final isSelected = _selectedLoveLanguage == key;
                    return ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedLoveLanguage = selected ? key : null;
                          _hasChanges = true;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: LoloSpacing.spaceXl),

                // Communication style
                Text(l10n.profile_edit_commStyle,
                    style: theme.textTheme.titleLarge),
                const SizedBox(height: LoloSpacing.spaceSm),
                ...List.generate(_commStyles.length, (i) {
                  final (key, label) = _commStyles[i];
                  return RadioListTile<String>(
                    title: Text(label),
                    value: key,
                    groupValue: _selectedCommStyle,
                    onChanged: (val) {
                      setState(() {
                        _selectedCommStyle = val;
                        _hasChanges = true;
                      });
                    },
                  );
                }),

                // Conflict style (read-only from zodiac)
                if (profile.zodiacTraits?.conflictStyle != null) ...[
                  const SizedBox(height: LoloSpacing.spaceXl),
                  Text(l10n.profile_edit_conflictStyle,
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: LoloSpacing.spaceSm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                    decoration: BoxDecoration(
                      color: isDark
                          ? LoloColors.darkSurfaceElevated1
                          : LoloColors.lightBgTertiary,
                      borderRadius: BorderRadius.circular(
                        LoloSpacing.cardBorderRadius,
                      ),
                    ),
                    child: Text(
                      profile.zodiacTraits!.conflictStyle!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],

                const SizedBox(height: LoloSpacing.space2xl),

                // Save button
                LoloPrimaryButton(
                  label: l10n.common_button_save,
                  onPressed: _hasChanges ? _save : null,
                ),
                const SizedBox(height: LoloSpacing.space2xl),
              ],
            ),
          );
        },
      ),
    );
  }

  void _save() {
    final updates = <String, dynamic>{};
    if (_selectedLoveLanguage != null) {
      updates['loveLanguage'] = _selectedLoveLanguage;
    }
    if (_selectedCommStyle != null) {
      updates['communicationStyle'] = _selectedCommStyle;
    }
    ref
        .read(herProfileNotifierProvider(widget.profileId).notifier)
        .updateProfile(updates);
    Navigator.of(context).pop();
  }
}
