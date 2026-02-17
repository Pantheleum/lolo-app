import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_avatar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/presentation/providers/her_profile_provider.dart';
import 'package:lolo/features/her_profile/presentation/widgets/profile_completion_ring.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Provider for the partner's nationality from Firestore.
final partnerNationalityProvider = StreamProvider<String>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value('');
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.data()?['partnerNationality'] as String? ?? '');
});

/// Provider for partner's birthday from Firestore.
final partnerBirthdayProvider = StreamProvider<DateTime?>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value(null);
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) {
    final data = doc.data();
    if (data == null || data['partnerBirthday'] == null) return null;
    final val = data['partnerBirthday'];
    if (val is Timestamp) return val.toDate();
    if (val is String) return DateTime.tryParse(val);
    return null;
  });
});

/// Shared month name helper.
String _monthName(int month) => const [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ][month];

/// All supported nationalities grouped by region.
const _nationalities = <String, List<String>>{
  'Middle East': [
    'Saudi Arabian',
    'Emirati (UAE)',
    'Qatari',
    'Kuwaiti',
    'Bahraini',
    'Omani',
    'Yemeni',
    'Iraqi',
    'Jordanian',
    'Lebanese',
    'Palestinian',
    'Syrian',
    'Egyptian',
    'Moroccan',
    'Algerian',
    'Tunisian',
    'Libyan',
    'Sudanese',
    'Turkish',
  ],
  'Southeast Asia': [
    'Malaysian',
    'Indonesian',
    'Bruneian',
    'Singaporean',
    'Filipino',
    'Thai',
    'Vietnamese',
  ],
  'South Asia': [
    'Indian',
    'Pakistani',
    'Bangladeshi',
    'Sri Lankan',
  ],
  'Europe': [
    'British (UK)',
    'French',
    'German',
    'Spanish',
    'Italian',
    'Dutch',
    'Swedish',
    'Norwegian',
  ],
  'Americas': [
    'American (USA)',
    'Canadian',
    'Mexican',
    'Brazilian',
    'Colombian',
    'Argentinian',
  ],
  'Africa': [
    'Nigerian',
    'Ghanaian',
    'Kenyan',
    'South African',
    'Ethiopian',
    'Tanzanian',
  ],
  'East Asia & Pacific': [
    'Australian',
    'New Zealander',
    'Chinese',
    'Japanese',
    'Korean',
  ],
};

/// Profile overview screen showing avatar, zodiac badge, completion %,
/// and navigation tiles to sub-screens.
///
/// Top-level tab screen — no back button.
class HerProfileScreen extends ConsumerWidget {
  const HerProfileScreen({this.profileId = 'default', super.key});

  final String profileId;

  static String _loveLanguageLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'words':
        return l10n.profile_edit_loveLanguage_words;
      case 'acts':
        return l10n.profile_edit_loveLanguage_acts;
      case 'gifts':
        return l10n.profile_edit_loveLanguage_gifts;
      case 'time':
        return l10n.profile_edit_loveLanguage_time;
      case 'touch':
        return l10n.profile_edit_loveLanguage_touch;
      default:
        return key;
    }
  }

  static String _commStyleLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'direct':
        return l10n.profile_edit_commStyle_direct;
      case 'indirect':
        return l10n.profile_edit_commStyle_indirect;
      case 'mixed':
        return l10n.profile_edit_commStyle_mixed;
      default:
        return key;
    }
  }

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

              // Badges row: zodiac, love language, communication style
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (profile.zodiacSign != null)
                    _HeroBadge(
                      label: profile.zodiacDisplayName,
                      color: LoloColors.colorAccent,
                      onTap: () => context.push('/her/edit'),
                    ),
                  if (profile.loveLanguage != null)
                    _HeroBadge(
                      label: _loveLanguageLabel(l10n, profile.loveLanguage!),
                      color: LoloColors.colorPrimary,
                      onTap: () => context.push('/her/edit'),
                    ),
                  if (profile.communicationStyle != null)
                    _HeroBadge(
                      label: _commStyleLabel(l10n, profile.communicationStyle!),
                      color: isDark
                          ? LoloColors.darkTextSecondary
                          : LoloColors.lightTextSecondary,
                      onTap: () => context.push('/her/edit'),
                    ),
                ],
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
              _PartnerBirthdayTile(),
              _PartnerNationalitySelector(),
              _AnniversaryTile(
                profileId: profileId,
                anniversaryDate: profile.anniversaryDate,
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // Quick Facts card
              _QuickFactsCard(profile: profile, l10n: l10n),
              const SizedBox(height: LoloSpacing.screenBottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({
    required this.label,
    required this.color,
    this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
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
              6,
              (_) => const Padding(
                padding: EdgeInsets.only(bottom: LoloSpacing.spaceXs),
                child: LoloSkeleton(width: double.infinity, height: 72),
              ),
            ),
          ],
        ),
      );
}

class _PartnerBirthdayTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthdayAsync = ref.watch(partnerBirthdayProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final birthday = birthdayAsync.valueOrNull;

    String subtitle;
    if (birthday != null) {
      final age = _calculateAge(birthday);
      final month = _monthName(birthday.month);
      subtitle = '$month ${birthday.day}, ${birthday.year} ($age years old)';
    } else {
      subtitle = "Set her birthday for age-aware messages";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
      child: Material(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: InkWell(
          onTap: () => _pickBirthday(context, birthday),
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(LoloSpacing.spaceMd),
            child: Row(
              children: [
                Icon(
                  Icons.cake_outlined,
                  color: LoloColors.colorPrimary,
                  size: LoloSpacing.iconSizeMedium,
                ),
                const SizedBox(width: LoloSpacing.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Her Birthday', style: theme.textTheme.titleMedium),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
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

  int _calculateAge(DateTime birthday) {
    final now = DateTime.now();
    var age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }

  Future<void> _pickBirthday(BuildContext context, DateTime? current) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime(1995, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: "Select her birthday",
    );
    if (picked != null && context.mounted) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({'partnerBirthday': Timestamp.fromDate(picked)});
        } catch (_) {
          // Firestore write failed — stream will re-sync
        }
      }
    }
  }
}

class _PartnerNationalitySelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nationalityAsync = ref.watch(partnerNationalityProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentNationality = nationalityAsync.valueOrNull ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
      child: Material(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: InkWell(
          onTap: () => _showNationalityPicker(context, ref, currentNationality),
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(LoloSpacing.spaceMd),
            child: Row(
              children: [
                Icon(
                  Icons.public,
                  color: LoloColors.colorPrimary,
                  size: LoloSpacing.iconSizeMedium,
                ),
                const SizedBox(width: LoloSpacing.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Her Nationality', style: theme.textTheme.titleMedium),
                      Text(
                        currentNationality.isEmpty
                            ? 'Set her nationality for culturally personalized messages'
                            : currentNationality,
                        style: theme.textTheme.bodySmall?.copyWith(
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

  void _showNationalityPicker(
      BuildContext context, WidgetRef ref, String current) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          isDark ? LoloColors.darkBgSecondary : LoloColors.lightBgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? LoloColors.darkBorderDefault
                      : LoloColors.lightBorderDefault,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: LoloSpacing.screenHorizontalPadding, vertical: 8),
              child: Text('Her Nationality',
                  style: theme.textTheme.titleLarge),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: _nationalities.entries.expand((region) {
                  return [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 16, bottom: 4),
                      child: Text(
                        region.key.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isDark
                              ? LoloColors.darkTextTertiary
                              : LoloColors.lightTextTertiary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...region.value.map((nat) => ListTile(
                          title: Text(nat),
                          trailing: nat == current
                              ? const Icon(Icons.check,
                                  color: LoloColors.colorPrimary)
                              : null,
                          onTap: () async {
                            final uid =
                                FirebaseAuth.instance.currentUser?.uid;
                            if (uid != null) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .update({'partnerNationality': nat});
                              } catch (_) {
                                // Firestore write failed — stream will re-sync
                              }
                            }
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                        )),
                  ];
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnniversaryTile extends ConsumerWidget {
  const _AnniversaryTile({
    required this.profileId,
    this.anniversaryDate,
  });

  final String profileId;
  final DateTime? anniversaryDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    String subtitle;
    if (anniversaryDate != null) {
      final month = _monthName(anniversaryDate!.month);
      subtitle = '$month ${anniversaryDate!.day}, ${anniversaryDate!.year}';
    } else {
      subtitle = 'Set your anniversary date';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
      child: Material(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: InkWell(
          onTap: () => _pickAnniversary(context, ref),
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(LoloSpacing.spaceMd),
            child: Row(
              children: [
                Icon(
                  Icons.celebration_outlined,
                  color: LoloColors.colorPrimary,
                  size: LoloSpacing.iconSizeMedium,
                ),
                const SizedBox(width: LoloSpacing.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Anniversary', style: theme.textTheme.titleMedium),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
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

  Future<void> _pickAnniversary(BuildContext context, WidgetRef ref) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: anniversaryDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      helpText: 'Select your anniversary',
    );
    if (picked != null && context.mounted) {
      await ref
          .read(herProfileNotifierProvider(profileId).notifier)
          .updateProfile({'anniversaryDate': picked.toIso8601String()});
    }
  }
}

class _QuickFactsCard extends StatelessWidget {
  const _QuickFactsCard({
    required this.profile,
    required this.l10n,
  });

  final PartnerProfileEntity profile;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final facts = <_QuickFact>[
      if (profile.relationshipStatus.isNotEmpty)
        _QuickFact(
          Icons.favorite,
          'Status',
          _capitalize(profile.relationshipStatus),
        ),
      if (profile.loveLanguage != null)
        _QuickFact(
          Icons.volunteer_activism,
          l10n.profile_edit_loveLanguage,
          HerProfileScreen._loveLanguageLabel(l10n, profile.loveLanguage!),
        ),
      if (profile.communicationStyle != null)
        _QuickFact(
          Icons.chat_bubble_outline,
          l10n.profile_edit_commStyle,
          HerProfileScreen._commStyleLabel(l10n, profile.communicationStyle!),
        ),
      if (profile.zodiacSign != null)
        _QuickFact(
          Icons.stars,
          'Zodiac',
          profile.zodiacDisplayName,
        ),
      if (profile.culturalContext?.background != null)
        _QuickFact(
          Icons.public,
          'Background',
          profile.culturalContext!.background!,
        ),
    ];

    if (facts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK FACTS',
          style: theme.textTheme.labelMedium?.copyWith(
            color: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: LoloSpacing.spaceSm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(LoloSpacing.spaceMd),
          decoration: BoxDecoration(
            color: isDark
                ? LoloColors.darkSurfaceElevated1
                : LoloColors.lightSurfaceElevated1,
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: facts
                .map((f) => _buildFact(context, f, isDark))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFact(BuildContext context, _QuickFact fact, bool isDark) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120, maxWidth: 160),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(fact.icon, size: 16, color: LoloColors.colorPrimary),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fact.label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ),
                Text(
                  fact.value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _QuickFact {
  const _QuickFact(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;
}
