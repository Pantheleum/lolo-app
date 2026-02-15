import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// 5-star rating row for message feedback.
///
/// Displays a "Rate this message" label with 5 tappable stars.
/// Active stars use [LoloColors.colorAccent]; inactive use gray.
class MessageFeedbackWidget extends StatelessWidget {
  const MessageFeedbackWidget({
    required this.currentRating,
    required this.onRatingChanged,
    super.key,
  });

  final int currentRating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate this message',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            final isActive = starNumber <= currentRating;

            return Semantics(
              label: '$starNumber star${starNumber > 1 ? "s" : ""}',
              selected: isActive,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onRatingChanged(starNumber);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 4),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      isActive ? Icons.star : Icons.star_border,
                      key: ValueKey('$index-$isActive'),
                      size: 32,
                      color: isActive
                          ? LoloColors.colorAccent
                          : LoloColors.gray4,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
