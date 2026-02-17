import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/presentation/providers/memory_provider.dart';

/// Wish List screen (Screen 38) — filtered view of memories tagged as wishes.
/// Shows status chips, "Send to Gift Engine" CTA, and sort controls.
class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  _SortMode _sortMode = _SortMode.newest;

  @override
  Widget build(BuildContext context) {
    final memoriesState = ref.watch(memoriesNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Filter to wishlist items only
    final wishes = memoriesState.memories
        .where((m) => m.category == MemoryCategory.wishlist)
        .toList();

    // Sort
    switch (_sortMode) {
      case _SortMode.newest:
        wishes.sort((a, b) => b.date.compareTo(a.date));
      case _SortMode.occasion:
        // Sort by date ascending (oldest first = closest upcoming occasion)
        wishes.sort((a, b) => a.date.compareTo(b.date));
    }

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Wish List',
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortSheet(context),
            tooltip: 'Sort',
          ),
        ],
      ),
      body: memoriesState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishes.isEmpty
              ? const Center(
                  child: LoloEmptyState(
                    icon: Icons.star_outline,
                    title: 'No wishes captured yet',
                    description:
                        "When she mentions something she wants, save it with the 'She Said' toggle.",
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(memoriesNotifierProvider.notifier).refresh(),
                  color: LoloColors.colorPrimary,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(
                        LoloSpacing.screenHorizontalPadding),
                    itemCount: wishes.length,
                    itemBuilder: (_, i) => _WishCard(
                      wish: wishes[i],
                      onSendToGifts: () => _sendToGiftEngine(context, wishes[i]),
                    ),
                  ),
                ),
    );
  }

  void _showSortSheet(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor:
          isDark ? LoloColors.darkBgSecondary : LoloColors.lightBgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? LoloColors.darkBorderDefault
                      : LoloColors.lightBorderDefault,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ListTile(
              title: const Text('Newest First'),
              trailing: _sortMode == _SortMode.newest
                  ? const Icon(Icons.check, color: LoloColors.colorPrimary)
                  : null,
              onTap: () {
                setState(() => _sortMode = _SortMode.newest);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('By Occasion Proximity'),
              trailing: _sortMode == _SortMode.occasion
                  ? const Icon(Icons.check, color: LoloColors.colorPrimary)
                  : null,
              onTap: () {
                setState(() => _sortMode = _SortMode.occasion);
                Navigator.pop(ctx);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _sendToGiftEngine(BuildContext context, Memory wish) {
    // Show snackbar first (before navigation which may invalidate context)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sent "${wish.title}" to Gift Engine'),
        backgroundColor: LoloColors.colorSuccess,
      ),
    );
    context.pushNamed('gifts');
  }
}

enum _SortMode { newest, occasion }

class _WishCard extends StatelessWidget {
  const _WishCard({
    required this.wish,
    required this.onSendToGifts,
  });

  final Memory wish;
  final VoidCallback onSendToGifts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = _wishStatus(wish);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Wish text + status chip
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  wish.title,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 8),
              _StatusChip(status: status, isDark: isDark),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2: Date captured
          Text(
            _formatDate(wish.date),
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? LoloColors.darkTextTertiary
                  : LoloColors.lightTextTertiary,
            ),
          ),

          // Row 3: Description (source context)
          if (wish.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              wish.description,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: isDark
                    ? LoloColors.darkTextSecondary
                    : LoloColors.lightTextSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          // Row 4: Send to Gift Engine button (only for "new" status)
          if (status == _WishStatus.newWish) ...[
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.tonal(
                onPressed: onSendToGifts,
                style: FilledButton.styleFrom(
                  backgroundColor: LoloColors.colorAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: theme.textTheme.labelMedium,
                ),
                child: const Text('Send to Gift Engine'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  _WishStatus _wishStatus(Memory wish) {
    // Determine status based on tags — in production this would be a proper field
    if (wish.tags.contains('fulfilled')) return _WishStatus.fulfilled;
    if (wish.tags.contains('sent_to_gifts')) return _WishStatus.sentToGifts;
    return _WishStatus.newWish;
  }

  String _formatDate(DateTime d) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }
}

enum _WishStatus { newWish, sentToGifts, fulfilled }

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.isDark});
  final _WishStatus status;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      _WishStatus.newWish => ('New', LoloColors.colorPrimary),
      _WishStatus.sentToGifts => ('Sent to Gifts', LoloColors.colorWarning),
      _WishStatus.fulfilled => ('Fulfilled', LoloColors.colorSuccess),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.15 : 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
