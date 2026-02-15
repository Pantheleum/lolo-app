import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Emoji-based mood picker for memory entries.
///
/// Displays a horizontal row of mood options. Selected mood gets
/// a highlighted background ring.
class MoodSelector extends StatelessWidget {
  const MoodSelector({
    required this.selectedMood,
    required this.onMoodSelected,
    super.key,
  });

  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  static const moods = <String, String>{
    'happy': '\u{1F60A}',
    'love': '\u{2764}\u{FE0F}',
    'excited': '\u{1F929}',
    'grateful': '\u{1F64F}',
    'peaceful': '\u{1F60C}',
    'nostalgic': '\u{1F972}',
    'sad': '\u{1F622}',
    'angry': '\u{1F621}',
    'anxious': '\u{1F630}',
    'confused': '\u{1F615}',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: moods.entries.map((entry) {
          final isSelected = selectedMood == entry.key;

          return Padding(
            padding: const EdgeInsets.only(right: LoloSpacing.spaceXs),
            child: GestureDetector(
              onTap: () => onMoodSelected(entry.key),
              child: Semantics(
                label: entry.key,
                selected: isSelected,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? LoloColors.colorPrimary.withValues(alpha: 0.15)
                        : (isDark
                            ? LoloColors.darkSurfaceElevated1
                            : LoloColors.lightBgTertiary),
                    border: Border.all(
                      color: isSelected
                          ? LoloColors.colorPrimary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 24),
                    ),
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
