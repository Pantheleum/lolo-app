import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Themed text input field with floating label, 6 visual states,
/// and full RTL support.
///
/// States: default, focused-empty, focused-filled, filled-unfocused,
/// error, disabled.
class LoloTextField extends StatelessWidget {
  const LoloTextField({
    required this.label,
    required this.controller,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.autofillHints,
    this.semanticLabel,
    this.validator,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? semanticLabel;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final fillColor = enabled
        ? (isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary)
        : (isDark
            ? LoloColors.darkBgSecondary.withValues(alpha: 0.5)
            : LoloColors.lightBgSecondary.withValues(alpha: 0.5));

    final borderDefault = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final borderMuted = isDark
        ? LoloColors.darkBorderMuted
        : LoloColors.lightBorderMuted;

    return Semantics(
      label: semanticLabel ?? label,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        validator: validator,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: enabled
              ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
              : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          helperText: helperText,
          helperMaxLines: 2,
          errorMaxLines: 2,
          filled: true,
          fillColor: fillColor,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderDefault),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderDefault),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorPrimary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorError,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorError,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderMuted),
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
