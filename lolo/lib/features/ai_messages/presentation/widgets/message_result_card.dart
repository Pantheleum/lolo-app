import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Hero card displaying the generated message text.
///
/// On first display, runs a typewriter animation that reveals
/// characters incrementally. When [isEditing] is true, shows
/// a text field instead.
class MessageResultCard extends StatefulWidget {
  const MessageResultCard({
    this.content,
    this.isEditing = false,
    this.editController,
    super.key,
  });

  final String? content;
  final bool isEditing;
  final TextEditingController? editController;

  @override
  State<MessageResultCard> createState() => _MessageResultCardState();
}

class _MessageResultCardState extends State<MessageResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<int> _charCount;
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    final textLength = widget.content?.length ?? 0;

    _animController = AnimationController(
      duration: Duration(milliseconds: textLength * 25),
      vsync: this,
    );

    _charCount = IntTween(begin: 0, end: textLength).animate(
      CurvedAnimation(parent: _animController, curve: Curves.linear),
    );

    _animController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _animationComplete = true);
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark
        ? LoloColors.darkSurfaceElevated1
        : LoloColors.lightSurfaceElevated1;
    final borderColor = isDark
        ? LoloColors.darkBorderAccent
        : LoloColors.lightBorderAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceLg),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: widget.isEditing
          ? TextField(
              controller: widget.editController,
              maxLines: null,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.7,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Edit your message...',
              ),
            )
          : AnimatedBuilder(
              animation: _charCount,
              builder: (context, _) {
                final displayText = _animationComplete
                    ? widget.content ?? ''
                    : (widget.content ?? '')
                        .substring(0, _charCount.value);
                return SelectableText(
                  displayText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                  ),
                );
              },
            ),
    );
  }
}
