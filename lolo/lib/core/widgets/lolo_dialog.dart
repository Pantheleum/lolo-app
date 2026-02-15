import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Dialog visual variant.
enum DialogVariant { confirmation, destructive, info }

/// Themed dialog with confirmation, destructive, and info variants.
///
/// Button order respects RTL: affirmative action always at end.
/// Width: screen width - 48dp, max 400dp.
class LoloDialog extends StatelessWidget {
  const LoloDialog({
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.onConfirm,
    this.variant = DialogVariant.confirmation,
    this.cancelLabel,
    this.onCancel,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final DialogVariant variant;
  final String? cancelLabel;
  final VoidCallback? onCancel;
  final String? semanticLabel;

  /// Shows the dialog as a modal.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    DialogVariant variant = DialogVariant.confirmation,
    String? cancelLabel,
  }) =>
      showGeneralDialog<bool>(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss dialog',
        barrierColor: Theme.of(context).brightness == Brightness.dark
            ? LoloColors.darkSurfaceOverlay
            : LoloColors.lightSurfaceOverlay,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: ScaleTransition(scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)), child: child),
          );
        },
        pageBuilder: (ctx, _, __) => LoloDialog(
          title: title,
          body: body,
          confirmLabel: confirmLabel,
          variant: variant,
          cancelLabel: cancelLabel ?? (variant == DialogVariant.info ? null : 'Cancel'),
          onConfirm: () => Navigator.of(ctx).pop(true),
          onCancel: () => Navigator.of(ctx).pop(false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dialogBg = isDark ? LoloColors.darkSurfaceElevated1 : LoloColors.lightSurfaceElevated1;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    final confirmBgColor = switch (variant) {
      DialogVariant.destructive => LoloColors.colorError,
      _ => LoloColors.colorPrimary,
    };

    return Center(
      child: Semantics(label: semanticLabel ?? title, namesRoute: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400, minWidth: MediaQuery.of(context).size.width - 48),
          child: Material(
            color: dialogBg,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(body, style: theme.textTheme.bodyMedium?.copyWith(color: secondaryText)),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (cancelLabel != null) ...[
                    TextButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                      child: Text(cancelLabel!, style: TextStyle(color: secondaryText)),
                    ),
                    const SizedBox(width: 12),
                  ],
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmBgColor, foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(80, 44),
                    ),
                    child: Text(confirmLabel),
                  ),
                ]),
              ]),
            ),
          ),
        )),
    );
  }
}
