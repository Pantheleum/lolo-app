import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Toggle switch with label and optional description, RTL-aware layout.
///
/// The toggle track is 52x32dp. Label+description appear on the
/// opposite side. Layout automatically mirrors in RTL.
class LoloToggle extends StatelessWidget {
  const LoloToggle({
    required this.value,
    required this.onChanged,
    required this.label,
    this.description,
    this.enabled = true,
    this.semanticLabel,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final String? description;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final labelColor = enabled
        ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
        : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled);
    final descColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: semanticLabel ?? label,
      toggled: value,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? () => onChanged?.call(!value) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: labelColor,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: descColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: value,
                onChanged: enabled ? onChanged : null,
                activeColor: Colors.white,
                activeTrackColor: LoloColors.colorPrimary,
                inactiveThumbColor: isDark
                    ? LoloColors.gray4
                    : LoloColors.lightTextTertiary,
                inactiveTrackColor: isDark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
