import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Cultural context screen: religion dropdown, holidays, dietary chips.
///
/// Affects AI content tone during religious periods and filters
/// culturally inappropriate suggestions.
class CulturalContextScreen extends ConsumerStatefulWidget {
  const CulturalContextScreen({required this.profileId, super.key});

  final String profileId;

  @override
  ConsumerState<CulturalContextScreen> createState() =>
      _CulturalContextScreenState();
}

class _CulturalContextScreenState
    extends ConsumerState<CulturalContextScreen> {
  String? _background;
  String? _religiousObservance;
  String? _dialect;

  static const _backgrounds = [
    ('gulf_arab', 'Gulf Arab'),
    ('levantine', 'Levantine'),
    ('egyptian', 'Egyptian'),
    ('north_african', 'North African'),
    ('malay', 'Malaysian/Malay'),
    ('western', 'Western'),
    ('south_asian', 'South Asian'),
    ('east_asian', 'East Asian'),
    ('other', 'Other'),
  ];

  static const _observanceLevels = [
    ('high', 'High -- Observes all religious practices'),
    ('moderate', 'Moderate -- Observes major practices'),
    ('low', 'Low -- Culturally connected'),
    ('secular', 'Secular'),
  ];

  static const _dialects = [
    ('msa', 'Modern Standard Arabic (MSA)'),
    ('gulf', 'Gulf Arabic'),
    ('egyptian', 'Egyptian Arabic'),
    ('levantine', 'Levantine Arabic'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.profile_cultural_title,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Background dropdown
            Text(l10n.profile_cultural_background,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceSm),
            _buildDropdown(
              value: _background,
              items: _backgrounds,
              hint: l10n.profile_cultural_background_hint,
              onChanged: (val) => setState(() => _background = val),
            ),

            const SizedBox(height: LoloSpacing.spaceXl),

            // Religious observance
            Text(l10n.profile_cultural_observance,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceSm),
            ...List.generate(_observanceLevels.length, (i) {
              final (key, label) = _observanceLevels[i];
              return RadioListTile<String>(
                title: Text(label, style: theme.textTheme.bodyMedium),
                value: key,
                groupValue: _religiousObservance,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) =>
                    setState(() => _religiousObservance = val),
              );
            }),

            const SizedBox(height: LoloSpacing.spaceXl),

            // Arabic dialect (only shown if background is Arab)
            if (_background != null &&
                ['gulf_arab', 'levantine', 'egyptian', 'north_african']
                    .contains(_background)) ...[
              Text(l10n.profile_cultural_dialect,
                  style: theme.textTheme.titleLarge),
              const SizedBox(height: LoloSpacing.spaceSm),
              _buildDropdown(
                value: _dialect,
                items: _dialects,
                hint: l10n.profile_cultural_dialect_hint,
                onChanged: (val) => setState(() => _dialect = val),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),
            ],

            // Info card about what this affects
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(LoloSpacing.spaceMd),
              decoration: BoxDecoration(
                color: LoloColors.colorInfo.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(LoloSpacing.cardBorderRadius),
                border: Border.all(
                  color: LoloColors.colorInfo.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      color: LoloColors.colorInfo, size: 20),
                  const SizedBox(width: LoloSpacing.spaceXs),
                  Expanded(
                    child: Text(
                      l10n.profile_cultural_info,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
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

  Widget _buildDropdown({
    required String? value,
    required List<(String, String)> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark
            ? LoloColors.darkBgTertiary
            : LoloColors.lightBgTertiary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          borderSide: BorderSide(
            color: isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault,
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item.$1,
                child: Text(item.$2),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  void _save() {
    final culturalContext = CulturalContextEntity(
      background: _background,
      religiousObservance: _religiousObservance,
      dialect: _dialect,
    );
    // Save via provider
    Navigator.of(this.context).pop();
  }
}
