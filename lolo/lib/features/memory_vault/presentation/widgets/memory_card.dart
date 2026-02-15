import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/mood_selector.dart';

/// Card for displaying a memory in grid or list view.
class MemoryVaultCard extends StatelessWidget {
  const MemoryVaultCard({
    required this.memory,
    required this.onTap,
    this.isGridView = true,
    this.onFavoriteToggle,
    super.key,
  });

  final Memory memory;
  final VoidCallback onTap;
  final bool isGridView;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark
        ? LoloColors.darkSurfaceElevated1
        : LoloColors.lightSurfaceElevated1;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;

    final moodEmoji = MoodSelector.moods[memory.mood] ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          border: Border.all(color: borderColor),
        ),
        child: isGridView ? _buildGridContent(theme, isDark, moodEmoji)
            : _buildListContent(theme, isDark, moodEmoji),
      ),
    );
  }

  Widget _buildGridContent(ThemeData theme, bool isDark, String moodEmoji) {
    return Padding(
      padding: const EdgeInsets.all(LoloSpacing.cardInnerPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: LoloColors.colorPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  memory.category.label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: LoloColors.colorPrimary,
                  ),
                ),
              ),
              if (moodEmoji.isNotEmpty)
                Text(moodEmoji, style: const TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
          Text(
            memory.title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${memory.date.day}/${memory.date.month}/${memory.date.year}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? LoloColors.darkTextTertiary
                      : LoloColors.lightTextTertiary,
                ),
              ),
              if (memory.isFavorite)
                const Icon(Icons.favorite,
                    size: 14, color: LoloColors.colorError),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(ThemeData theme, bool isDark, String moodEmoji) {
    return Padding(
      padding: const EdgeInsets.all(LoloSpacing.cardInnerPadding),
      child: Row(
        children: [
          // Mood emoji
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LoloColors.colorPrimary.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Text(
                moodEmoji.isNotEmpty ? moodEmoji : memory.category.emoji,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: LoloSpacing.spaceSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memory.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  memory.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${memory.date.day}/${memory.date.month}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? LoloColors.darkTextTertiary
                      : LoloColors.lightTextTertiary,
                ),
              ),
              if (memory.isFavorite)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(Icons.favorite,
                      size: 14, color: LoloColors.colorError),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
