import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_chip_group.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/lolo_loading_widget.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/presentation/providers/memory_provider.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/memory_card.dart';

/// Full memories list with filter chips, search, and grid/list toggle.
class MemoriesScreen extends ConsumerWidget {
  const MemoriesScreen({super.key});

  static const _categoryChips = [
    ChipItem(label: 'All', icon: Icons.apps),
    ChipItem(label: 'Moments', icon: Icons.camera_alt_outlined),
    ChipItem(label: 'Milestones', icon: Icons.emoji_events_outlined),
    ChipItem(label: 'Lessons', icon: Icons.menu_book_outlined),
    ChipItem(label: 'Wishlist', icon: Icons.star_outline),
  ];

  static const _chipToCategory = <int, MemoryCategory?>{
    0: null,
    1: MemoryCategory.moment,
    2: MemoryCategory.milestone,
    3: MemoryCategory.lesson,
    4: MemoryCategory.wishlist,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final memoriesState = ref.watch(memoriesNotifierProvider);

    // Determine selected chip index from category.
    final selectedIdx = _chipToCategory.entries
        .firstWhere(
          (e) => e.value == memoriesState.selectedCategory,
          orElse: () => const MapEntry(0, null),
        )
        .key;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Memory Vault',
        showBackButton: true,
        showSearch: true,
        searchHint: 'Search memories...',
        onSearchChanged: (query) {
          ref.read(memoriesNotifierProvider.notifier).setSearchQuery(query);
        },
        actions: [
          IconButton(
            icon: Icon(
              memoriesState.isGridView ? Icons.view_list : Icons.grid_view,
            ),
            onPressed: () {
              ref.read(memoriesNotifierProvider.notifier).toggleViewMode();
            },
            tooltip: memoriesState.isGridView ? 'List view' : 'Grid view',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/memories/create'),
        backgroundColor: LoloColors.colorPrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: LoloSpacing.spaceSm,
            ),
            child: LoloChipGroup(
              items: _categoryChips,
              selectedIndices: {selectedIdx},
              scrollable: true,
              onSelectionChanged: (indices) {
                final idx = indices.firstOrNull ?? 0;
                ref
                    .read(memoriesNotifierProvider.notifier)
                    .setCategory(_chipToCategory[idx]);
              },
            ),
          ),

          // Content
          Expanded(
            child: memoriesState.isLoading
                ? const Center(child: LoloLoadingWidget())
                : memoriesState.memories.isEmpty
                    ? const LoloEmptyState(
                        icon: Icons.photo_album_outlined,
                        title: 'No memories yet',
                        subtitle:
                            'Start capturing your special moments together',
                      )
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(memoriesNotifierProvider.notifier)
                            .refresh(),
                        child: memoriesState.isGridView
                            ? _buildGridView(memoriesState, context, ref)
                            : _buildListView(memoriesState, context, ref),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(
    MemoriesState state,
    BuildContext context,
    WidgetRef ref,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: LoloSpacing.spaceXs,
        crossAxisSpacing: LoloSpacing.spaceXs,
        childAspectRatio: 0.85,
      ),
      itemCount: state.memories.length,
      itemBuilder: (context, index) {
        final memory = state.memories[index];
        return MemoryVaultCard(
          memory: memory,
          isGridView: true,
          onTap: () => context.push('/memories/${memory.id}'),
          onFavoriteToggle: () => ref
              .read(memoriesNotifierProvider.notifier)
              .toggleFavorite(memory.id),
        );
      },
    );
  }

  Widget _buildListView(
    MemoriesState state,
    BuildContext context,
    WidgetRef ref,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
      itemCount: state.memories.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: LoloSpacing.spaceXs),
      itemBuilder: (context, index) {
        final memory = state.memories[index];
        return MemoryVaultCard(
          memory: memory,
          isGridView: false,
          onTap: () => context.push('/memories/${memory.id}'),
          onFavoriteToggle: () => ref
              .read(memoriesNotifierProvider.notifier)
              .toggleFavorite(memory.id),
        );
      },
    );
  }
}
