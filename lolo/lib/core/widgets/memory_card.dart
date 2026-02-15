import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Memory vault entry card with optional thumbnail and category chips.
///
/// Timeline connector on the start edge. Includes circular thumbnail,
/// title, preview text, date, and tag chips.
class MemoryCard extends StatelessWidget {
  const MemoryCard({
    required this.title,
    required this.date,
    this.preview,
    this.thumbnail,
    this.tags = const [],
    this.onTap,
    this.showTimeline = true,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final DateTime date;
  final String? preview;
  final ImageProvider? thumbnail;
  final List<String> tags;
  final VoidCallback? onTap;
  final bool showTimeline;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;

    return Semantics(
      label: semanticLabel ?? '$title. ${date.day}/${date.month}/${date.year}.',
      child: GestureDetector(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showTimeline) ...[
                SizedBox(width: 24, child: Column(children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: LoloColors.colorPrimary)),
                  Expanded(child: Container(width: 2, color: borderColor)),
                ])),
                const SizedBox(width: 12),
              ],
              Expanded(child: Container(
                constraints: const BoxConstraints(minHeight: 96),
                padding: const EdgeInsetsDirectional.all(16),
                margin: const EdgeInsetsDirectional.only(bottom: 8),
                decoration: BoxDecoration(
                  color: cardBg, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (thumbnail != null) ...[
                    ClipOval(child: Image(image: thumbnail!, width: 56, height: 56, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(width: 56, height: 56,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            color: LoloColors.colorPrimary.withValues(alpha: 0.1)),
                          child: const Icon(Icons.photo_outlined, color: LoloColors.colorPrimary)))),
                    const SizedBox(width: 12),
                  ],
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: theme.textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${date.day}/${date.month}/${date.year}', style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary)),
                    if (preview != null) ...[
                      const SizedBox(height: 8),
                      Text(preview!, style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                    if (tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(spacing: 4, runSpacing: 4, children: tags.map((tag) => Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: LoloColors.colorPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                        child: Text(tag, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500,
                          color: LoloColors.colorPrimary)),
                      )).toList()),
                    ],
                  ])),
                ]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
