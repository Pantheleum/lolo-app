import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/gift_card.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/domain/repositories/gift_repository.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_filter_provider.dart';
import 'package:lolo/features/gift_engine/presentation/providers/gift_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

void _showSuggestDialog(BuildContext context, WidgetRef ref) {
  final occasions = [
    ('Just Because', Icons.favorite),
    ('Birthday', Icons.cake),
    ('Anniversary', Icons.celebration),
    ('Apology', Icons.sentiment_dissatisfied),
    ("Valentine's Day", Icons.favorite_border),
    ('Eid / Holiday', Icons.mosque),
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.all(LoloSpacing.spaceLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).gifts_whatsOccasion,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: LoloSpacing.spaceMd),
          ...occasions.map((o) => ListTile(
                leading: Icon(o.$2, color: LoloColors.colorPrimary),
                title: Text(o.$1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _generateSuggestions(context, ref, o.$1);
                },
              )),
          const SizedBox(height: LoloSpacing.spaceMd),
        ],
      ),
    ),
  );
}

Future<void> _generateSuggestions(
    BuildContext context, WidgetRef ref, String occasion) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Text(AppLocalizations.of(context).gifts_generatingIdeas),
        ],
      ),
      duration: const Duration(seconds: 20),
    ),
  );

  // Try to get device location for locally relevant suggestions
  String? city;
  String? country;
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 5));
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        city = placemarks.first.locality;
        country = placemarks.first.country;
      }
    }
  } catch (_) {
    // Location not available — continue without it
  }

  await ref.read(giftRepositoryProvider).getAiRecommendations(
        occasion: occasion,
        city: city,
        country: country,
      );

  if (context.mounted) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  ref.read(giftBrowseNotifierProvider.notifier).loadFirstPage();
}

/// Screen 23: Gift Browse.
///
/// Displays a searchable, filterable, paginated 2-column grid
/// of gift recommendations. Includes category chips, a low-budget
/// toggle, and a FAB for AI recommendations.
class GiftsScreen extends ConsumerWidget {
  const GiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browseState = ref.watch(giftBrowseNotifierProvider);
    final filter = ref.watch(giftBrowseFilterProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.gifts_screenTitle,
        showBackButton: false,
        showLogo: true,
        showSearch: true,
        searchHint: l10n.gifts_searchHint,
        onSearchChanged: (query) {
          ref.read(giftBrowseFilterProvider.notifier).setSearch(query);
          ref.read(giftBrowseNotifierProvider.notifier).loadFirstPage();
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('gift-history'),
            tooltip: l10n.giftHistory_title,
          ),
        ],
      ),
      floatingActionButton: _AiRecommendFab(
        onPressed: () => _showSuggestDialog(context, ref),
      ),
      body: Column(
        children: [
          // Category chips
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: LoloSpacing.spaceSm,
            ),
            child: LoloChipGroup(
              items: GiftCategory.values
                  .map((c) => ChipItem(label: c.label, icon: c.icon))
                  .toList(),
              selectedIndices: {
                filter.category?.index ?? GiftCategory.all.index,
              },
              onSelectionChanged: (indices) {
                final idx = indices.first;
                ref
                    .read(giftBrowseFilterProvider.notifier)
                    .setCategory(GiftCategory.values[idx]);
                ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage();
              },
              scrollable: true,
            ),
          ),

          // Low Budget toggle
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding,
              vertical: LoloSpacing.spaceXs,
            ),
            child: _LowBudgetToggle(
              isOn: filter.lowBudget,
              onToggle: () {
                ref
                    .read(giftBrowseFilterProvider.notifier)
                    .toggleLowBudget();
                ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage();
              },
            ),
          ),

          // Gift grid
          Expanded(
            child: browseState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: LoloColors.colorPrimary,
                ),
              ),
              error: (msg) => Center(child: Text(msg)),
              loaded: (gifts, hasMore, page, isLoadingMore) =>
                  _GiftGrid(
                gifts: gifts,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
                onLoadMore: () => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadNextPage(),
                onRefresh: () => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .loadFirstPage(),
                onGiftTap: (gift) =>
                    context.pushNamed('gift-detail', pathParameters: {'id': gift.id}, extra: gift),
                onSaveTap: (id) => ref
                    .read(giftBrowseNotifierProvider.notifier)
                    .toggleSave(id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Low-budget high-impact toggle pill.
class _LowBudgetToggle extends StatelessWidget {
  const _LowBudgetToggle({
    required this.isOn,
    required this.onToggle,
  });

  final bool isOn;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isOn
              ? LoloColors.colorAccent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isOn
                ? LoloColors.colorAccent
                : (theme.brightness == Brightness.dark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_offer,
              size: 16,
              color: isOn
                  ? LoloColors.colorAccent
                  : (theme.brightness == Brightness.dark
                      ? LoloColors.darkTextSecondary
                      : LoloColors.lightTextSecondary),
            ),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context).gifts_lowBudget,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isOn
                    ? LoloColors.colorAccent
                    : (theme.brightness == Brightness.dark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary),
                fontWeight: isOn ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2-column grid of GiftCard widgets with infinite scroll.
class _GiftGrid extends StatefulWidget {
  const _GiftGrid({
    required this.gifts,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onGiftTap,
    required this.onSaveTap,
  });

  final List<GiftRecommendationEntity> gifts;
  final bool hasMore;
  final bool isLoadingMore;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;
  final ValueChanged<GiftRecommendationEntity> onGiftTap;
  final ValueChanged<String> onSaveTap;

  @override
  State<_GiftGrid> createState() => _GiftGridState();
}

class _GiftGridState extends State<_GiftGrid> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_isLoadingMore || !widget.hasMore) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      _isLoadingMore = true;
      await widget.onLoadMore();
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gifts.isEmpty) {
      return LoloEmptyState(
        illustration: const Icon(
          Icons.card_giftcard_outlined,
          size: 64,
          color: LoloColors.gray4,
        ),
        title: AppLocalizations.of(context).gifts_noGiftsFound,
        description: AppLocalizations.of(context).gifts_adjustFilters,
      );
    }

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: LoloColors.colorPrimary,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsetsDirectional.all(
          LoloSpacing.screenHorizontalPadding,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: LoloSpacing.spaceSm,
          crossAxisSpacing: LoloSpacing.spaceSm,
          childAspectRatio: 0.75,
        ),
        itemCount: widget.gifts.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.gifts.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsetsDirectional.all(16),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: LoloColors.colorPrimary,
                ),
              ),
            );
          }

          final gift = widget.gifts[index];
          return GiftCard(
            name: gift.name,
            priceRange: gift.priceRange,
            imageUrl: gift.imageUrl,
            reasoning: gift.whySheLoveIt,
            isSaved: gift.isSaved,
            onSave: () => widget.onSaveTap(gift.id),
            onTap: () => widget.onGiftTap(gift),
          );
        },
      ),
    );
  }
}

/// FAB for triggering AI gift recommendations.
class _AiRecommendFab extends StatelessWidget {
  const _AiRecommendFab({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LoloGradients.premium,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: LoloColors.colorPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).gifts_getAiRecommendations,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
