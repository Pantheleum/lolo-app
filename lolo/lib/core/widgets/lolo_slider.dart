import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Labeled slider with value display, custom thumb, and design system colors.
///
/// RTL: Slider direction auto-reverses via Flutter's [Directionality].
class LoloSlider extends StatelessWidget {
  const LoloSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.valueDisplay,
    this.semanticLabel,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String? valueDisplay;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final trackInactive = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;

    return Semantics(
      label: semanticLabel ?? label,
      slider: true,
      value: valueDisplay ?? value.toStringAsFixed(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || valueDisplay != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 4,
                end: 4,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: theme.textTheme.titleMedium,
                    ),
                  if (valueDisplay != null)
                    Text(
                      valueDisplay!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: LoloColors.colorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: LoloColors.colorPrimary,
              inactiveTrackColor: trackInactive,
              thumbColor: LoloColors.colorPrimary,
              overlayColor: LoloColors.colorPrimary.withValues(alpha: 0.12),
              trackHeight: 4,
              thumbShape: _LoloSliderThumb(),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              valueIndicatorColor: isDark
                  ? LoloColors.darkSurfaceElevated2
                  : LoloColors.lightSurfaceElevated2,
              valueIndicatorTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? LoloColors.darkTextPrimary
                    : LoloColors.lightTextPrimary,
              ),
              showValueIndicator: ShowValueIndicator.onlyForContinuous,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: valueDisplay ?? value.toStringAsFixed(1),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom 20dp circle thumb with 2dp white border.
class _LoloSliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(20, 20);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // White border
    canvas.drawCircle(
      center,
      10,
      Paint()..color = Colors.white,
    );

    // Primary fill
    canvas.drawCircle(
      center,
      8,
      Paint()..color = sliderTheme.thumbColor ?? LoloColors.colorPrimary,
    );
  }
}
