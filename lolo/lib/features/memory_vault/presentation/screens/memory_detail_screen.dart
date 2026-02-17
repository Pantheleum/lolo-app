import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/memory_vault/presentation/providers/memory_provider.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/mood_selector.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// View a single memory with date, mood, tags, media, and full description.
class MemoryDetailScreen extends ConsumerWidget {
  const MemoryDetailScreen({required this.memoryId, super.key});

  final String memoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoryAsync = ref.watch(memoryDetailProvider(memoryId));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.memoryDetail_title, showBackButton: true),
      body: memoryAsync.when(
        loading: () => const _DetailSkeleton(),
        error: (error, _) => Center(child: Text('$error')),
        data: (memory) {
          final moodEmoji = MoodSelector.moods[memory.mood] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: LoloSpacing.spaceMd),

                // Category + favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: LoloColors.colorAccent
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        memory.category.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: LoloColors.colorAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (memory.isFavorite)
                      const Icon(Icons.favorite,
                          color: LoloColors.colorError, size: 24),
                  ],
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                // Title
                Text(memory.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: LoloSpacing.spaceXs),

                // Date + mood
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14,
                        color: isDark
                            ? LoloColors.darkTextTertiary
                            : LoloColors.lightTextTertiary),
                    const SizedBox(width: 4),
                    Text(
                      '${memory.date.day}/${memory.date.month}/${memory.date.year}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary,
                      ),
                    ),
                    if (moodEmoji.isNotEmpty) ...[
                      const SizedBox(width: LoloSpacing.spaceMd),
                      Text(moodEmoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 4),
                      Text(
                        memory.mood,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? LoloColors.darkTextSecondary
                              : LoloColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Description
                Text(memory.description, style: theme.textTheme.bodyLarge),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Media gallery
                if (memory.mediaUrls.isNotEmpty) ...[
                  Text(l10n.memoryDetail_photos,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: memory.mediaUrls.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: LoloSpacing.spaceXs),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            memory.mediaUrls[index],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 120,
                              height: 120,
                              color: isDark
                                  ? LoloColors.darkBgTertiary
                                  : LoloColors.lightBgTertiary,
                              child: const Icon(Icons.broken_image_outlined,
                                  color: LoloColors.colorPrimary),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXl),
                ],

                // Tags
                if (memory.tags.isNotEmpty) ...[
                  Text(l10n.memoryDetail_tags,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: memory.tags
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: LoloColors.colorPrimary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '#$tag',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: LoloColors.colorPrimary,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],

                const SizedBox(height: LoloSpacing.screenBottomPaddingNoNav),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: LoloSpacing.spaceMd),
            LoloSkeleton(width: 80, height: 24),
            SizedBox(height: LoloSpacing.spaceMd),
            LoloSkeleton(width: double.infinity, height: 32),
            SizedBox(height: LoloSpacing.spaceXs),
            LoloSkeleton(width: 160, height: 16),
            SizedBox(height: LoloSpacing.spaceXl),
            LoloSkeleton(width: double.infinity, height: 120),
          ],
        ),
      );
}
