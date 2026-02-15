import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/paginated_list_view.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_state.dart';

/// Screen 25: Gift History.
///
/// Displays a list of past gift recommendations with feedback
/// indicators and filter options.
class GiftHistoryScreen extends ConsumerWidget {
  const GiftHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(giftHistoryNotifierProvider);
    final filter = ref.watch(giftHistoryFilterProvider);

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Gift History',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Filter chips: All / Liked / Didn't Like
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
              bottom: LoloSpacing.spaceXs,
            ),
            child: LoloChipGroup(
              items: const [
                ChipItem(label: 'All'),
                ChipItem(label: 'Liked', icon: Icons.thumb_up),
                ChipItem(label: "Didn't Like", icon: Icons.thumb_down),
              ],
              selectedIndices: {
                if (filter.likedOnly == true)
                  1
                else if (filter.dislikedOnly == true)
                  2
                else
                  0,
              },
              onSelectionChanged: (indices) {
                final idx = indices.first;
                final notifier =
                    ref.read(giftHistoryFilterProvider.notifier);
                if (idx == 0) {
                  notifier.setAll();
                } else if (idx == 1) {
                  notifier.setLikedOnly();
                } else {
                  notifier.setDislikedOnly();
                }
                ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadFirstPage();
              },
              scrollable: true,
            ),
          ),

          // History list
          Expanded(
            child: historyState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (gifts, hasMore, page, isLoadingMore) =>
                  PaginatedListView(
                itemCount: gifts.length,
                isLoading: isLoadingMore,
                hasMore: hasMore,
                onLoadMore: () => ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(giftHistoryNotifierProvider.notifier)
                    .loadFirstPage(),
                emptyState: LoloEmptyState(
                  illustration: const Icon(
                    Icons.card_giftcard_outlined,
                    size: 64,
                    color: LoloColors.gray4,
                  ),
                  title: 'No gift history yet',
                  description:
                      'Browse gifts and get recommendations to build your history.',
                ),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  return _GiftHistoryTile(
                    gift: gift,
                    onTap: () => context.pushNamed(
                      'gift-detail',
                      pathParameters: {'id': gift.id},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A single gift history tile with feedback indicator.
class _GiftHistoryTile extends StatelessWidget {
  const _GiftHistoryTile({
    required this.gift,
    required this.onTap,
  });

  final GiftRecommendationEntity gift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
          vertical: LoloSpacing.spaceSm,
        ),
        child: Row(
          children: [
            // Gift image thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 56,
                height: 56,
                child: gift.imageUrl != null && gift.imageUrl!.isNotEmpty
                    ? Image.network(
                        gift.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _thumbnail(isDark),
                      )
                    : _thumbnail(isDark),
              ),
            ),
            const SizedBox(width: LoloSpacing.spaceSm),

            // Name + date + learning note
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gift.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (gift.createdAt != null)
                    Text(
                      _formatDate(gift.createdAt!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondaryText,
                      ),
                    ),
                  if (gift.learningNote != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 12,
                          color: LoloColors.colorInfo,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            gift.learningNote!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: LoloColors.colorInfo,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Feedback indicator
            _FeedbackBadge(feedback: gift.feedback),
          ],
        ),
      ),
    );
  }

  Widget _thumbnail(bool isDark) => Container(
        color: isDark
            ? LoloColors.darkBorderDefault
            : LoloColors.lightBorderMuted,
        child: Center(
          child: Icon(
            Icons.card_giftcard_outlined,
            size: 24,
            color: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
          ),
        ),
      );

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Small badge showing feedback status: liked, disliked, or none.
class _FeedbackBadge extends StatelessWidget {
  const _FeedbackBadge({this.feedback});
  final bool? feedback;

  @override
  Widget build(BuildContext context) {
    if (feedback == null) {
      return const Icon(
        Icons.remove_circle_outline,
        size: 20,
        color: LoloColors.gray4,
      );
    }

    return Icon(
      feedback! ? Icons.thumb_up : Icons.thumb_down,
      size: 20,
      color: feedback!
          ? LoloColors.colorSuccess
          : LoloColors.colorWarning,
    );
  }
}
