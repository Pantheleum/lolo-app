import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_avatar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/her_profile/presentation/providers/her_profile_provider.dart';
import 'package:lolo/features/her_profile/presentation/widgets/profile_completion_ring.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Profile overview screen showing avatar, zodiac badge, completion %,
/// and navigation tiles to sub-screens.
///
/// Top-level tab screen — no back button.
class HerProfileScreen extends ConsumerWidget {
  const HerProfileScreen({this.profileId = 'default', super.key});

  final String profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(herProfileNotifierProvider(profileId));
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(title: l10n.profile_title, showBackButton: false),
      body: profileAsync.when(
        loading: () => const _ProfileSkeleton(),
        error: (error, _) => Center(child: Text('$error')),
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: LoloSpacing.spaceXl),

              // Avatar with completion ring
              ProfileCompletionRing(
                percent: profile.profileCompletionPercent / 100.0,
                child: LoloAvatar(
                  name: profile.name,
                  imageUrl: profile.photoUrl,
                  size: AvatarSize.large,
                ),
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Name
              Text(profile.name, style: theme.textTheme.headlineMedium),
              const SizedBox(height: LoloSpacing.spaceXs),

              // Zodiac badge
              if (profile.zodiacSign != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: LoloColors.colorAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    profile.zodiacDisplayName,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: LoloColors.colorAccent,
                    ),
                  ),
                ),
              const SizedBox(height: LoloSpacing.spaceXs),

              // Completion percentage
              Text(
                l10n.profile_completion(profile.profileCompletionPercent),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? LoloColors.darkTextSecondary
                      : LoloColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: LoloSpacing.space2xl),

              // Navigation tiles
              _NavTile(
                icon: Icons.stars_outlined,
                label: l10n.profile_nav_zodiac,
                subtitle: profile.zodiacDisplayName.isNotEmpty
                    ? profile.zodiacDisplayName
                    : l10n.profile_nav_zodiac_empty,
                onTap: () => context.push('/her/edit'),
              ),
              _NavTile(
                icon: Icons.favorite_outline,
                label: l10n.profile_nav_preferences,
                subtitle: l10n.profile_nav_preferences_subtitle(
                  profile.preferences?.filledCount ?? 0,
                ),
                onTap: () => context.push('/her/preferences'),
              ),
              _NavTile(
                icon: Icons.language_outlined,
                label: l10n.profile_nav_cultural,
                subtitle: profile.culturalContext?.background ?? l10n.profile_nav_cultural_empty,
                onTap: () => context.push('/her/cultural'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
      child: Material(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(LoloSpacing.spaceMd),
            child: Row(
              children: [
                Icon(icon, color: LoloColors.colorPrimary),
                const SizedBox(width: LoloSpacing.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextSecondary
                                  : LoloColors.lightTextSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? LoloColors.darkTextTertiary
                      : LoloColors.lightTextTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: LoloSpacing.spaceXl),
            const LoloSkeleton(width: 72, height: 72, isCircle: true),
            const SizedBox(height: LoloSpacing.spaceMd),
            const LoloSkeleton(width: 120, height: 24),
            const SizedBox(height: LoloSpacing.space2xl),
            ...List.generate(
              3,
              (_) => const Padding(
                padding: EdgeInsets.only(bottom: LoloSpacing.spaceXs),
                child: LoloSkeleton(width: double.infinity, height: 72),
              ),
            ),
          ],
        ),
      );
}
