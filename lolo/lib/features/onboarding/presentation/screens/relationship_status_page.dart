import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 5: Relationship status selection.
///
/// Displays 5 selectable cards: Dating, Engaged, Newlywed, Married, Long Distance.
/// Single-select with auto-advance on tap.
class RelationshipStatusPage extends ConsumerStatefulWidget {
  const RelationshipStatusPage({super.key});

  @override
  ConsumerState<RelationshipStatusPage> createState() =>
      _RelationshipStatusPageState();
}

class _RelationshipStatusPageState
    extends ConsumerState<RelationshipStatusPage> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final statuses = [
      _StatusOption(
        key: 'dating',
        icon: Icons.favorite_outline,
        label: l10n.onboarding_status_dating,
        color: LoloColors.colorPrimary,
      ),
      _StatusOption(
        key: 'engaged',
        icon: Icons.diamond_outlined,
        label: l10n.onboarding_status_engaged,
        color: LoloColors.colorAccent,
      ),
      _StatusOption(
        key: 'newlywed',
        icon: Icons.celebration_outlined,
        label: l10n.onboarding_status_newlywed,
        color: LoloColors.colorSuccess,
      ),
      _StatusOption(
        key: 'married',
        icon: Icons.home_outlined,
        label: l10n.onboarding_status_married,
        color: LoloColors.colorInfo,
      ),
      _StatusOption(
        key: 'long_distance',
        icon: Icons.flight_outlined,
        label: l10n.onboarding_status_longDistance,
        color: LoloColors.cardTypeGo,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: LoloSpacing.space2xl),

          Text(
            l10n.onboarding_partner_label_status,
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoloSpacing.space2xl),

          ...statuses.map(
            (status) => Padding(
              padding: const EdgeInsets.only(
                bottom: LoloSpacing.spaceSm,
              ),
              child: _StatusCard(
                option: status,
                isSelected: _selected == status.key,
                onTap: () {
                  setState(() => _selected = status.key);
                  // Short delay for visual feedback, then auto-advance
                  Future.delayed(
                    const Duration(milliseconds: 300),
                    () {
                      if (mounted) {
                        ref
                            .read(onboardingNotifierProvider.notifier)
                            .setRelationshipStatus(status.key);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusOption {
  final String key;
  final IconData icon;
  final String label;
  final Color color;

  const _StatusOption({
    required this.key,
    required this.icon,
    required this.label,
    required this.color,
  });
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _StatusOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isSelected
          ? option.color.withValues(alpha: 0.12)
          : isDark
              ? LoloColors.darkSurfaceElevated1
              : LoloColors.lightSurfaceElevated1,
      borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.spaceMd,
            vertical: LoloSpacing.spaceMd,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
            border: Border.all(
              color: isSelected
                  ? option.color
                  : isDark
                      ? LoloColors.darkBorderDefault
                      : LoloColors.lightBorderDefault,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(option.icon, color: option.color, size: 28),
              const SizedBox(width: LoloSpacing.spaceMd),
              Text(
                option.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? option.color : null,
                    ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(Icons.check_circle, color: option.color, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
