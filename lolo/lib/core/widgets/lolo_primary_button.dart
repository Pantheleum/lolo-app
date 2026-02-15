import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Full-width primary CTA button with loading and disabled states.
///
/// Specs: 52dp height, 24px radius, brand primary background.
/// Provides haptic feedback on press (lightImpact).
/// Loading state replaces text with a 20dp circular spinner.
class LoloPrimaryButton extends StatelessWidget {
  const LoloPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.fullWidth = true,
    this.isExpanded,
    this.semanticLabel,
    super.key,
  });

  /// Button label text.
  final String label;

  /// Tap callback. Ignored when [isLoading] or [!isEnabled].
  final VoidCallback? onPressed;

  /// Shows a spinner and disables interaction.
  final bool isLoading;

  /// Enables or disables the button.
  final bool isEnabled;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether button stretches to full available width.
  final bool fullWidth;

  /// Alias for [fullWidth]. When true, button stretches to full width.
  final bool? isExpanded;

  /// Accessibility label override.
  final String? semanticLabel;

  bool get _isInteractive => isEnabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveFullWidth = isExpanded ?? fullWidth;

    final bgColor = _isInteractive
        ? LoloColors.colorPrimary
        : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);
    final fgColor = _isInteractive
        ? Colors.white
        : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextDisabled);

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: _isInteractive,
      child: SizedBox(
        width: effectiveFullWidth ? double.infinity : null,
        height: 52,
        child: ElevatedButton(
          onPressed: _isInteractive
              ? () {
                  HapticFeedback.lightImpact();
                  onPressed?.call();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            disabledBackgroundColor: bgColor,
            disabledForegroundColor: fgColor,
            elevation: isDark ? 0 : (_isInteractive ? 2 : 0),
            shadowColor: isDark ? Colors.transparent : Colors.black26,
            minimumSize: Size(effectiveFullWidth ? double.infinity : 120, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.02,
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisSize: effectiveFullWidth ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
