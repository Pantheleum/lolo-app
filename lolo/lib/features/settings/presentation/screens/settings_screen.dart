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
import 'package:lolo/generated/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.settings_title,
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
              _SectionHeader(title: l10n.settings_profile),
              const SizedBox(height: LoloSpacing.spaceSm),
              _ProfileCard(
                name: currentUser?.displayName ?? 'User',
                email: currentUser?.email ?? '',
                photoUrl: currentUser?.photoUrl,
                onTap: () => context.pushNamed('her-profile'),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === LANGUAGE ===
              _SectionHeader(title: l10n.settings_language),
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
              _SectionHeader(title: l10n.settings_appearance),
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
              _SectionHeader(title: l10n.settings_notifications),
              const SizedBox(height: LoloSpacing.spaceSm),
              LoloToggle(
                label: l10n.settings_pushNotifications,
                description: l10n.settings_receiveNotifications,
                value: settings.notificationsEnabled,
                onChanged: (v) => ref
                    .read(settingsNotifierProvider.notifier)
                    .setNotificationsEnabled(v),
              ),
              LoloToggle(
                label: l10n.settings_reminderAlerts,
                description: l10n.settings_reminderAlertsDesc,
                value: settings.reminderNotifications,
                onChanged: settings.notificationsEnabled
                    ? (v) => ref
                        .read(settingsNotifierProvider.notifier)
                        .setReminderNotifications(v)
                    : null,
                enabled: settings.notificationsEnabled,
              ),
              LoloToggle(
                label: l10n.settings_dailyActionCards,
                description: l10n.settings_dailyActionCardsDesc,
                value: settings.dailyCardNotifications,
                onChanged: settings.notificationsEnabled
                    ? (v) => ref
                        .read(settingsNotifierProvider.notifier)
                        .setDailyCardNotifications(v)
                    : null,
                enabled: settings.notificationsEnabled,
              ),
              LoloToggle(
                label: l10n.settings_weeklyDigest,
                description: l10n.settings_weeklyDigestDesc,
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
              _SectionHeader(title: l10n.settings_subscription),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.workspace_premium,
                label: currentUser?.isPremium == true
                    ? l10n.settings_premiumActive
                    : l10n.settings_upgradeToPremium,
                subtitle: currentUser?.isPremium == true
                    ? l10n.settings_manageSubscription
                    : l10n.settings_unlockAllFeatures,
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
              _SectionHeader(title: l10n.settings_about),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.info_outline,
                label: l10n.settings_aboutLolo,
                onTap: () => _showAboutDialog(context),
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                label: l10n.settings_termsOfService,
                onTap: () {/* Navigate to terms */},
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                label: l10n.settings_privacyPolicy,
                onTap: () {/* Navigate to privacy */},
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // === ACCOUNT ACTIONS ===
              _SectionHeader(title: l10n.settings_account),
              const SizedBox(height: LoloSpacing.spaceSm),
              _SettingsTile(
                icon: Icons.logout,
                label: l10n.settings_logOut,
                iconColor: LoloColors.colorWarning,
                onTap: () => _handleLogout(context, ref),
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                label: l10n.settings_deleteAccount,
                iconColor: LoloColors.colorError,
                labelColor: LoloColors.colorError,
                onTap: () => _handleDeleteAccount(context, ref),
              ),

              const SizedBox(height: LoloSpacing.space3xl),

              // App version
              Center(
                child: Text(
                  l10n.settings_appVersion('1.0.0'),
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
        title: Text(AppLocalizations.of(context).settings_logOutTitle),
        content: Text(AppLocalizations.of(context).settings_logOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).common_button_cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authNotifierProvider.notifier).signOut();
              context.go('/welcome');
            },
            child: Text(AppLocalizations.of(context).settings_logOut),
          ),
        ],
      ),
    );
  }

  void _handleDeleteAccount(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context).settings_deleteAccountTitle),
        content: Text(AppLocalizations.of(context).settings_deleteAccountMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).common_button_cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authRepositoryProvider).deleteAccount();
              context.go('/welcome');
            },
            style: TextButton.styleFrom(
                foregroundColor: LoloColors.colorError),
            child: Text(AppLocalizations.of(context).common_button_delete),
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
