import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_avatar.dart';
import 'package:lolo/core/widgets/lolo_toggle.dart';
import 'package:lolo/features/auth/presentation/providers/auth_provider.dart';
import 'package:lolo/features/settings/presentation/providers/settings_provider.dart';

/// Provider for the user's nationality from Firestore.
final nationalityProvider = StreamProvider<String>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value('');
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.data()?['nationality'] as String? ?? '');
});

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

/// Settings screen with profile, language, theme, notifications,
/// subscription, and account management sections.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsNotifierProvider);
    final currentUser = ref.watch(currentUserProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Settings',
        showBackButton: false,
        showLogo: true,
      ),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LoloSpacing.spaceXl),

              // === PROFILE SECTION ===
              _SectionHeader(title: 'Profile'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _ProfileCard(
                name: currentUser?.displayName ?? 'User',
                email: currentUser?.email ?? '',
                photoUrl: currentUser?.photoUrl,
                onTap: () => context.pushNamed('her-profile'),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === NATIONALITY / CULTURE ===
              _SectionHeader(title: 'Culture'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _NationalitySelector(),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === LANGUAGE ===
              _SectionHeader(title: 'Language'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SegmentedSelector<String>(
                value: settings.locale,
                options: const {
                  'en': 'English',
                  'ar': 'Arabic',
                  'ms': 'Malay',
                },
                onChanged: (locale) => ref
                    .read(settingsNotifierProvider.notifier)
                    .setLocale(locale),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === THEME ===
              _SectionHeader(title: 'Appearance'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SegmentedSelector<String>(
                value: settings.themeMode,
                options: const {
                  'light': 'Light',
                  'dark': 'Dark',
                  'system': 'System',
                },
                onChanged: (mode) => ref
                    .read(settingsNotifierProvider.notifier)
                    .setThemeMode(mode),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === NOTIFICATIONS ===
              _SectionHeader(title: 'Notifications'),
              const SizedBox(height: LoloSpacing.spaceSm),
              LoloToggle(
                label: 'Push Notifications',
                description: 'Receive push notifications',
                value: settings.notificationsEnabled,
                onChanged: (v) => ref
                    .read(settingsNotifierProvider.notifier)
                    .setNotificationsEnabled(v),
              ),
              LoloToggle(
                label: 'Reminder Alerts',
                description: 'Get notified about upcoming dates',
                value: settings.reminderNotifications,
                onChanged: settings.notificationsEnabled
                    ? (v) => ref
                        .read(settingsNotifierProvider.notifier)
                        .setReminderNotifications(v)
                    : null,
                enabled: settings.notificationsEnabled,
              ),
              LoloToggle(
                label: 'Daily Action Cards',
                description: 'Daily relationship tips and actions',
                value: settings.dailyCardNotifications,
                onChanged: settings.notificationsEnabled
                    ? (v) => ref
                        .read(settingsNotifierProvider.notifier)
                        .setDailyCardNotifications(v)
                    : null,
                enabled: settings.notificationsEnabled,
              ),
              LoloToggle(
                label: 'Weekly Digest',
                description: 'Weekly relationship summary',
                value: settings.weeklyDigest,
                onChanged: settings.notificationsEnabled
                    ? (v) => ref
                        .read(settingsNotifierProvider.notifier)
                        .setWeeklyDigest(v)
                    : null,
                enabled: settings.notificationsEnabled,
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === SUBSCRIPTION ===
              _SectionHeader(title: 'Subscription'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.workspace_premium,
                label: currentUser?.isPremium == true
                    ? 'Premium Active'
                    : 'Upgrade to Premium',
                subtitle: currentUser?.isPremium == true
                    ? 'Manage your subscription'
                    : 'Unlock all features',
                trailing: currentUser?.isPremium == true
                    ? const Icon(Icons.check_circle,
                        color: LoloColors.colorSuccess)
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: LoloColors.colorAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                onTap: () => context.pushNamed('paywall', extra: 'settings'),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === ABOUT ===
              _SectionHeader(title: 'About'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.info_outline,
                label: 'About LOLO',
                onTap: () => _showAboutDialog(context),
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                label: 'Terms of Service',
                onTap: () {/* Navigate to terms */},
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                onTap: () {/* Navigate to privacy */},
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === ACCOUNT ACTIONS ===
              _SectionHeader(title: 'Account'),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.logout,
                label: 'Log Out',
                iconColor: LoloColors.colorWarning,
                onTap: () => _handleLogout(context, ref),
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                label: 'Delete Account',
                iconColor: LoloColors.colorError,
                labelColor: LoloColors.colorError,
                onTap: () => _handleDeleteAccount(context, ref),
              ),

              const SizedBox(height: LoloSpacing.space3xl),

              // App version
              Center(
                child: Text(
                  'LOLO v1.0.0',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ),
              ),
              const SizedBox(height: LoloSpacing.screenBottomPadding),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'LOLO',
      applicationVersion: '1.0.0',
      applicationLegalese: '2024 LOLO. All rights reserved.',
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authNotifierProvider.notifier).signOut();
              context.go('/welcome');
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _handleDeleteAccount(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action is permanent and cannot be undone. '
          'All your data will be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authRepositoryProvider).deleteAccount();
              context.go('/welcome');
            },
            style: TextButton.styleFrom(
                foregroundColor: LoloColors.colorError),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// === Private Widgets ===

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: isDark
            ? LoloColors.darkTextTertiary
            : LoloColors.lightTextTertiary,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.onTap,
  });

  final String name;
  final String email;
  final String? photoUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
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
              LoloAvatar(
                name: name,
                imageUrl: photoUrl,
                size: AvatarSize.medium,
              ),
              const SizedBox(width: LoloSpacing.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: theme.textTheme.titleMedium),
                    Text(
                      email,
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
    );
  }
}

class _SegmentedSelector<T> extends StatelessWidget {
  const _SegmentedSelector({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final Map<T, String> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: options.entries.map((entry) {
          final isSelected = entry.key == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? LoloColors.colorPrimary : null,
                  borderRadius:
                      BorderRadius.circular(LoloSpacing.cardBorderRadius - 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  entry.value,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary),
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NationalitySelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nationalityAsync = ref.watch(nationalityProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentNationality = nationalityAsync.valueOrNull ?? '';

    return Material(
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
                    Text('Nationality', style: theme.textTheme.titleMedium),
                    Text(
                      currentNationality.isEmpty
                          ? 'Set your nationality for culturally personalized messages'
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
              child: Text('Select Nationality',
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
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({'nationality': nat});
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

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.iconColor,
    this.labelColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final Color? iconColor;
  final Color? labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: LoloSpacing.spaceSm,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? LoloColors.colorPrimary,
              size: LoloSpacing.iconSizeMedium,
            ),
            const SizedBox(width: LoloSpacing.spaceMd),
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
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? LoloColors.darkTextSecondary
                            : LoloColors.lightTextSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else
              Icon(
                Icons.chevron_right,
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
          ],
        ),
      ),
    );
  }
}
