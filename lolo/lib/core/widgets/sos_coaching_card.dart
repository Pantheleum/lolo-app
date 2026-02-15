import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum SOSCardVariant { sayThis, dontSay, doThis }

/// SOS coaching card with colored side border and copy button.
///
/// Variants: "Say This" (green), "Don't Say" (red + strikethrough), "Do This" (blue).
class SOSCoachingCard extends StatefulWidget {
  const SOSCoachingCard({
    required this.variant,
    required this.header,
    required this.content,
    this.example,
    this.onCopy,
    this.semanticLabel,
    super.key,
  });

  final SOSCardVariant variant;
  final String header;
  final String content;
  final String? example;
  final VoidCallback? onCopy;
  final String? semanticLabel;

  @override
  State<SOSCoachingCard> createState() => _SOSCoachingCardState();
}

class _SOSCoachingCardState extends State<SOSCoachingCard> {
  bool _copied = false;

  Color get _color => switch (widget.variant) {
        SOSCardVariant.sayThis => LoloColors.colorSuccess,
        SOSCardVariant.dontSay => LoloColors.colorError,
        SOSCardVariant.doThis => LoloColors.colorPrimary,
      };

  IconData get _icon => switch (widget.variant) {
        SOSCardVariant.sayThis => Icons.chat_outlined,
        SOSCardVariant.dontSay => Icons.block_outlined,
        SOSCardVariant.doThis => Icons.lightbulb_outlined,
      };

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.example ?? widget.content));
    HapticFeedback.lightImpact();
    setState(() => _copied = true);
    widget.onCopy?.call();
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;

    return Semantics(label: widget.semanticLabel ?? '${widget.header}: ${widget.content}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: BorderDirectional(start: BorderSide(width: 4, color: _color))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Icon(_icon, size: 20, color: _color), const SizedBox(width: 8),
            Expanded(child: Text(widget.header, style: theme.textTheme.titleMedium?.copyWith(
              color: _color, fontWeight: FontWeight.w600))),
            GestureDetector(onTap: _handleCopy, child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _copied
                  ? const Icon(Icons.check, key: ValueKey('chk'), size: 20, color: LoloColors.colorSuccess)
                  : Icon(Icons.copy_outlined, key: const ValueKey('cpy'), size: 20,
                      color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary))),
          ]),
          const SizedBox(height: 12),
          Text(widget.content, style: theme.textTheme.bodyLarge),
          if (widget.example != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(12),
              decoration: BoxDecoration(color: _color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
              child: Text('"${widget.example}"', style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                decoration: widget.variant == SOSCardVariant.dontSay ? TextDecoration.lineThrough : null,
                decorationColor: LoloColors.colorError))),
          ],
        ]),
      ));
  }
}
