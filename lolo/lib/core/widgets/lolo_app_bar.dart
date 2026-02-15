import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// LOLO app bar with back navigation, title, and trailing actions.
///
/// Supports two modes:
/// - Standard: back arrow (auto-mirrors in RTL) + title + optional actions.
/// - Search: expands to a full-width search field.
///
/// The back arrow auto-mirrors in RTL via Flutter's built-in icon mirroring
/// for [Icons.arrow_back].
class LoloAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LoloAppBar({
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.actions = const [],
    this.centerTitle = false,
    this.showLogo = false,
    this.showSearch = false,
    this.onSearchChanged,
    this.searchHint,
    this.semanticLabel,
    super.key,
  });

  /// Screen title text.
  final String title;

  /// Whether to show the leading back arrow.
  final bool showBackButton;

  /// Custom back action. Defaults to [Navigator.pop].
  final VoidCallback? onBack;

  /// Trailing action widgets (max 2 recommended).
  final List<Widget> actions;

  /// Center the title text.
  final bool centerTitle;

  /// Show LOLO compass mark instead of back arrow.
  final bool showLogo;

  /// Enable search variant with an expandable text field.
  final bool showSearch;

  /// Callback for search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Hint text for the search field.
  final String? searchHint;

  /// Accessibility label for the app bar.
  final String? semanticLabel;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  State<LoloAppBar> createState() => _LoloAppBarState();
}

class _LoloAppBarState extends State<LoloAppBar> {
  bool _isSearching = false;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged?.call('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? LoloColors.darkBorderMuted
        : LoloColors.lightBorderMuted;

    Widget? leading;
    if (widget.showLogo) {
      leading = Padding(
        padding: const EdgeInsetsDirectional.only(start: 12),
        child: Icon(
          Icons.explore,
          color: LoloColors.colorPrimary,
          size: 28,
          semanticLabel: 'LOLO',
        ),
      );
    } else if (widget.showBackButton) {
      leading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      );
    }

    return Semantics(
      label: widget.semanticLabel ?? widget.title,
      header: true,
      child: AppBar(
        leading: leading,
        title: _isSearching ? _buildSearchField() : Text(widget.title),
        centerTitle: widget.centerTitle,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          if (widget.showSearch)
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: _toggleSearch,
              tooltip: _isSearching ? 'Close search' : 'Search',
            ),
          ...widget.actions,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: borderColor),
        ),
      ),
    );
  }

  Widget _buildSearchField() => TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: widget.onSearchChanged,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.searchHint ?? 'Search...',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
          contentPadding: EdgeInsetsDirectional.zero,
        ),
      );
}
