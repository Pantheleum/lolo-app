import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';

/// Swipeable card widget with gesture-based interactions.
///
/// Swipe right = complete, swipe left = skip, tap save icon = save for later.
/// Displays type badge, title, body, difficulty, XP reward.
class SwipeableCard extends StatefulWidget {
  const SwipeableCard({
    required this.card,
    required this.onComplete,
    required this.onSkip,
    required this.onSave,
    required this.onTap,
    super.key,
  });

  final ActionCardEntity card;
  final VoidCallback onComplete;
  final VoidCallback onSkip;
  final VoidCallback onSave;
  final VoidCallback onTap;

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  late AnimationController _resetController;
  late Animation<Offset> _resetAnimation;

  static const _swipeThreshold = 100.0;
  static const _upSwipeThreshold = -80.0;

  Color get _typeColor => switch (widget.card.type) {
        ActionCardType.say => const Color(0xFF4A90D9),
        ActionCardType.do_ => const Color(0xFF48BB78),
        ActionCardType.buy => const Color(0xFFC9A96E),
        ActionCardType.go => const Color(0xFFED8936),
      };

  IconData get _typeIcon => switch (widget.card.type) {
        ActionCardType.say => Icons.chat_bubble_outline,
        ActionCardType.do_ => Icons.favorite_outline,
        ActionCardType.buy => Icons.card_giftcard,
        ActionCardType.go => Icons.place_outlined,
      };

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _resetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _resetController, curve: Curves.easeOut));
    _resetController.addListener(() {
      setState(() => _dragOffset = _resetAnimation.value);
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() => _dragOffset += details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragOffset.dx > _swipeThreshold) {
      widget.onComplete();
    } else if (_dragOffset.dx < -_swipeThreshold) {
      widget.onSkip();
    } else if (_dragOffset.dy < _upSwipeThreshold) {
      widget.onSave();
    } else {
      // Snap back
      _resetAnimation = Tween<Offset>(
        begin: _dragOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _resetController, curve: Curves.easeOut));
      _resetController
        ..reset()
        ..forward();
    }
  }

  double get _rotation => _dragOffset.dx / 800;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final card = widget.card;

    // Determine overlay hint based on drag direction
    Color? overlayColor;
    IconData? overlayIcon;
    if (_dragOffset.dx > 30) {
      overlayColor = LoloColors.colorSuccess;
      overlayIcon = Icons.check;
    } else if (_dragOffset.dx < -30) {
      overlayColor = LoloColors.colorError;
      overlayIcon = Icons.close;
    } else if (_dragOffset.dy < -30) {
      overlayColor = LoloColors.colorPrimary;
      overlayIcon = Icons.bookmark;
    }

    return GestureDetector(
      onTap: widget.onTap,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(
          angle: _rotation,
          child: Semantics(
            label: '${card.type.name} card: ${card.title}. '
                'Swipe right to complete, left to skip, up to save.',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(LoloSpacing.spaceLg),
              decoration: BoxDecoration(
                color: LoloColors.darkBgSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: overlayColor?.withValues(alpha: 0.5) ??
                      _typeColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row: type icon + badge + save
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _typeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(_typeIcon, color: _typeColor, size: 20),
                      ),
                      const SizedBox(width: LoloSpacing.spaceSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(card.type.name.toUpperCase(),
                                style: theme.textTheme.labelSmall?.copyWith(
                                    color: _typeColor, letterSpacing: 1.2)),
                            Text(
                              '${card.difficulty.name} \u2022 ${card.estimatedMinutes} min',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border, size: 20),
                        onPressed: widget.onSave,
                        tooltip: 'Save for later',
                      ),
                    ],
                  ),
                  const SizedBox(height: LoloSpacing.spaceMd),
                  Text(card.title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Text(card.description,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: LoloSpacing.spaceLg),
                  // XP badge
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt, size: 14,
                            color: LoloColors.colorAccent),
                        const SizedBox(width: 2),
                        Text('+${card.xpReward} XP',
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: LoloColors.colorAccent)),
                      ],
                    ),
                  ),
                  // Overlay hint icon
                  if (overlayIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(top: LoloSpacing.spaceSm),
                      child: Center(
                        child: Icon(overlayIcon, color: overlayColor, size: 40),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
