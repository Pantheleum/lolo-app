import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/gift_card.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';

/// Screen 24: Gift Detail.
///
/// Displays full gift information including a hero image with
/// parallax effect, AI reasoning card, trait match tags,
/// action row, and related gifts.
class GiftDetailScreen extends ConsumerWidget {
  const GiftDetailScreen({
    required this.giftId,
    super.key,
  });

  final String giftId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(giftDetailNotifierProvider(giftId));

    return Scaffold(
      body: detailState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: LoloColors.colorPrimary),
        ),
        error: (msg) => Center(child: Text(msg)),
        loaded: (gift, relatedGifts) =>
            _GiftDetailBody(
          gift: gift,
          relatedGifts: relatedGifts,
          onToggleSave: () => ref
              .read(giftDetailNotifierProvider(giftId).notifier)
              .toggleSave(),
          onFeedback: (liked) => ref
              .read(giftDetailNotifierProvider(giftId).notifier)
              .submitFeedback(liked),
          onRelatedTap: (id) =>
              context.pushNamed('gift-detail', pathParameters: {'id': id}),
        ),
      ),
    );
  }
}

/// Main scrollable body of the gift detail screen.
class _GiftDetailBody extends StatelessWidget {
  const _GiftDetailBody({
    required this.gift,
    required this.relatedGifts,
    required this.onToggleSave,
    required this.onFeedback,
    required this.onRelatedTap,
  });

  final GiftRecommendationEntity gift;
  final List<GiftRecommendationEntity> relatedGifts;
  final VoidCallback onToggleSave;
  final ValueChanged<bool> onFeedback;
  final ValueChanged<String> onRelatedTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // Hero image with parallax (240dp)
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsetsDirectional.all(4),
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroImage(imageUrl: gift.imageUrl),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: LoloSpacing.spaceLg),

                // Name + price + category
                Text(gift.name, style: theme.textTheme.headlineMedium),
                const SizedBox(height: LoloSpacing.spaceXs),
                Row(
                  children: [
                    Text(
                      gift.priceRange,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: LoloColors.colorAccent,
                      ),
                    ),
                    const SizedBox(width: LoloSpacing.spaceSm),
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        gift.category.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: LoloColors.colorPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: LoloSpacing.spaceXl),

                // "Why She'll Love It" card
                if (gift.whySheLoveIt != null)
                  _ReasoningCard(
                    title: "Why She'll Love It",
                    content: gift.whySheLoveIt!,
                    icon: Icons.auto_awesome,
                  ),

                const SizedBox(height: LoloSpacing.spaceMd),

                // "Based on Her Profile" trait tags
                if (gift.matchedTraits.isNotEmpty) ...[
                  Text(
                    'Based on Her Profile',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: gift.matchedTraits.map((trait) {
                      return Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: LoloColors.colorSuccess.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: LoloColors.colorSuccess,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trait,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: LoloColors.colorSuccess,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXl),
                ],

                // Action row: Buy Now, Save, Not Right
                _ActionRow(
                  gift: gift,
                  onToggleSave: onToggleSave,
                  onFeedback: onFeedback,
                ),

                const SizedBox(height: LoloSpacing.spaceXl),

                // Related gifts
                if (relatedGifts.isNotEmpty) ...[
                  Text(
                    'Related Gifts',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: LoloSpacing.spaceSm),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedGifts.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: LoloSpacing.spaceSm),
                      itemBuilder: (context, index) {
                        final related = relatedGifts[index];
                        return SizedBox(
                          width: 160,
                          child: GiftCard(
                            name: related.name,
                            priceRange: related.priceRange,
                            imageUrl: related.imageUrl,
                            isSaved: related.isSaved,
                            onTap: () => onRelatedTap(related.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                const SizedBox(height: LoloSpacing.space2xl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Hero image with placeholder fallback.
class _HeroImage extends StatelessWidget {
  const _HeroImage({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 240,
        errorBuilder: (_, __, ___) => _placeholder(isDark),
      );
    }
    return _placeholder(isDark);
  }

  Widget _placeholder(bool isDark) => Container(
        width: double.infinity,
        height: 240,
        color: isDark
            ? LoloColors.darkBgTertiary
            : LoloColors.lightBgTertiary,
        child: Center(
          child: Icon(
            Icons.card_giftcard_outlined,
            size: 64,
            color: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
          ),
        ),
      );
}

/// AI reasoning card.
class _ReasoningCard extends StatelessWidget {
  const _ReasoningCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.cardInnerPadding),
      decoration: BoxDecoration(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        border: Border.all(
          color: isDark
              ? LoloColors.darkBorderDefault
              : LoloColors.lightBorderDefault,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: LoloColors.colorPrimary),
              const SizedBox(width: 8),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: isDark
                  ? LoloColors.darkTextSecondary
                  : LoloColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Action row: Buy Now (external), Save (heart), Not Right (thumbs down).
class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.gift,
    required this.onToggleSave,
    required this.onFeedback,
  });

  final GiftRecommendationEntity gift;
  final VoidCallback onToggleSave;
  final ValueChanged<bool> onFeedback;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // Buy Now
        if (gift.buyUrl != null)
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(gift.buyUrl!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.shopping_cart_outlined, size: 18),
              label: const Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: LoloColors.colorPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(0, 44),
              ),
            ),
          ),
        if (gift.buyUrl != null) const SizedBox(width: 8),

        // Save
        _CircleAction(
          icon: gift.isSaved ? Icons.favorite : Icons.favorite_border,
          color: gift.isSaved ? LoloColors.colorError : null,
          tooltip: gift.isSaved ? 'Unsave' : 'Save',
          onTap: onToggleSave,
        ),
        const SizedBox(width: 8),

        // Not Right (thumbs down)
        _CircleAction(
          icon: gift.feedback == false
              ? Icons.thumb_down
              : Icons.thumb_down_outlined,
          color: gift.feedback == false ? LoloColors.colorWarning : null,
          tooltip: 'Not right for her',
          onTap: () => onFeedback(false),
        ),
      ],
    );
  }
}

/// Circular action button for save/feedback actions.
class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    this.color,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final Color? color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final defaultColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: tooltip,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
          ),
          child: Icon(icon, size: 20, color: color ?? defaultColor),
        ),
      ),
    );
  }
}
