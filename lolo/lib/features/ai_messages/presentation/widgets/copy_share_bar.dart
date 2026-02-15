import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Horizontal action bar with Copy, Share, Edit, Regenerate buttons.
class CopyShareBar extends StatelessWidget {
  const CopyShareBar({
    required this.onCopy,
    required this.onShare,
    required this.onEdit,
    required this.onRegenerate,
    this.isEditing = false,
    super.key,
  });

  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onEdit;
  final VoidCallback onRegenerate;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionBtn(
          icon: Icons.copy,
          label: 'Copy',
          onTap: onCopy,
          color: iconColor,
        ),
        _ActionBtn(
          icon: Icons.share_outlined,
          label: 'Share',
          onTap: onShare,
          color: iconColor,
        ),
        _ActionBtn(
          icon: isEditing ? Icons.check : Icons.edit_outlined,
          label: isEditing ? 'Done' : 'Edit',
          onTap: onEdit,
          color: isEditing ? LoloColors.colorPrimary : iconColor,
        ),
        _ActionBtn(
          icon: Icons.refresh,
          label: 'Regenerate',
          onTap: onRegenerate,
          color: iconColor,
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => Semantics(
        label: label,
        button: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.spaceXs,
              vertical: LoloSpacing.spaceXs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
