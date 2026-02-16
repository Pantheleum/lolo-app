import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/paginated_list_view.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_history_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Screen 22: Message History.
///
/// Shows a searchable, filterable, paginated list of past
/// generated messages. Tapping a message expands it inline
/// with copy/share actions.
class MessageHistoryScreen extends ConsumerStatefulWidget {
  const MessageHistoryScreen({super.key});

  @override
  ConsumerState<MessageHistoryScreen> createState() =>
      _MessageHistoryScreenState();
}

class _MessageHistoryScreenState
    extends ConsumerState<MessageHistoryScreen> {
  String? _expandedMessageId;

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(messageHistoryNotifierProvider);
    final filter = ref.watch(messageHistoryFilterProvider);

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Message History',
        showBackButton: true,
        showSearch: true,
        searchHint: 'Search messages...',
        onSearchChanged: (query) {
          ref.read(messageHistoryFilterProvider.notifier).setSearch(query);
          ref.read(messageHistoryNotifierProvider.notifier).loadFirstPage();
        },
      ),
      body: Column(
        children: [
          // Filter chips row
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
              bottom: LoloSpacing.spaceXs,
            ),
            child: _FilterChipsRow(
              currentFilter: filter,
              onFilterChanged: (favOnly, mode) {
                ref
                    .read(messageHistoryFilterProvider.notifier)
                    .setFavoritesOnly(favOnly);
                ref
                    .read(messageHistoryFilterProvider.notifier)
                    .setModeFilter(mode);
                ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadFirstPage();
              },
            ),
          ),

          // Message list
          Expanded(
            child: historyState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (messages, hasMore, page, isLoadingMore) =>
                  PaginatedListView(
                itemCount: messages.length,
                isLoading: isLoadingMore,
                hasMore: hasMore,
                onLoadMore: () => ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(messageHistoryNotifierProvider.notifier)
                    .loadFirstPage(),
                emptyState: LoloEmptyState(
                  illustration: const Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: LoloColors.gray4,
                  ),
                  title: 'No messages yet',
                  description:
                      'Generate your first message to see it here!',
                  ctaLabel: 'Generate Now',
                  onCtaTap: () => Navigator.of(context).pop(),
                ),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isExpanded =
                      _expandedMessageId == message.id;

                  return _MessageHistoryTile(
                    message: message,
                    isExpanded: isExpanded,
                    onTap: () => setState(() {
                      _expandedMessageId =
                          isExpanded ? null : message.id;
                    }),
                    onCopy: () => _copyMessage(context, message.content),
                    onShare: () => Share.share(message.content),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyMessage(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Filter chips: All, Favorites, then one per MessageMode.
class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final ({bool? favoritesOnly, MessageMode? mode, String? search}) currentFilter;
  final void Function(bool? favoritesOnly, MessageMode? mode) onFilterChanged;

  @override
  Widget build(BuildContext context) {
    // Build chip items: All + Favorites + each mode
    final items = <ChipItem>[
      const ChipItem(label: 'All'),
      const ChipItem(label: 'Favorites', icon: Icons.favorite),
      ...MessageMode.values.map(
        (m) => ChipItem(
          label: m.name[0].toUpperCase() + m.name.substring(1),
          icon: m.icon,
        ),
      ),
    ];

    // Determine selected index
    int selectedIndex;
    if (currentFilter.favoritesOnly == true) {
      selectedIndex = 1;
    } else if (currentFilter.mode != null) {
      selectedIndex = 2 + currentFilter.mode!.index;
    } else {
      selectedIndex = 0;
    }

    return LoloChipGroup(
      items: items,
      selectedIndices: {selectedIndex},
      onSelectionChanged: (indices) {
        final idx = indices.first;
        if (idx == 0) {
          onFilterChanged(null, null);
        } else if (idx == 1) {
          onFilterChanged(true, null);
        } else {
          onFilterChanged(null, MessageMode.values[idx - 2]);
        }
      },
      scrollable: true,
    );
  }
}

/// A single message history tile with expandable content.
class _MessageHistoryTile extends StatelessWidget {
  const _MessageHistoryTile({
    required this.message,
    required this.isExpanded,
    required this.onTap,
    required this.onCopy,
    required this.onShare,
  });

  final GeneratedMessageEntity message;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onCopy;
  final VoidCallback onShare;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: mode badge + date + stars
            Row(
              children: [
                // Mode badge
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(message.mode.icon, size: 12,
                        color: LoloColors.colorPrimary),
                      const SizedBox(width: 4),
                      Text(
                        message.mode.name[0].toUpperCase() +
                            message.mode.name.substring(1),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: LoloColors.colorPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Rating stars (compact)
                if (message.rating > 0)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      message.rating,
                      (_) => const Icon(
                        Icons.star,
                        size: 12,
                        color: LoloColors.colorAccent,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                // Date
                Text(
                  _formatDate(message.createdAt),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: secondaryText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Preview (2 lines) or full content
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                message.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    message.content,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  // Expanded action row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: onCopy,
                        tooltip: 'Copy',
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined, size: 18),
                        onPressed: onShare,
                        tooltip: 'Share',
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      if (message.isFavorite)
                        const Icon(
                          Icons.favorite,
                          size: 16,
                          color: LoloColors.colorError,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
