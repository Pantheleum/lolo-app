import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Preferences screen: love language chips, interests, triggers.
///
/// Allows the user to add/remove items from categorized preference lists.
/// Each category uses chips for quick input with an "Add" text field.
class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({required this.profileId, super.key});

  final String profileId;

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  final _addController = TextEditingController();
  final Map<String, List<String>> _favorites = {};
  final List<String> _hobbies = [];
  final List<String> _dislikes = [];
  String _activeCategory = 'flowers';

  static const _categories = [
    'flowers',
    'food',
    'music',
    'movies',
    'brands',
    'colors',
  ];

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.profile_preferences_title,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Favorites category tabs
            Text(l10n.profile_preferences_favorites,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceSm),

            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: LoloSpacing.spaceXs),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isActive = _activeCategory == cat;
                  return ChoiceChip(
                    label: Text(cat[0].toUpperCase() + cat.substring(1)),
                    selected: isActive,
                    onSelected: (_) =>
                        setState(() => _activeCategory = cat),
                  );
                },
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceMd),

            // Active category items
            Wrap(
              spacing: LoloSpacing.spaceXs,
              runSpacing: LoloSpacing.spaceXs,
              children: (_favorites[_activeCategory] ?? []).map((item) {
                return Chip(
                  label: Text(item),
                  onDeleted: () {
                    setState(() {
                      _favorites[_activeCategory]?.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: LoloSpacing.spaceSm),

            // Add item row
            Row(
              children: [
                Expanded(
                  child: LoloTextField(
                    label: l10n.profile_preferences_add_hint(_activeCategory),
                    controller: _addController,
                    hint: l10n.profile_preferences_add_hint(_activeCategory),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: LoloSpacing.spaceXs),
                IconButton(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add_circle_outline),
                  color: LoloColors.colorPrimary,
                ),
              ],
            ),

            const SizedBox(height: LoloSpacing.space2xl),

            // Hobbies
            Text(l10n.profile_preferences_hobbies,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceSm),
            LoloChipGroup(
              items: _hobbies.map((s) => ChipItem(label: s)).toList(),
              selectedIndices: Set<int>.from(List.generate(_hobbies.length, (i) => i)),
              onSelectionChanged: (indices) {
                setState(() {
                  final toRemove = <String>[];
                  for (int i = 0; i < _hobbies.length; i++) {
                    if (!indices.contains(i)) {
                      toRemove.add(_hobbies[i]);
                    }
                  }
                  for (final item in toRemove) {
                    _hobbies.remove(item);
                  }
                });
              },
              selectionMode: ChipSelectionMode.multi,
            ),

            const SizedBox(height: LoloSpacing.space2xl),

            // Dislikes / triggers
            Text(l10n.profile_preferences_dislikes,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceSm),
            LoloChipGroup(
              items: _dislikes.map((s) => ChipItem(label: s, color: LoloColors.colorError)).toList(),
              selectedIndices: Set<int>.from(List.generate(_dislikes.length, (i) => i)),
              onSelectionChanged: (indices) {
                setState(() {
                  final toRemove = <String>[];
                  for (int i = 0; i < _dislikes.length; i++) {
                    if (!indices.contains(i)) {
                      toRemove.add(_dislikes[i]);
                    }
                  }
                  for (final item in toRemove) {
                    _dislikes.remove(item);
                  }
                });
              },
              selectionMode: ChipSelectionMode.multi,
            ),

            const SizedBox(height: LoloSpacing.space2xl),

            LoloPrimaryButton(
              label: l10n.common_button_save,
              onPressed: _save,
            ),
            const SizedBox(height: LoloSpacing.space2xl),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    final text = _addController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _favorites.putIfAbsent(_activeCategory, () => []);
      _favorites[_activeCategory]!.add(text);
    });
    _addController.clear();
  }

  void _save() {
    // Save via provider
    Navigator.of(context).pop();
  }
}
