import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Selection mode for chip groups.
enum ChipSelectionMode { single, multi }

/// Data model for a single chip item.
class ChipItem {
  const ChipItem({
    required this.label,
    this.icon,
    this.color,
  });

  final String label;
  final IconData? icon;

  /// Optional override color (used for category chips like SAY/DO/BUY/GO).
  final Color? color;
}

/// Horizontal scrollable or wrapping chip group with single/multi-select.
///
/// Selected state uses brand primary at 12% opacity with primary text.
/// Category chip variant uses per-type colors from [ChipItem.color].
class LoloChipGroup extends StatelessWidget {
  const LoloChipGroup({
    required this.items,
    required this.selectedIndices,
    required this.onSelectionChanged,
    this.selectionMode = ChipSelectionMode.single,
    this.scrollable = false,
    this.semanticLabel,
    super.key,
  });

  final List<ChipItem> items;
  final Set<int> selectedIndices;
  final ValueChanged<Set<int>> onSelectionChanged;
  final ChipSelectionMode selectionMode;
  final bool scrollable;
  final String? semanticLabel;

  void _onChipTapped(int index) {
    final newSelection = Set<int>.from(selectedIndices);

    if (selectionMode == ChipSelectionMode.single) {
      newSelection
        ..clear()
        ..add(index);
    } else {
      if (newSelection.contains(index)) {
        newSelection.remove(index);
      } else {
        newSelection.add(index);
      }
    }

    onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget chipAt(int index) {
      final item = items[index];
      final isSelected = selectedIndices.contains(index);
      final accentColor = item.color ?? LoloColors.colorPrimary;

      final bgColor = isSelected
          ? accentColor.withValues(alpha: 0.12)
          : Colors.transparent;
      final textColor = isSelected
          ? accentColor
          : (isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary);
      final borderColor = isSelected
          ? accentColor
          : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);

      return Semantics(
        label: item.label,
        selected: isSelected,
        child: GestureDetector(
          onTap: () => _onChipTapped(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 32,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: 16, color: textColor),
                  const SizedBox(width: 4),
                ],
                if (isSelected && selectionMode == ChipSelectionMode.multi) ...[
                  Icon(Icons.check, size: 14, color: textColor),
                  const SizedBox(width: 4),
                ],
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (scrollable) {
      return Semantics(
        label: semanticLabel,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(items.length, (i) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  end: i < items.length - 1 ? 8 : 0,
                ),
                child: chipAt(i),
              );
            }),
          ),
        ),
      );
    }

    return Semantics(
      label: semanticLabel,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(items.length, chipAt),
      ),
    );
  }
}
