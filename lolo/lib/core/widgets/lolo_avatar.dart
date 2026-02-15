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
