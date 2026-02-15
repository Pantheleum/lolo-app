import 'package:flutter/material.dart';
import 'package:lolo/core/widgets/lolo_loading_widget.dart';

/// Callback type for loading the next page.
typedef PageLoader = Future<void> Function();

/// Infinite-scroll list with pull-to-refresh, loading indicator,
/// and empty state integration.
///
/// Triggers [onLoadMore] when the user scrolls within [loadMoreThreshold]
/// pixels of the bottom. Shows [emptyState] when [itemCount] is 0 and
/// not loading.
class PaginatedListView extends StatefulWidget {
  const PaginatedListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.onRefresh,
    this.isLoading = false,
    this.hasMore = true,
    this.emptyState,
    this.loadMoreThreshold = 200,
    this.padding,
    this.separatorBuilder,
    this.header,
    this.semanticLabel,
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final PageLoader onLoadMore;
  final RefreshCallback onRefresh;
  final bool isLoading;
  final bool hasMore;
  final Widget? emptyState;
  final double loadMoreThreshold;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder? separatorBuilder;
  /// Optional header widget above the list.
  final Widget? header;
  final String? semanticLabel;

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
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
    if (_isLoadingMore || !widget.hasMore || widget.isLoading) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= widget.loadMoreThreshold) {
      _isLoadingMore = true;
      await widget.onLoadMore();
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Empty state
    if (widget.itemCount == 0 && !widget.isLoading) {
      if (widget.emptyState != null) {
        return RefreshIndicator(
          onRefresh: widget.onRefresh,
          color: Theme.of(context).colorScheme.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(hasScrollBody: false, child: widget.emptyState!),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    }

    // Total items: header(0-1) + items + loading footer(0-1)
    final headerCount = widget.header != null ? 1 : 0;
    final footerCount = (widget.isLoading || widget.hasMore) ? 1 : 0;
    final totalCount = headerCount + widget.itemCount + footerCount;

    return Semantics(
      label: widget.semanticLabel,
      child: RefreshIndicator(
        onRefresh: widget.onRefresh,
        color: Theme.of(context).colorScheme.primary,
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: widget.padding ?? const EdgeInsetsDirectional.all(16),
          itemCount: totalCount,
          itemBuilder: (ctx, index) {
            // Header
            if (widget.header != null && index == 0) return widget.header!;

            // Loading footer
            if (index == totalCount - 1 && footerCount == 1) {
              return const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                child: LoloLoadingWidget(size: 24),
              );
            }

            // Content items
            final itemIndex = index - headerCount;
            if (widget.separatorBuilder != null && itemIndex > 0) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                widget.separatorBuilder!(ctx, itemIndex - 1),
                widget.itemBuilder(ctx, itemIndex),
              ]);
            }
            return widget.itemBuilder(ctx, itemIndex);
          },
        ),
      ),
    );
  }
}
