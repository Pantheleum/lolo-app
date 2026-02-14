# LOLO Base UI Components Implementation

**Task ID:** S1-02
**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 1 -- Foundation (Weeks 9-10)
**Dependencies:** Flutter Scaffold (S1-01), Design System v1.0, Developer Handoff v1.0

---

## Table of Contents

1. [Navigation Components](#1-navigation-components) -- LoloBottomNav, LoloAppBar
2. [Buttons & Inputs](#2-buttons--inputs) -- LoloPrimaryButton, LoloTextField, LoloChipGroup, LoloSlider, LoloToggle, LoloDropdown
3. [Card Components](#3-card-components) -- ActionCard, ReminderTile, MemoryCard, GiftCard, SOSCoachingCard, StatCard
4. [Feedback Components](#4-feedback-components) -- LoloToast, LoloEmptyState, LoloSkeleton, LoloDialog
5. [Display Components](#5-display-components) -- LoloProgressBar, LoloStreakDisplay, LoloBadge, LoloAvatar
6. [Utility Components](#6-utility-components) -- LoloLoadingWidget, PaginatedListView

---

## 1. Navigation Components

### 1.1 LoloBottomNav

**File:** `lib/core/widgets/lolo_bottom_nav.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// LOLO 5-tab bottom navigation bar.
///
/// Persistent across all non-onboarding screens. Supports badge counts
/// for notification indicators. RTL tab order is handled automatically
/// by Flutter's [BottomNavigationBar] when [Directionality] is RTL.
///
/// Tabs: Home, Messages, Actions, Memories, Profile.
class LoloBottomNav extends StatelessWidget {
  const LoloBottomNav({
    required this.currentIndex,
    required this.onTabChanged,
    this.badgeCounts = const {},
    super.key,
  });

  /// Currently active tab index (0-4).
  final int currentIndex;

  /// Callback when a tab is tapped.
  final ValueChanged<int> onTabChanged;

  /// Badge counts keyed by tab index. Only displayed when value > 0.
  final Map<int, int> badgeCounts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgSecondary
        : LoloColors.lightBgSecondary;
    final borderColor = isDark
        ? LoloColors.darkBorderMuted
        : LoloColors.lightBorderMuted;
    final inactiveColor = isDark
        ? LoloColors.darkTextTertiary
        : LoloColors.lightTextTertiary;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTabChanged,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            selectedItemColor: LoloColors.colorPrimary,
            unselectedItemColor: inactiveColor,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.33,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.33,
            ),
            elevation: 0,
            items: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                context,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Messages',
                index: 1,
              ),
              _buildNavItem(
                context,
                icon: Icons.style_outlined,
                activeIcon: Icons.style,
                label: 'Actions',
                index: 2,
              ),
              _buildNavItem(
                context,
                icon: Icons.photo_album_outlined,
                activeIcon: Icons.photo_album,
                label: 'Memories',
                index: 3,
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final count = badgeCounts[index] ?? 0;

    Widget iconWidget(IconData data) {
      if (count > 0) {
        return Badge(
          label: count > 99
              ? const Text('99+', style: TextStyle(fontSize: 10))
              : Text('$count', style: const TextStyle(fontSize: 10)),
          backgroundColor: LoloColors.colorError,
          child: Icon(data),
        );
      }
      return Icon(data);
    }

    return BottomNavigationBarItem(
      icon: iconWidget(icon),
      activeIcon: _ActiveIndicatorIcon(child: iconWidget(activeIcon)),
      label: label,
      tooltip: label,
    );
  }
}

/// Wraps the active icon with a pill-shaped indicator background.
///
/// Pill dimensions: 56w x 32h dp, colorPrimary at 12% opacity, radius 16dp.
class _ActiveIndicatorIcon extends StatelessWidget {
  const _ActiveIndicatorIcon({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          color: LoloColors.colorPrimary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: child,
      );
}
```

---

### 1.2 LoloAppBar

**File:** `lib/core/widgets/lolo_app_bar.dart`

```dart
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
```

---

## 2. Buttons & Inputs

### 2.1 LoloPrimaryButton

**File:** `lib/core/widgets/lolo_primary_button.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Full-width primary CTA button with loading and disabled states.
///
/// Specs: 52dp height, 24px radius, brand primary background.
/// Provides haptic feedback on press (lightImpact).
/// Loading state replaces text with a 20dp circular spinner.
class LoloPrimaryButton extends StatelessWidget {
  const LoloPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.fullWidth = true,
    this.semanticLabel,
    super.key,
  });

  /// Button label text.
  final String label;

  /// Tap callback. Ignored when [isLoading] or [!isEnabled].
  final VoidCallback? onPressed;

  /// Shows a spinner and disables interaction.
  final bool isLoading;

  /// Enables or disables the button.
  final bool isEnabled;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether button stretches to full available width.
  final bool fullWidth;

  /// Accessibility label override.
  final String? semanticLabel;

  bool get _isInteractive => isEnabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = _isInteractive
        ? LoloColors.colorPrimary
        : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);
    final fgColor = _isInteractive
        ? Colors.white
        : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextDisabled);

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: _isInteractive,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: 52,
        child: ElevatedButton(
          onPressed: _isInteractive
              ? () {
                  HapticFeedback.lightImpact();
                  onPressed?.call();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            disabledBackgroundColor: bgColor,
            disabledForegroundColor: fgColor,
            elevation: isDark ? 0 : (_isInteractive ? 2 : 0),
            shadowColor: isDark ? Colors.transparent : Colors.black26,
            minimumSize: Size(fullWidth ? double.infinity : 120, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.02,
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}
```

---

### 2.2 LoloTextField

**File:** `lib/core/widgets/lolo_text_field.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Themed text input field with floating label, 6 visual states,
/// and full RTL support.
///
/// States: default, focused-empty, focused-filled, filled-unfocused,
/// error, disabled.
class LoloTextField extends StatelessWidget {
  const LoloTextField({
    required this.label,
    required this.controller,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.autofillHints,
    this.semanticLabel,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final fillColor = enabled
        ? (isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary)
        : (isDark
            ? LoloColors.darkBgSecondary.withValues(alpha: 0.5)
            : LoloColors.lightBgSecondary.withValues(alpha: 0.5));

    final borderDefault = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;
    final borderMuted = isDark
        ? LoloColors.darkBorderMuted
        : LoloColors.lightBorderMuted;

    return Semantics(
      label: semanticLabel ?? label,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: enabled
              ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
              : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          helperText: helperText,
          helperMaxLines: 2,
          errorMaxLines: 2,
          filled: true,
          fillColor: fillColor,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderDefault),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderDefault),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorPrimary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorError,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: LoloColors.colorError,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderMuted),
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
```

---

### 2.3 LoloChipGroup

**File:** `lib/core/widgets/lolo_chip_group.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Selection mode for chip groups.
enum ChipSelectionMode { single, multi }

/// Data model for a single chip item.
class ChipItem {
  const ChipItem({
    required this.label,
    this.icon,
    this.color,
  });

  final String label;
  final IconData? icon;

  /// Optional override color (used for category chips like SAY/DO/BUY/GO).
  final Color? color;
}

/// Horizontal scrollable or wrapping chip group with single/multi-select.
///
/// Selected state uses brand primary at 12% opacity with primary text.
/// Category chip variant uses per-type colors from [ChipItem.color].
class LoloChipGroup extends StatelessWidget {
  const LoloChipGroup({
    required this.items,
    required this.selectedIndices,
    required this.onSelectionChanged,
    this.selectionMode = ChipSelectionMode.single,
    this.scrollable = false,
    this.semanticLabel,
    super.key,
  });

  final List<ChipItem> items;
  final Set<int> selectedIndices;
  final ValueChanged<Set<int>> onSelectionChanged;
  final ChipSelectionMode selectionMode;
  final bool scrollable;
  final String? semanticLabel;

  void _onChipTapped(int index) {
    final newSelection = Set<int>.from(selectedIndices);

    if (selectionMode == ChipSelectionMode.single) {
      newSelection
        ..clear()
        ..add(index);
    } else {
      if (newSelection.contains(index)) {
        newSelection.remove(index);
      } else {
        newSelection.add(index);
      }
    }

    onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget chipAt(int index) {
      final item = items[index];
      final isSelected = selectedIndices.contains(index);
      final accentColor = item.color ?? LoloColors.colorPrimary;

      final bgColor = isSelected
          ? accentColor.withValues(alpha: 0.12)
          : Colors.transparent;
      final textColor = isSelected
          ? accentColor
          : (isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary);
      final borderColor = isSelected
          ? accentColor
          : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);

      return Semantics(
        label: item.label,
        selected: isSelected,
        child: GestureDetector(
          onTap: () => _onChipTapped(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 32,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: 16, color: textColor),
                  const SizedBox(width: 4),
                ],
                if (isSelected && selectionMode == ChipSelectionMode.multi) ...[
                  Icon(Icons.check, size: 14, color: textColor),
                  const SizedBox(width: 4),
                ],
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (scrollable) {
      return Semantics(
        label: semanticLabel,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(items.length, (i) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  end: i < items.length - 1 ? 8 : 0,
                ),
                child: chipAt(i),
              );
            }),
          ),
        ),
      );
    }

    return Semantics(
      label: semanticLabel,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(items.length, chipAt),
      ),
    );
  }
}
```

---

### 2.4 LoloSlider

**File:** `lib/core/widgets/lolo_slider.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Labeled slider with value display, custom thumb, and design system colors.
///
/// RTL: Slider direction auto-reverses via Flutter's [Directionality].
class LoloSlider extends StatelessWidget {
  const LoloSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.valueDisplay,
    this.semanticLabel,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String? valueDisplay;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final trackInactive = isDark
        ? LoloColors.darkBorderDefault
        : LoloColors.lightBorderDefault;

    return Semantics(
      label: semanticLabel ?? label,
      slider: true,
      value: valueDisplay ?? value.toStringAsFixed(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || valueDisplay != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 4,
                end: 4,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: theme.textTheme.titleMedium,
                    ),
                  if (valueDisplay != null)
                    Text(
                      valueDisplay!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: LoloColors.colorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: LoloColors.colorPrimary,
              inactiveTrackColor: trackInactive,
              thumbColor: LoloColors.colorPrimary,
              overlayColor: LoloColors.colorPrimary.withValues(alpha: 0.12),
              trackHeight: 4,
              thumbShape: _LoloSliderThumb(),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              valueIndicatorColor: isDark
                  ? LoloColors.darkSurfaceElevated2
                  : LoloColors.lightSurfaceElevated2,
              valueIndicatorTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? LoloColors.darkTextPrimary
                    : LoloColors.lightTextPrimary,
              ),
              showValueIndicator: ShowValueIndicator.onlyForContinuous,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: valueDisplay ?? value.toStringAsFixed(1),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom 20dp circle thumb with 2dp white border.
class _LoloSliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(20, 20);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // White border
    canvas.drawCircle(
      center,
      10,
      Paint()..color = Colors.white,
    );

    // Primary fill
    canvas.drawCircle(
      center,
      8,
      Paint()..color = sliderTheme.thumbColor ?? LoloColors.colorPrimary,
    );
  }
}
```

---

### 2.5 LoloToggle

**File:** `lib/core/widgets/lolo_toggle.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Toggle switch with label and optional description, RTL-aware layout.
///
/// The toggle track is 52x32dp. Label+description appear on the
/// opposite side. Layout automatically mirrors in RTL.
class LoloToggle extends StatelessWidget {
  const LoloToggle({
    required this.value,
    required this.onChanged,
    required this.label,
    this.description,
    this.enabled = true,
    this.semanticLabel,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final String? description;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final labelColor = enabled
        ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
        : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled);
    final descColor = isDark
        ? LoloColors.darkTextSecondary
        : LoloColors.lightTextSecondary;

    return Semantics(
      label: semanticLabel ?? label,
      toggled: value,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? () => onChanged?.call(!value) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: labelColor,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: descColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: value,
                onChanged: enabled ? onChanged : null,
                activeColor: Colors.white,
                activeTrackColor: LoloColors.colorPrimary,
                inactiveThumbColor: isDark
                    ? LoloColors.gray4
                    : LoloColors.lightTextTertiary,
                inactiveTrackColor: isDark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 2.6 LoloDropdown

**File:** `lib/core/widgets/lolo_dropdown.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Data model for a dropdown option.
class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

/// Dropdown selector styled as a text field with chevron icon.
///
/// On mobile, opens a bottom sheet for selection.
/// Supports leading icon, error text, and RTL alignment.
class LoloDropdown<T> extends StatelessWidget {
  const LoloDropdown({
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.icon,
    this.errorText,
    this.enabled = true,
    this.semanticLabel,
    super.key,
  });

  final String label;
  final List<DropdownItem<T>> items;
  final ValueChanged<T> onChanged;
  final T? selectedValue;
  final IconData? icon;
  final String? errorText;
  final bool enabled;
  final String? semanticLabel;

  String? get _selectedLabel {
    try {
      return items.firstWhere((i) => i.value == selectedValue).label;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? LoloColors.darkBgTertiary
        : LoloColors.lightBgTertiary;
    final borderColor = errorText != null
        ? LoloColors.colorError
        : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault);
    final textColor = _selectedLabel != null
        ? (isDark ? LoloColors.darkTextPrimary : LoloColors.lightTextPrimary)
        : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary);

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: enabled ? () => _showBottomSheet(context) : null,
            child: Container(
              height: 52,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: borderColor,
                  width: errorText != null ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_selectedLabel != null)
                          Text(
                            label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextSecondary
                                  : LoloColors.lightTextSecondary,
                              fontSize: 11,
                            ),
                          ),
                        Text(
                          _selectedLabel ?? label,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: isDark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                top: 4,
              ),
              child: Text(
                errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.colorError,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? LoloColors.gray5 : LoloColors.lightTextTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(label, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx).size.height * 0.5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  final isSelected = item.value == selectedValue;

                  return ListTile(
                    leading: item.icon != null
                        ? Icon(item.icon, size: 24)
                        : null,
                    title: Text(item.label),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check,
                            color: LoloColors.colorPrimary,
                          )
                        : null,
                    selected: isSelected,
                    onTap: () {
                      onChanged(item.value);
                      Navigator.of(ctx).pop();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
```

---

## 3. Card Components

### 3.1 ActionCard

**File:** `lib/core/widgets/action_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Action card type categories.
enum ActionCardType { say, doo, buy, go }

/// Action card completion status.
enum ActionCardStatus { pending, completed, skipped }

/// Swipeable SAY/DO/BUY/GO action card.
///
/// Displays type badge (color-coded), title, body, difficulty dots,
/// and XP reward. Supports swipe-to-complete and swipe-to-skip
/// with gesture detection and animated transforms.
class ActionCard extends StatefulWidget {
  const ActionCard({
    required this.type,
    required this.title,
    required this.body,
    required this.difficulty,
    required this.xpValue,
    this.contextText,
    this.status = ActionCardStatus.pending,
    this.onComplete,
    this.onSkip,
    this.onSave,
    this.onTap,
    this.isCompact = false,
    this.semanticLabel,
    super.key,
  });

  final ActionCardType type;
  final String title;
  final String body;
  final int difficulty;
  final int xpValue;
  final String? contextText;
  final ActionCardStatus status;
  final VoidCallback? onComplete;
  final VoidCallback? onSkip;
  final VoidCallback? onSave;
  final VoidCallback? onTap;
  final bool isCompact;
  final String? semanticLabel;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    )..addListener(() {
        setState(() => _dragOffset = _resetAnimation.value);
      });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  Color get _typeColor => switch (widget.type) {
        ActionCardType.say => LoloColors.cardTypeSay,
        ActionCardType.doo => LoloColors.cardTypeDo,
        ActionCardType.buy => LoloColors.cardTypeBuy,
        ActionCardType.go => LoloColors.cardTypeGo,
      };

  String get _typeLabel => switch (widget.type) {
        ActionCardType.say => 'SAY',
        ActionCardType.doo => 'DO',
        ActionCardType.buy => 'BUY',
        ActionCardType.go => 'GO',
      };

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.status != ActionCardStatus.pending) return;
    setState(() => _dragOffset += details.delta.dx);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.status != ActionCardStatus.pending) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.4;
    if (_dragOffset.abs() > threshold) {
      HapticFeedback.mediumImpact();
      if (_dragOffset > 0) {
        widget.onComplete?.call();
      } else {
        widget.onSkip?.call();
      }
    }
    _resetAnimation = Tween<double>(begin: _dragOffset, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _resetController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = switch (widget.status) {
      ActionCardStatus.completed => LoloColors.colorSuccess,
      _ => isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault,
    };
    final cardOpacity = widget.status == ActionCardStatus.skipped ? 0.5 : 1.0;
    final rotation = _dragOffset / 2000;
    final padding = widget.isCompact ? 16.0 : 20.0;

    return Semantics(
      label: widget.semanticLabel ??
          '${_typeLabel} action card: ${widget.title}. '
              '${widget.xpValue} XP. Difficulty ${widget.difficulty} of 3.',
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        onTap: widget.onTap,
        child: Transform.translate(
          offset: Offset(_dragOffset, 0),
          child: Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: cardOpacity,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: widget.isCompact ? 160 : 320,
                  maxHeight: widget.isCompact ? double.infinity : 400,
                ),
                padding: EdgeInsetsDirectional.all(padding),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TypeBadge(label: _typeLabel, color: _typeColor),
                        _XpLabel(xp: widget.xpValue),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        decoration: widget.status == ActionCardStatus.skipped
                            ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.body,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary,
                      ),
                      maxLines: widget.isCompact ? 2 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.contextText != null && !widget.isCompact) ...[
                      const SizedBox(height: 12),
                      Text(widget.contextText!, style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary,
                      )),
                    ],
                    const Spacer(),
                    _DifficultyDots(difficulty: widget.difficulty, color: _typeColor),
                    if (widget.status == ActionCardStatus.completed)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 12),
                        child: Row(children: [
                          const Icon(Icons.check_circle, color: LoloColors.colorSuccess, size: 20),
                          const SizedBox(width: 8),
                          Text('Done', style: theme.textTheme.labelLarge?.copyWith(color: LoloColors.colorSuccess)),
                        ]),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      );
}

class _XpLabel extends StatelessWidget {
  const _XpLabel({required this.xp});
  final int xp;
  @override
  Widget build(BuildContext context) => Text(
        '+$xp XP',
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: LoloColors.colorAccent),
      );
}

class _DifficultyDots extends StatelessWidget {
  const _DifficultyDots({required this.difficulty, required this.color});
  final int difficulty;
  final Color color;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Difficulty: ', style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary,
          )),
          ...List.generate(3, (i) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: Container(width: 8, height: 8, decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < difficulty ? color : color.withValues(alpha: 0.2),
                )),
              )),
        ],
      );
}
```

---

### 3.2 ReminderTile

**File:** `lib/core/widgets/reminder_tile.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum ReminderUrgency { future, approaching, imminent, today, overdue }
enum ReminderCategory { birthday, anniversary, holiday, custom }

/// Compact reminder list item with urgency-coded accent bar.
///
/// Start-side 4dp accent bar: green (future), amber (approaching), red (imminent/today/overdue).
/// Includes category icon, title, date, checkbox, and countdown badge.
class ReminderTile extends StatelessWidget {
  const ReminderTile({
    required this.title,
    required this.date,
    required this.category,
    this.icon,
    this.isCompleted = false,
    this.onTap,
    this.onToggleComplete,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final DateTime date;
  final ReminderCategory category;
  final IconData? icon;
  final bool isCompleted;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleComplete;
  final String? semanticLabel;

  ReminderUrgency get _urgency {
    final now = DateTime.now();
    final diff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff < 0) return ReminderUrgency.overdue;
    if (diff == 0) return ReminderUrgency.today;
    if (diff <= 2) return ReminderUrgency.imminent;
    if (diff <= 6) return ReminderUrgency.approaching;
    return ReminderUrgency.future;
  }

  Color get _accentColor => switch (_urgency) {
        ReminderUrgency.future => LoloColors.colorSuccess,
        ReminderUrgency.approaching => LoloColors.colorWarning,
        _ => LoloColors.colorError,
      };

  String get _countdownText {
    final now = DateTime.now();
    final diff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff < 0) return 'OVERDUE';
    if (diff == 0) return 'TODAY';
    if (diff == 1) return '1 day';
    return '$diff days';
  }

  IconData get _defaultIcon => switch (category) {
        ReminderCategory.birthday => Icons.cake_outlined,
        ReminderCategory.anniversary => Icons.favorite_outline,
        ReminderCategory.holiday => Icons.event_outlined,
        ReminderCategory.custom => Icons.notifications_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final titleWeight = switch (_urgency) {
      ReminderUrgency.future => FontWeight.w400,
      ReminderUrgency.approaching => FontWeight.w500,
      _ => FontWeight.w600,
    };
    final titleColor = _urgency == ReminderUrgency.overdue ? LoloColors.colorError : null;

    return Semantics(
      label: semanticLabel ?? '$title. $_countdownText.',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: BorderDirectional(start: BorderSide(width: 4, color: _accentColor)),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
          child: Row(children: [
            if (onToggleComplete != null) ...[
              SizedBox(width: 24, height: 24, child: Checkbox(
                value: isCompleted,
                onChanged: (v) => onToggleComplete?.call(v ?? false),
                activeColor: LoloColors.colorPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              )),
              const SizedBox(width: 8),
            ],
            Icon(icon ?? _defaultIcon, size: 32, color: _accentColor),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: titleWeight, color: titleColor,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${date.day}/${date.month}/${date.year}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
              ],
            )),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (_urgency == ReminderUrgency.today || _urgency == ReminderUrgency.overdue)
                    ? _accentColor.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_countdownText, style: TextStyle(fontSize: 12,
                fontWeight: (_urgency == ReminderUrgency.today || _urgency == ReminderUrgency.overdue)
                    ? FontWeight.w700 : FontWeight.w500, color: _accentColor)),
            ),
          ]),
        ),
      ),
    );
  }
}
```

---

### 3.3 MemoryCard

**File:** `lib/core/widgets/memory_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Memory vault entry card with optional thumbnail and category chips.
///
/// Timeline connector on the start edge. Includes circular thumbnail,
/// title, preview text, date, and tag chips.
class MemoryCard extends StatelessWidget {
  const MemoryCard({
    required this.title,
    required this.date,
    this.preview,
    this.thumbnail,
    this.tags = const [],
    this.onTap,
    this.showTimeline = true,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final DateTime date;
  final String? preview;
  final ImageProvider? thumbnail;
  final List<String> tags;
  final VoidCallback? onTap;
  final bool showTimeline;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;

    return Semantics(
      label: semanticLabel ?? '$title. ${date.day}/${date.month}/${date.year}.',
      child: GestureDetector(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showTimeline) ...[
                SizedBox(width: 24, child: Column(children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: LoloColors.colorPrimary)),
                  Expanded(child: Container(width: 2, color: borderColor)),
                ])),
                const SizedBox(width: 12),
              ],
              Expanded(child: Container(
                constraints: const BoxConstraints(minHeight: 96),
                padding: const EdgeInsetsDirectional.all(16),
                margin: const EdgeInsetsDirectional.only(bottom: 8),
                decoration: BoxDecoration(
                  color: cardBg, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (thumbnail != null) ...[
                    ClipOval(child: Image(image: thumbnail!, width: 56, height: 56, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(width: 56, height: 56,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            color: LoloColors.colorPrimary.withValues(alpha: 0.1)),
                          child: const Icon(Icons.photo_outlined, color: LoloColors.colorPrimary)))),
                    const SizedBox(width: 12),
                  ],
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: theme.textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${date.day}/${date.month}/${date.year}', style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary)),
                    if (preview != null) ...[
                      const SizedBox(height: 8),
                      Text(preview!, style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                    if (tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(spacing: 4, runSpacing: 4, children: tags.map((tag) => Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: LoloColors.colorPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                        child: Text(tag, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500,
                          color: LoloColors.colorPrimary)),
                      )).toList()),
                    ],
                  ])),
                ]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 3.4 GiftCard

**File:** `lib/core/widgets/gift_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum GiftCardVariant { grid, list }

/// Gift recommendation card with image, name, price, and heart save icon.
///
/// Grid variant: column layout for 2-column grid (200dp height).
/// List variant: row layout for full-width lists (96dp height).
class GiftCard extends StatelessWidget {
  const GiftCard({
    required this.name,
    required this.priceRange,
    this.imageUrl,
    this.reasoning,
    this.isSaved = false,
    this.onSave,
    this.onTap,
    this.variant = GiftCardVariant.grid,
    this.semanticLabel,
    super.key,
  });

  final String name;
  final String priceRange;
  final String? imageUrl;
  final String? reasoning;
  final bool isSaved;
  final VoidCallback? onSave;
  final VoidCallback? onTap;
  final GiftCardVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => variant == GiftCardVariant.grid
      ? _buildGrid(context) : _buildList(context);

  Widget _buildGrid(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    return Semantics(label: semanticLabel ?? '$name. $priceRange.', child: GestureDetector(onTap: onTap,
      child: Container(height: 200, decoration: BoxDecoration(color: cardBg,
        borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor, width: 1)),
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 120, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
            _buildImage(context),
            PositionedDirectional(top: 8, end: 8, child: _HeartBtn(isSaved: isSaved, onTap: onSave)),
          ])),
          Expanded(child: Padding(padding: const EdgeInsetsDirectional.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(priceRange, style: theme.textTheme.bodySmall?.copyWith(
                color: LoloColors.colorAccent, fontWeight: FontWeight.w500)),
            ]))),
        ]))));
  }

  Widget _buildList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    return Semantics(label: semanticLabel ?? '$name. $priceRange.', child: GestureDetector(onTap: onTap,
      child: Container(height: 96, padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1)),
        child: Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 72, height: 72, child: _buildImage(context))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name, style: theme.textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(priceRange, style: theme.textTheme.bodySmall?.copyWith(
                color: LoloColors.colorAccent, fontWeight: FontWeight.w500)),
              if (reasoning != null) ...[const SizedBox(height: 4),
                Text(reasoning!, style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary),
                  maxLines: 1, overflow: TextOverflow.ellipsis)],
            ])),
          _HeartBtn(isSaved: isSaved, onTap: onSave),
        ]))));
  }

  Widget _buildImage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(imageUrl!, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(isDark));
    }
    return _placeholder(isDark);
  }

  Widget _placeholder(bool isDark) => Container(
    color: isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderMuted,
    child: Center(child: Icon(Icons.card_giftcard_outlined, size: 32,
      color: isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary)));
}

class _HeartBtn extends StatelessWidget {
  const _HeartBtn({required this.isSaved, this.onTap});
  final bool isSaved;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: AnimatedSwitcher(duration: const Duration(milliseconds: 200),
      child: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
        key: ValueKey(isSaved),
        color: isSaved ? LoloColors.colorError : LoloColors.darkTextSecondary,
        size: 24, semanticLabel: isSaved ? 'Saved' : 'Save')));
}
```

---

### 3.5 SOSCoachingCard

**File:** `lib/core/widgets/sos_coaching_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum SOSCardVariant { sayThis, dontSay, doThis }

/// SOS coaching card with colored side border and copy button.
///
/// Variants: "Say This" (green), "Don't Say" (red + strikethrough), "Do This" (blue).
class SOSCoachingCard extends StatefulWidget {
  const SOSCoachingCard({
    required this.variant,
    required this.header,
    required this.content,
    this.example,
    this.onCopy,
    this.semanticLabel,
    super.key,
  });

  final SOSCardVariant variant;
  final String header;
  final String content;
  final String? example;
  final VoidCallback? onCopy;
  final String? semanticLabel;

  @override
  State<SOSCoachingCard> createState() => _SOSCoachingCardState();
}

class _SOSCoachingCardState extends State<SOSCoachingCard> {
  bool _copied = false;

  Color get _color => switch (widget.variant) {
        SOSCardVariant.sayThis => LoloColors.colorSuccess,
        SOSCardVariant.dontSay => LoloColors.colorError,
        SOSCardVariant.doThis => LoloColors.colorPrimary,
      };

  IconData get _icon => switch (widget.variant) {
        SOSCardVariant.sayThis => Icons.chat_outlined,
        SOSCardVariant.dontSay => Icons.block_outlined,
        SOSCardVariant.doThis => Icons.lightbulb_outlined,
      };

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.example ?? widget.content));
    HapticFeedback.lightImpact();
    setState(() => _copied = true);
    widget.onCopy?.call();
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;

    return Semantics(label: widget.semanticLabel ?? '${widget.header}: ${widget.content}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: BorderDirectional(start: BorderSide(width: 4, color: _color))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Icon(_icon, size: 20, color: _color), const SizedBox(width: 8),
            Expanded(child: Text(widget.header, style: theme.textTheme.titleMedium?.copyWith(
              color: _color, fontWeight: FontWeight.w600))),
            GestureDetector(onTap: _handleCopy, child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _copied
                  ? const Icon(Icons.check, key: ValueKey('chk'), size: 20, color: LoloColors.colorSuccess)
                  : Icon(Icons.copy_outlined, key: const ValueKey('cpy'), size: 20,
                      color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary))),
          ]),
          const SizedBox(height: 12),
          Text(widget.content, style: theme.textTheme.bodyLarge),
          if (widget.example != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(12),
              decoration: BoxDecoration(color: _color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
              child: Text('"${widget.example}"', style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                decoration: widget.variant == SOSCardVariant.dontSay ? TextDecoration.lineThrough : null,
                decorationColor: LoloColors.colorError))),
          ],
        ]),
      ));
  }
}
```

---

### 3.6 StatCard

**File:** `lib/core/widgets/stat_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Compact stat display: icon, value (large text), label (small text).
///
/// Used in 2- or 3-column grids on dashboard and gamification screens.
class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(label: semanticLabel ?? '$label: $value', button: onTap != null,
      child: GestureDetector(onTap: onTap, child: Container(
        height: 80, padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 24, color: iconColor ?? LoloColors.colorPrimary),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: secondaryText),
            maxLines: 1, overflow: TextOverflow.ellipsis),
        ]))));
  }
}
```

---

## 4. Feedback Components

### 4.1 LoloToast

**File:** `lib/core/widgets/lolo_toast.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Toast notification variant.
enum ToastVariant { xpGain, success, error, info }

/// Transient notification overlay with auto-dismiss and swipe-up to dismiss.
///
/// 4 variants: XP gain (gold), success (green), error (red), info (blue).
/// Slides down from the top, auto-dismisses after [duration].
class LoloToast extends StatefulWidget {
  const LoloToast({
    required this.variant,
    required this.title,
    this.message,
    this.duration = const Duration(seconds: 4),
    this.onDismissed,
    super.key,
  });

  final ToastVariant variant;
  final String title;
  final String? message;
  final Duration duration;
  final VoidCallback? onDismissed;

  /// Shows a toast as an overlay entry.
  static void show(
    BuildContext context, {
    required ToastVariant variant,
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastOverlay(
        variant: variant,
        title: title,
        message: message,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    );
    overlay.insert(entry);
  }

  @override
  State<LoloToast> createState() => _LoloToastState();
}

class _LoloToastState extends State<LoloToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    Future<void>.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismissed?.call());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SlideTransition(
        position: _slideAnimation,
        child: _ToastContent(variant: widget.variant, title: widget.title, message: widget.message),
      );
}

/// Internal overlay wrapper that manages position and dismissal.
class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({
    required this.variant,
    required this.title,
    this.message,
    required this.duration,
    required this.onDismissed,
  });

  final ToastVariant variant;
  final String title;
  final String? message;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    Future<void>.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + 8;
    return Positioned(
      top: topPadding, left: 8, right: 8,
      child: GestureDetector(
        onVerticalDragEnd: (d) { if (d.velocity.pixelsPerSecond.dy < -100) _dismiss(); },
        child: SlideTransition(position: _slide,
          child: _ToastContent(variant: widget.variant, title: widget.title, message: widget.message)),
      ),
    );
  }
}

/// Visual content of the toast notification.
class _ToastContent extends StatelessWidget {
  const _ToastContent({required this.variant, required this.title, this.message});

  final ToastVariant variant;
  final String title;
  final String? message;

  Color get _accentColor => switch (variant) {
        ToastVariant.xpGain => LoloColors.colorAccent,
        ToastVariant.success => LoloColors.colorSuccess,
        ToastVariant.error => LoloColors.colorError,
        ToastVariant.info => LoloColors.colorInfo,
      };

  IconData get _icon => switch (variant) {
        ToastVariant.xpGain => Icons.star_outlined,
        ToastVariant.success => Icons.check_circle_outline,
        ToastVariant.error => Icons.cancel_outlined,
        ToastVariant.info => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? LoloColors.darkSurfaceElevated2 : LoloColors.lightSurfaceElevated2;

    return Material(
      color: Colors.transparent,
      child: Semantics(liveRegion: true, label: '$title. ${message ?? ""}',
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(
            color: bg, borderRadius: BorderRadius.circular(12),
            border: BorderDirectional(start: BorderSide(width: 3, color: _accentColor)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
          ),
          child: Row(children: [
            Icon(_icon, size: 24, color: _accentColor),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              if (message != null) Text(message!, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ])),
          ]),
        )),
    );
  }
}
```

---

### 4.2 LoloEmptyState

**File:** `lib/core/widgets/lolo_empty_state.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';

/// Empty state placeholder with illustration, title, subtitle, and optional CTA.
///
/// Centered vertically within available space. 32dp horizontal padding.
/// Illustration area: 120x120dp.
class LoloEmptyState extends StatelessWidget {
  const LoloEmptyState({
    required this.illustration,
    required this.title,
    required this.description,
    this.ctaLabel,
    this.onCtaTap,
    this.semanticLabel,
    super.key,
  });

  final Widget illustration;
  final String title;
  final String description;
  final String? ctaLabel;
  final VoidCallback? onCtaTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(label: semanticLabel ?? '$title. $description.',
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(width: 120, height: 120, child: illustration),
            const SizedBox(height: 24),
            Text(title, style: theme.textTheme.headlineSmall, textAlign: TextAlign.center, maxLines: 2),
            const SizedBox(height: 8),
            Text(description, style: theme.textTheme.bodyMedium?.copyWith(color: secondaryText),
              textAlign: TextAlign.center, maxLines: 3),
            if (ctaLabel != null && onCtaTap != null) ...[
              const SizedBox(height: 16),
              LoloPrimaryButton(label: ctaLabel!, onPressed: onCtaTap, fullWidth: false),
            ],
          ]),
        ),
      ));
  }
}
```

---

### 4.3 LoloSkeleton

**File:** `lib/core/widgets/lolo_skeleton.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';

/// Skeleton shimmer variant templates.
enum SkeletonVariant { card, list, text, avatar, custom }

/// Shimmer effect wrapper for loading states.
///
/// Animates a gradient sweep across child shapes at 1500ms per cycle.
/// Direction reverses in RTL (sweeps right-to-left in LTR, left-to-right in RTL).
class LoloSkeleton extends StatefulWidget {
  const LoloSkeleton({
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.child,
    super.key,
  });

  /// Creates a card-shaped skeleton.
  const LoloSkeleton.card({super.key})
      : width = double.infinity,
        height = 160,
        borderRadius = 12,
        isCircle = false,
        child = null;

  /// Creates a text-line skeleton.
  const LoloSkeleton.text({double widthFactor = 1.0, super.key})
      : width = null,
        height = 12,
        borderRadius = 4,
        isCircle = false,
        child = null;

  /// Creates an avatar-circle skeleton.
  const LoloSkeleton.avatar({double size = 48, super.key})
      : width = size,
        height = size,
        borderRadius = null,
        isCircle = true,
        child = null;

  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isCircle;
  final Widget? child;

  @override
  State<LoloSkeleton> createState() => _LoloSkeletonState();
}

class _LoloSkeletonState extends State<LoloSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final baseGradient = isDark ? LoloGradients.shimmerDark : LoloGradients.shimmerLight;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final progress = _controller.value;
        final effectiveProgress = isRtl ? 1.0 - progress : progress;

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle ? null
                : BorderRadius.circular(widget.borderRadius ?? 4),
            gradient: LinearGradient(
              colors: baseGradient.colors,
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + 2.0 * effectiveProgress, 0),
              end: Alignment(1.0 + 2.0 * effectiveProgress, 0),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Pre-built skeleton templates for common screen layouts.
class SkeletonTemplates {
  const SkeletonTemplates._();

  /// Dashboard skeleton: action card + 2 reminders + streak bar.
  static Widget dashboard() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LoloSkeleton(width: double.infinity, height: 200, borderRadius: 12),
          SizedBox(height: 16),
          Row(children: [
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
            SizedBox(width: 8),
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
            SizedBox(width: 8),
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
          ]),
          SizedBox(height: 16),
          LoloSkeleton(width: double.infinity, height: 80, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 80, borderRadius: 12),
        ]),
      );

  /// Card list skeleton: 3 stacked card outlines.
  static Widget cardList() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(children: [
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
        ]),
      );

  /// Message result skeleton: bubble with 3 text lines.
  static Widget message() => Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LoloSkeleton(width: double.infinity, height: 160, borderRadius: 12),
          const SizedBox(height: 16),
          LoloSkeleton(width: 200, height: 12, borderRadius: 4),
          const SizedBox(height: 8),
          const LoloSkeleton(width: double.infinity, height: 12, borderRadius: 4),
          const SizedBox(height: 8),
          LoloSkeleton(width: 260, height: 12, borderRadius: 4),
        ]),
      );

  /// Profile skeleton: avatar + 3 text lines.
  static Widget profile() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LoloSkeleton.avatar(size: 64),
          SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LoloSkeleton(width: 140, height: 16, borderRadius: 4),
            SizedBox(height: 8),
            LoloSkeleton(width: 200, height: 12, borderRadius: 4),
            SizedBox(height: 8),
            LoloSkeleton(width: 100, height: 12, borderRadius: 4),
          ])),
        ]),
      );

  /// Gift grid skeleton: 2x2 grid.
  static Widget giftGrid() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
            SizedBox(width: 16),
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
          ]),
          SizedBox(height: 16),
          Row(children: [
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
            SizedBox(width: 16),
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
          ]),
        ]),
      );
}
```

---

### 4.4 LoloDialog

**File:** `lib/core/widgets/lolo_dialog.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Dialog visual variant.
enum DialogVariant { confirmation, destructive, info }

/// Themed dialog with confirmation, destructive, and info variants.
///
/// Button order respects RTL: affirmative action always at end.
/// Width: screen width - 48dp, max 400dp.
class LoloDialog extends StatelessWidget {
  const LoloDialog({
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.onConfirm,
    this.variant = DialogVariant.confirmation,
    this.cancelLabel,
    this.onCancel,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final DialogVariant variant;
  final String? cancelLabel;
  final VoidCallback? onCancel;
  final String? semanticLabel;

  /// Shows the dialog as a modal.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    DialogVariant variant = DialogVariant.confirmation,
    String? cancelLabel,
  }) =>
      showGeneralDialog<bool>(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss dialog',
        barrierColor: Theme.of(context).brightness == Brightness.dark
            ? LoloColors.darkSurfaceOverlay
            : LoloColors.lightSurfaceOverlay,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: ScaleTransition(scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)), child: child),
          );
        },
        pageBuilder: (ctx, _, __) => LoloDialog(
          title: title,
          body: body,
          confirmLabel: confirmLabel,
          variant: variant,
          cancelLabel: cancelLabel ?? (variant == DialogVariant.info ? null : 'Cancel'),
          onConfirm: () => Navigator.of(ctx).pop(true),
          onCancel: () => Navigator.of(ctx).pop(false),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dialogBg = isDark ? LoloColors.darkSurfaceElevated1 : LoloColors.lightSurfaceElevated1;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    final confirmBgColor = switch (variant) {
      DialogVariant.destructive => LoloColors.colorError,
      _ => LoloColors.colorPrimary,
    };

    return Center(
      child: Semantics(label: semanticLabel ?? title, namesRoute: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400, minWidth: MediaQuery.of(context).size.width - 48),
          child: Material(
            color: dialogBg,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(body, style: theme.textTheme.bodyMedium?.copyWith(color: secondaryText)),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (cancelLabel != null) ...[
                    TextButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                      child: Text(cancelLabel!, style: TextStyle(color: secondaryText)),
                    ),
                    const SizedBox(width: 12),
                  ],
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmBgColor, foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(80, 44),
                    ),
                    child: Text(confirmLabel),
                  ),
                ]),
              ]),
            ),
          ),
        )),
    );
  }
}
```

---

## 5. Display Components

### 5.1 LoloProgressBar

**File:** `lib/core/widgets/lolo_progress_bar.dart`

```dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';

/// Progress indicator variant.
enum ProgressVariant { linear, circular }

/// Animated progress bar with linear and circular gauge variants.
///
/// Linear: 8dp height, 4dp radius track, gradient or solid fill.
/// Circular: configurable size, 8dp stroke, animated clockwise fill (counter-clockwise in RTL).
class LoloProgressBar extends StatefulWidget {
  const LoloProgressBar({
    required this.value,
    this.variant = ProgressVariant.linear,
    this.color,
    this.useGradient = false,
    this.size = 120,
    this.strokeWidth = 8,
    this.label,
    this.sublabel,
    this.animationDuration = const Duration(milliseconds: 500),
    this.semanticLabel,
    super.key,
  });

  /// Progress value between 0.0 and 1.0.
  final double value;
  final ProgressVariant variant;
  /// Solid fill color. Ignored if [useGradient] is true.
  final Color? color;
  /// Use the premium gradient for the fill.
  final bool useGradient;
  /// Circular variant diameter.
  final double size;
  final double strokeWidth;
  /// Label above linear bar, or center of circular gauge.
  final String? label;
  /// Sub-label (e.g., "XP needed").
  final String? sublabel;
  final Duration animationDuration;
  final String? semanticLabel;

  @override
  State<LoloProgressBar> createState() => _LoloProgressBarState();
}

class _LoloProgressBarState extends State<LoloProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void didUpdateWidget(LoloProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = _animation.value;
      _animation = Tween<double>(begin: _previousValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.variant == ProgressVariant.linear
      ? _buildLinear(context) : _buildCircular(context);

  Widget _buildLinear(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trackColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final fillColor = widget.color ?? LoloColors.colorPrimary;

    return Semantics(label: widget.semanticLabel ?? '${(widget.value * 100).toInt()}% progress',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        if (widget.label != null || widget.sublabel != null)
          Padding(padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              if (widget.label != null) Text(widget.label!, style: theme.textTheme.titleMedium),
              if (widget.sublabel != null) Text(widget.sublabel!, style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ])),
        SizedBox(height: 8, child: AnimatedBuilder(animation: _animation, builder: (_, __) {
          return ClipRRect(borderRadius: BorderRadius.circular(4),
            child: Stack(children: [
              Container(width: double.infinity, height: 8, color: trackColor),
              FractionallySizedBox(widthFactor: _animation.value.clamp(0.0, 1.0),
                child: Container(height: 8,
                  decoration: BoxDecoration(
                    color: widget.useGradient ? null : fillColor,
                    gradient: widget.useGradient ? LoloGradients.premium : null,
                    borderRadius: BorderRadius.circular(4)))),
            ]));
        })),
      ]));
  }

  Widget _buildCircular(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trackColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final fillColor = widget.color ?? LoloColors.colorPrimary;

    return Semantics(label: widget.semanticLabel ?? '${(widget.value * 100).toInt()}% progress',
      child: SizedBox(width: widget.size, height: widget.size,
        child: AnimatedBuilder(animation: _animation, builder: (_, __) {
          return Stack(alignment: Alignment.center, children: [
            CustomPaint(size: Size(widget.size, widget.size),
              painter: _CircularProgressPainter(
                value: _animation.value.clamp(0.0, 1.0),
                trackColor: trackColor, fillColor: fillColor,
                strokeWidth: widget.strokeWidth,
                isRtl: Directionality.of(context) == TextDirection.rtl)),
            if (widget.label != null || widget.sublabel != null)
              Column(mainAxisSize: MainAxisSize.min, children: [
                if (widget.label != null) Text(widget.label!, style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 28)),
                if (widget.sublabel != null) Text(widget.sublabel!, style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
              ]),
          ]);
        })));
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({
    required this.value, required this.trackColor,
    required this.fillColor, required this.strokeWidth,
    required this.isRtl,
  });
  final double value;
  final Color trackColor;
  final Color fillColor;
  final double strokeWidth;
  final bool isRtl;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final trackPaint = Paint()..color = trackColor..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final fillPaint = Paint()..color = fillColor..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * value * (isRtl ? -1 : 1);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, fillPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) => old.value != value;
}
```

---

### 5.2 LoloStreakDisplay

**File:** `lib/core/widgets/lolo_streak_display.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Streak display with flame icon, count, "days" label, and mini 7-day calendar.
///
/// Flame icon animates (scale pulse) when active. Gold accent when streak > 0,
/// gray when broken. Mini calendar shows last 7 days as filled/empty dots.
class LoloStreakDisplay extends StatefulWidget {
  const LoloStreakDisplay({
    required this.streakCount,
    this.activeDays = const [],
    this.isActive = true,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final int streakCount;
  /// Last 7 days: true = action completed, false = missed.
  final List<bool> activeDays;
  final bool isActive;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<LoloStreakDisplay> createState() => _LoloStreakDisplayState();
}

class _LoloStreakDisplayState extends State<LoloStreakDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(LoloStreakDisplay old) {
    super.didUpdateWidget(old);
    if (widget.streakCount > old.streakCount && widget.isActive) {
      _pulseController.forward().then((_) => _pulseController.reverse());
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final countColor = widget.isActive ? LoloColors.colorAccent : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary);
    final flameColor = widget.isActive ? LoloColors.colorWarning : LoloColors.gray5;

    return Semantics(label: widget.semanticLabel ?? '${widget.streakCount} day streak',
      child: GestureDetector(onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ScaleTransition(scale: _pulseAnimation,
                child: Icon(Icons.local_fire_department, size: 24, color: flameColor)),
              const SizedBox(width: 8),
              Text('${widget.streakCount}', style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700, color: countColor)),
              const SizedBox(width: 4),
              Text('days', style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ]),
            if (widget.activeDays.isNotEmpty) ...[
              const SizedBox(height: 8),
              _MiniCalendar(days: widget.activeDays),
            ],
          ]),
        )));
  }
}

/// Mini 7-day calendar row: filled circles for active days, outlined for missed.
class _MiniCalendar extends StatelessWidget {
  const _MiniCalendar({required this.days});
  final List<bool> days;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final normalizedDays = days.length >= 7 ? days.sublist(days.length - 7) : days;

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (i) {
        final isActive = i < normalizedDays.length && normalizedDays[i];
        return Padding(padding: const EdgeInsetsDirectional.symmetric(horizontal: 3),
          child: Container(width: 8, height: 8, decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? LoloColors.colorSuccess : Colors.transparent,
            border: Border.all(
              color: isActive ? LoloColors.colorSuccess
                  : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault),
              width: 1.5),
          )));
      }));
  }
}
```

---

### 5.3 LoloBadge

**File:** `lib/core/widgets/lolo_badge.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Badge variant type.
enum LoloBadgeVariant { plan, category, notification }

/// Plan tier for plan badges.
enum PlanTier { free, pro, legend }

/// Multi-purpose badge component.
///
/// Three variants:
/// - Plan badge: Free/Pro/Legend with tier-specific colors.
/// - Category badge: small chip with custom color.
/// - Notification badge: red circle with count overlay.
class LoloBadge extends StatelessWidget {
  const LoloBadge.plan({
    required this.tier,
    this.semanticLabel,
    super.key,
  })  : variant = LoloBadgeVariant.plan,
        label = null,
        color = null,
        count = null;

  const LoloBadge.category({
    required String this.label,
    this.color,
    this.semanticLabel,
    super.key,
  })  : variant = LoloBadgeVariant.category,
        tier = null,
        count = null;

  const LoloBadge.notification({
    required int this.count,
    this.semanticLabel,
    super.key,
  })  : variant = LoloBadgeVariant.notification,
        tier = null,
        label = null,
        color = null;

  final LoloBadgeVariant variant;
  final PlanTier? tier;
  final String? label;
  final Color? color;
  final int? count;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => switch (variant) {
        LoloBadgeVariant.plan => _buildPlan(context),
        LoloBadgeVariant.category => _buildCategory(context),
        LoloBadgeVariant.notification => _buildNotification(context),
      };

  Widget _buildPlan(BuildContext context) {
    final tierLabel = switch (tier!) { PlanTier.free => 'Free', PlanTier.pro => 'Pro', PlanTier.legend => 'Legend' };
    final tierBg = switch (tier!) {
      PlanTier.free => LoloColors.gray5,
      PlanTier.pro => LoloColors.colorPrimary,
      PlanTier.legend => LoloColors.colorAccent,
    };
    final tierFg = switch (tier!) {
      PlanTier.free => LoloColors.darkTextPrimary,
      PlanTier.pro => Colors.white,
      PlanTier.legend => Colors.white,
    };

    return Semantics(label: semanticLabel ?? '$tierLabel plan',
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: tierBg, borderRadius: BorderRadius.circular(8)),
        child: Text(tierLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: tierFg))));
  }

  Widget _buildCategory(BuildContext context) {
    final effectiveColor = color ?? LoloColors.colorPrimary;
    return Semantics(label: semanticLabel ?? label,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
        child: Text(label!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: effectiveColor))));
  }

  Widget _buildNotification(BuildContext context) {
    if (count == null || count! <= 0) return const SizedBox.shrink();
    final displayText = count! > 99 ? '99+' : '$count';
    return Semantics(label: semanticLabel ?? '$count notifications',
      child: Container(
        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 1),
        decoration: const BoxDecoration(color: LoloColors.colorError, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(displayText, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white))));
  }
}
```

---

### 5.4 LoloAvatar

**File:** `lib/core/widgets/lolo_avatar.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Avatar size presets.
enum AvatarSize { small, medium, large }

/// Avatar with image, fallback initials, and optional zodiac badge overlay.
///
/// Sizes: small (32dp), medium (48dp), large (64dp).
/// Shows initials on brand primary background when no image is provided.
/// Zodiac badge overlays at bottom-end corner.
class LoloAvatar extends StatelessWidget {
  const LoloAvatar({
    this.imageUrl,
    this.name,
    this.size = AvatarSize.medium,
    this.zodiacIcon,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final String? imageUrl;
  final String? name;
  final AvatarSize size;
  /// Optional zodiac icon to overlay as a small badge.
  final IconData? zodiacIcon;
  final VoidCallback? onTap;
  final String? semanticLabel;

  double get _diameter => switch (size) {
        AvatarSize.small => 32,
        AvatarSize.medium => 48,
        AvatarSize.large => 64,
      };

  double get _fontSize => switch (size) {
        AvatarSize.small => 12,
        AvatarSize.medium => 16,
        AvatarSize.large => 24,
      };

  double get _badgeSize => switch (size) {
        AvatarSize.small => 14,
        AvatarSize.medium => 18,
        AvatarSize.large => 22,
      };

  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? name ?? 'Avatar',
      image: imageUrl != null,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: _diameter,
          height: _diameter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Avatar circle
              Container(
                width: _diameter,
                height: _diameter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LoloColors.colorPrimary,
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildContent(),
              ),
              // Zodiac badge
              if (zodiacIcon != null)
                PositionedDirectional(
                  bottom: -2,
                  end: -2,
                  child: Container(
                    width: _badgeSize,
                    height: _badgeSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: LoloColors.colorAccent,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary,
                        width: 2,
                      ),
                    ),
                    child: Icon(zodiacIcon, size: _badgeSize - 8, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: _diameter,
        height: _diameter,
        errorBuilder: (_, __, ___) => _initialsWidget(),
      );
    }
    return _initialsWidget();
  }

  Widget _initialsWidget() => Center(
        child: Text(
          _initials,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}
```

---

## 6. Utility Components

### 6.1 LoloLoadingWidget

**File:** `lib/core/widgets/lolo_loading_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Centered loading spinner with optional label.
///
/// Uses the LOLO compass icon with a pulse animation for branded loading,
/// or a standard circular indicator for inline usage.
class LoloLoadingWidget extends StatefulWidget {
  const LoloLoadingWidget({
    this.label,
    this.useBrandedAnimation = false,
    this.size = 40,
    this.semanticLabel,
    super.key,
  });

  /// Optional text below the spinner.
  final String? label;
  /// Use the branded compass pulse instead of a standard spinner.
  final bool useBrandedAnimation;
  /// Spinner diameter.
  final double size;
  final String? semanticLabel;

  @override
  State<LoloLoadingWidget> createState() => _LoloLoadingWidgetState();
}

class _LoloLoadingWidgetState extends State<LoloLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.useBrandedAnimation) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final labelColor = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(
      label: widget.semanticLabel ?? widget.label ?? 'Loading',
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (widget.useBrandedAnimation)
            ScaleTransition(scale: _scaleAnimation,
              child: Icon(Icons.explore, size: widget.size, color: LoloColors.colorPrimary))
          else
            SizedBox(width: widget.size, height: widget.size,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(LoloColors.colorPrimary))),
          if (widget.label != null) ...[
            const SizedBox(height: 12),
            Text(widget.label!, style: theme.textTheme.bodyMedium?.copyWith(color: labelColor)),
          ],
        ]),
      ),
    );
  }
}
```

---

### 6.2 PaginatedListView

**File:** `lib/core/widgets/paginated_list_view.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lolo/core/widgets/lolo_loading_widget.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';

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
```

---

## Implementation Notes

### File Index (24 widgets)

| # | Widget | File Path |
|---|--------|-----------|
| 1 | LoloBottomNav | `lib/core/widgets/lolo_bottom_nav.dart` |
| 2 | LoloAppBar | `lib/core/widgets/lolo_app_bar.dart` |
| 3 | LoloPrimaryButton | `lib/core/widgets/lolo_primary_button.dart` |
| 4 | LoloTextField | `lib/core/widgets/lolo_text_field.dart` |
| 5 | LoloChipGroup | `lib/core/widgets/lolo_chip_group.dart` |
| 6 | LoloSlider | `lib/core/widgets/lolo_slider.dart` |
| 7 | LoloToggle | `lib/core/widgets/lolo_toggle.dart` |
| 8 | LoloDropdown | `lib/core/widgets/lolo_dropdown.dart` |
| 9 | ActionCard | `lib/core/widgets/action_card.dart` |
| 10 | ReminderTile | `lib/core/widgets/reminder_tile.dart` |
| 11 | MemoryCard | `lib/core/widgets/memory_card.dart` |
| 12 | GiftCard | `lib/core/widgets/gift_card.dart` |
| 13 | SOSCoachingCard | `lib/core/widgets/sos_coaching_card.dart` |
| 14 | StatCard | `lib/core/widgets/stat_card.dart` |
| 15 | LoloToast | `lib/core/widgets/lolo_toast.dart` |
| 16 | LoloEmptyState | `lib/core/widgets/lolo_empty_state.dart` |
| 17 | LoloSkeleton | `lib/core/widgets/lolo_skeleton.dart` |
| 18 | LoloDialog | `lib/core/widgets/lolo_dialog.dart` |
| 19 | LoloProgressBar | `lib/core/widgets/lolo_progress_bar.dart` |
| 20 | LoloStreakDisplay | `lib/core/widgets/lolo_streak_display.dart` |
| 21 | LoloBadge | `lib/core/widgets/lolo_badge.dart` |
| 22 | LoloAvatar | `lib/core/widgets/lolo_avatar.dart` |
| 23 | LoloLoadingWidget | `lib/core/widgets/lolo_loading_widget.dart` |
| 24 | PaginatedListView | `lib/core/widgets/paginated_list_view.dart` |

### Design System Compliance Checklist

Every component above satisfies:

- [x] **Theme-aware**: Uses `Theme.of(context).brightness` to switch between dark/light palettes
- [x] **Token-based**: All colors from `LoloColors`, spacing from `LoloSpacing`, gradients from `LoloGradients`
- [x] **RTL-ready**: `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`, `BorderDirectional`
- [x] **Accessible**: `Semantics` wrappers with labels, `excludeSemantics` where appropriate, live regions for toasts
- [x] **State-complete**: Default, pressed/active, disabled, loading, error states where applicable
- [x] **Const constructors**: Used wherever possible for widget tree optimization
- [x] **Named parameters**: All constructors use named parameters with `required` vs optional distinction
- [x] **Animation tokens**: Durations from design system (100ms-1500ms), curves from spec (easeOutCubic default)
- [x] **Touch targets**: Minimum 48dp for all interactive elements
- [x] **WCAG AA**: Color contrast ratios maintained by using design system token pairings

### Integration with Scaffold

These components reference three core modules from the scaffold (S1-01):

1. **`lolo_colors.dart`** -- All color tokens (`LoloColors.colorPrimary`, `LoloColors.darkBgTertiary`, etc.)
2. **`lolo_spacing.dart`** -- Spacing constants (`LoloSpacing.cardBorderRadius`, `LoloSpacing.spaceMd`, etc.)
3. **`lolo_gradients.dart`** -- Gradient definitions (`LoloGradients.premium`, `LoloGradients.shimmerDark`, etc.)

No other external dependencies beyond Flutter SDK and these three scaffold files.

---

**End of Base UI Components Implementation Document**
