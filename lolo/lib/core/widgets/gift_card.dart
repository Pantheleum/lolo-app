import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum GiftCardVariant { grid, list }

/// Gift recommendation card with image, name, price, and heart save icon.
///
/// Grid variant: column layout for 2-column grid (200dp height).
/// List variant: row layout for full-width lists (96dp height).
class GiftCard extends StatelessWidget {
  const GiftCard({
    required this.name,
    required this.priceRange,
    this.imageUrl,
    this.reasoning,
    this.isSaved = false,
    this.onSave,
    this.onTap,
    this.variant = GiftCardVariant.grid,
    this.semanticLabel,
    super.key,
  });

  final String name;
  final String priceRange;
  final String? imageUrl;
  final String? reasoning;
  final bool isSaved;
  final VoidCallback? onSave;
  final VoidCallback? onTap;
  final GiftCardVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => variant == GiftCardVariant.grid
      ? _buildGrid(context) : _buildList(context);

  Widget _buildGrid(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    return Semantics(label: semanticLabel ?? '$name. $priceRange.', child: GestureDetector(onTap: onTap,
      child: Container(height: 200, decoration: BoxDecoration(color: cardBg,
        borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor, width: 1)),
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 120, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
            _buildImage(context),
            PositionedDirectional(top: 8, end: 8, child: _HeartBtn(isSaved: isSaved, onTap: onSave)),
          ])),
          Expanded(child: Padding(padding: const EdgeInsetsDirectional.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(priceRange, style: theme.textTheme.bodySmall?.copyWith(
                color: LoloColors.colorAccent, fontWeight: FontWeight.w500)),
            ]))),
        ]))));
  }

  Widget _buildList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    return Semantics(label: semanticLabel ?? '$name. $priceRange.', child: GestureDetector(onTap: onTap,
      child: Container(height: 96, padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1)),
        child: Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 72, height: 72, child: _buildImage(context))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: theme.textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(priceRange, style: theme.textTheme.bodySmall?.copyWith(
                color: LoloColors.colorAccent, fontWeight: FontWeight.w500)),
              if (reasoning != null) ...[const SizedBox(height: 4),
                Text(reasoning!, style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary),
                  maxLines: 1, overflow: TextOverflow.ellipsis)],
            ])),
          _HeartBtn(isSaved: isSaved, onTap: onSave),
        ]))));
  }

  Widget _buildImage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(imageUrl!, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(isDark));
    }
    return _placeholder(isDark);
  }

  Widget _placeholder(bool isDark) => Container(
    color: isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderMuted,
    child: Center(child: Icon(Icons.card_giftcard_outlined, size: 32,
      color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary)));
}

class _HeartBtn extends StatelessWidget {
  const _HeartBtn({required this.isSaved, this.onTap});
  final bool isSaved;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: AnimatedSwitcher(duration: const Duration(milliseconds: 200),
      child: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
        key: ValueKey(isSaved),
        color: isSaved ? LoloColors.colorError : LoloColors.darkTextSecondary,
        size: 24, semanticLabel: isSaved ? 'Saved' : 'Save')));
}
