import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Data model for a dropdown option.
class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

/// Dropdown selector styled as a text field with chevron icon.
///
/// On mobile, opens a bottom sheet for selection.
/// Supports leading icon, error text, and RTL alignment.
class LoloDropdown<T> extends StatelessWidget {
  const LoloDropdown({
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.icon,
    this.errorText,
    this.enabled = true,
    this.semanticLabel,
    super.key,
  });

  final String label;
  final List<DropdownItem<T>> items;
  final ValueChanged<T> onChanged;
  final T? selectedValue;
  final IconData? icon;
  final String? errorText;
  final bool enabled;
  final String? semanticLabel;

  String? get _selectedLabel {
    try {
      return items.firstWhere((i) => i.value == selectedValue).label;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = errorText != null
        ? LoloColors.colorError
        : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);
    final textColor = _selectedLabel != null
        ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
        : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary);

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: enabled ? () => _showBottomSheet(context) : null,
            child: Container(
              height: 52,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: borderColor,
                  width: errorText != null ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_selectedLabel != null)
                          Text(
                            label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextSecondary
                                  : LoloColors.lightTextSecondary,
                              fontSize: 11,
                            ),
                          ),
                        Text(
                          _selectedLabel ?? label,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: isDark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                top: 4,
              ),
              child: Text(
                errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.colorError,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? LoloColors.gray5 : LoloColors.lightTextTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(label, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx).size.height * 0.5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  final isSelected = item.value == selectedValue;

                  return ListTile(
                    leading: item.icon != null
                        ? Icon(item.icon, size: 24)
                        : null,
                    title: Text(item.label),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check,
                            color: LoloColors.colorPrimary,
                          )
                        : null,
                    selected: isSelected,
                    onTap: () {
                      onChanged(item.value);
                      Navigator.of(ctx).pop();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
