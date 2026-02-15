import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Language selector for EN / AR / MS override.
///
/// Defaults to the current app locale. Allows user to generate
/// a message in a different language than their UI language.
class LanguageOverrideSelector extends StatelessWidget {
  const LanguageOverrideSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  static const _languages = [
    ('en', 'EN', 'English'),
    ('ar', 'AR', 'Arabic'),
    ('ms', 'MS', 'Malay'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: _languages.map((lang) {
        final isSelected = lang.$1 == selected;
        final borderColor = isSelected
            ? LoloColors.colorPrimary
            : (isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault);
        final bgColor = isSelected
            ? LoloColors.colorPrimary.withValues(alpha: 0.12)
            : Colors.transparent;

        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Semantics(
            label: '${lang.$3} language',
            selected: isSelected,
            child: GestureDetector(
              onTap: () => onChanged(lang.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Text(
                  lang.$2,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? LoloColors.colorPrimary
                        : (isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
