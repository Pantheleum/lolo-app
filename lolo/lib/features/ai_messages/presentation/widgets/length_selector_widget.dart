import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';

/// Three-segment toggle for selecting message length: Short / Medium / Long.
///
/// Uses a segmented button pattern with animated background.
class LengthSelectorWidget extends StatelessWidget {
  const LengthSelectorWidget({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final MessageLength selected;
  final ValueChanged<MessageLength> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: MessageLength.values.map((length) {
          final isSelected = length == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(length),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsetsDirectional.all(4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? LoloColors.colorPrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  length.displayName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary),
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
