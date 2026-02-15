import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Action card type categories.
enum ActionCardType { say, doo, buy, go }

/// Action card completion status.
enum ActionCardStatus { pending, completed, skipped }

/// Swipeable SAY/DO/BUY/GO action card.
///
/// Displays type badge (color-coded), title, body, difficulty dots,
/// and XP reward. Supports swipe-to-complete and swipe-to-skip
/// with gesture detection and animated transforms.
class ActionCard extends StatefulWidget {
  const ActionCard({
    required this.type,
    required this.title,
    required this.body,
    required this.difficulty,
    required this.xpValue,
    this.contextText,
    this.status = ActionCardStatus.pending,
    this.onComplete,
    this.onSkip,
    this.onSave,
    this.onTap,
    this.isCompact = false,
    this.semanticLabel,
    super.key,
  });

  final ActionCardType type;
  final String title;
  final String body;
  final int difficulty;
  final int xpValue;
  final String? contextText;
  final ActionCardStatus status;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final VoidCallback? onSave;
  final VoidCallback? onTap;
  final bool isCompact;
  final String? semanticLabel;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    )..addListener(() {
        setState(() => _dragOffset = _resetAnimation.value);
      });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  Color get _typeColor => switch (widget.type) {
        ActionCardType.say => LoloColors.cardTypeSay,
        ActionCardType.doo => LoloColors.cardTypeDo,
        ActionCardType.buy => LoloColors.cardTypeBuy,
        ActionCardType.go => LoloColors.cardTypeGo,
      };

  String get _typeLabel => switch (widget.type) {
        ActionCardType.say => 'SAY',
        ActionCardType.doo => 'DO',
        ActionCardType.buy => 'BUY',
        ActionCardType.go => 'GO',
      };

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.status != ActionCardStatus.pending) return;
    setState(() => _dragOffset += details.delta.dx);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.status != ActionCardStatus.pending) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.4;
    if (_dragOffset.abs() > threshold) {
      HapticFeedback.mediumImpact();
      if (_dragOffset > 0) {
        widget.onComplete?.call();
      } else {
        widget.onSkip?.call();
      }
    }
    _resetAnimation = Tween<double>(begin: _dragOffset, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _resetController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = switch (widget.status) {
      ActionCardStatus.completed => LoloColors.colorSuccess,
      _ => isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault,
    };
    final cardOpacity = widget.status == ActionCardStatus.skipped ? 0.5 : 1.0;
    final rotation = _dragOffset / 2000;
    final padding = widget.isCompact ? 16.0 : 20.0;

    return Semantics(
      label: widget.semanticLabel ??
          '${_typeLabel} action card: ${widget.title}. '
              '${widget.xpValue} XP. Difficulty ${widget.difficulty} of 3.',
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        onTap: widget.onTap,
        child: Transform.translate(
          offset: Offset(_dragOffset, 0),
          child: Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: cardOpacity,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: widget.isCompact ? 160 : 320,
                  maxHeight: widget.isCompact ? double.infinity : 400,
                ),
                padding: EdgeInsetsDirectional.all(padding),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TypeBadge(label: _typeLabel, color: _typeColor),
                        _XpLabel(xp: widget.xpValue),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        decoration: widget.status == ActionCardStatus.skipped
                            ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.body,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary,
                      ),
                      maxLines: widget.isCompact ? 2 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.contextText != null && !widget.isCompact) ...[
                      const SizedBox(height: 12),
                      Text(widget.contextText!, style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary,
                      )),
                    ],
                    const Spacer(),
                    _DifficultyDots(difficulty: widget.difficulty, color: _typeColor),
                    if (widget.status == ActionCardStatus.completed)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 12),
                        child: Row(children: [
                          const Icon(Icons.check_circle, color: LoloColors.colorSuccess, size: 20),
                          const SizedBox(width: 8),
                          Text('Done', style: theme.textTheme.labelLarge?.copyWith(color: LoloColors.colorSuccess)),
                        ]),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      );
}

class _XpLabel extends StatelessWidget {
  const _XpLabel({required this.xp});
  final int xp;
  @override
  Widget build(BuildContext context) => Text(
        '+$xp XP',
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: LoloColors.colorAccent),
      );
}

class _DifficultyDots extends StatelessWidget {
  const _DifficultyDots({required this.difficulty, required this.color});
  final int difficulty;
  final Color color;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Difficulty: ', style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary,
          )),
          ...List.generate(3, (i) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: Container(width: 8, height: 8, decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < difficulty ? color : color.withValues(alpha: 0.2),
                )),
              )),
        ],
      );
}
