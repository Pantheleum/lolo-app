import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 6: Key date with segmented toggle (dating anniversary vs wedding date)
/// and a date picker.
class KeyDatePage extends ConsumerStatefulWidget {
  const KeyDatePage({super.key});

  @override
  ConsumerState<KeyDatePage> createState() => _KeyDatePageState();
}

class _KeyDatePageState extends ConsumerState<KeyDatePage> {
  String _dateType = 'dating_anniversary';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: LoloSpacing.space2xl),

          Text(
            l10n.onboarding_anniversary_title,
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoloSpacing.space2xl),

          // Segmented toggle
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? LoloColors.darkBgTertiary
                  : LoloColors.lightBgTertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  child: _SegmentButton(
                    label: l10n.onboarding_anniversary_label_dating,
                    isSelected: _dateType == 'dating_anniversary',
                    onTap: () =>
                        setState(() => _dateType = 'dating_anniversary'),
                  ),
                ),
                Expanded(
                  child: _SegmentButton(
                    label: l10n.onboarding_anniversary_label_wedding,
                    isSelected: _dateType == 'wedding_date',
                    onTap: () => setState(() => _dateType = 'wedding_date'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: LoloSpacing.space2xl),

          // Date display + picker trigger
          GestureDetector(
            onTap: _showDatePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: LoloSpacing.spaceMd,
                vertical: LoloSpacing.spaceLg,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? LoloColors.darkSurfaceElevated1
                    : LoloColors.lightSurfaceElevated1,
                borderRadius:
                    BorderRadius.circular(LoloSpacing.cardBorderRadius),
                border: Border.all(
                  color: isDark
                      ? LoloColors.darkBorderDefault
                      : LoloColors.lightBorderDefault,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 24),
                  const SizedBox(width: LoloSpacing.spaceMd),
                  Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'Select a date',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Skip option
          TextButton(
            onPressed: () {
              ref
                  .read(onboardingNotifierProvider.notifier)
                  .completeAndShowFirstCard();
            },
            child: Text(l10n.common_button_skip),
          ),
          const SizedBox(height: LoloSpacing.spaceXs),

          LoloPrimaryButton(
            label: l10n.common_button_continue,
            onPressed: _selectedDate != null ? _submit : null,
          ),
          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1970),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    if (_selectedDate != null) {
      ref.read(onboardingNotifierProvider.notifier).setKeyDate(
            date: _selectedDate!,
            dateType: _dateType,
          );
    }
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? LoloColors.colorPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.white : null,
                ),
          ),
        ),
      );
}
