import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final asyncOfferings = ref.watch(offeringsProvider);
    final purchaseState = ref.watch(purchaseNotifierProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.upgradePlan),
      body: asyncOfferings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (offerings) {
          final current = offerings.current;
          if (current == null) return Center(child: Text(l10n.noPlansAvailable));
          final packages = current.availablePackages;

          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceLg),
            child: Column(
              children: [
                _HeroBanner(),
                const SizedBox(height: LoloSpacing.spaceLg),
                _TierComparison(),
                const SizedBox(height: LoloSpacing.spaceLg),
                ...packages.map((pkg) => Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: LoloSpacing.spaceSm),
                  child: _PackageCard(
                    package: pkg,
                    isLoading: purchaseState is AsyncLoading,
                    onTap: () => ref.read(purchaseNotifierProvider.notifier).purchase(pkg),
                  ),
                )),
                const SizedBox(height: LoloSpacing.spaceMd),
                TextButton(
                  onPressed: purchaseState is AsyncLoading
                      ? null
                      : () => ref.read(purchaseNotifierProvider.notifier).restore(),
                  child: Text(l10n.restorePurchases),
                ),
                const SizedBox(height: LoloSpacing.spaceSm),
                Text(l10n.subscriptionTerms,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.white38),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceXl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC9A96E), Color(0xFF8B6914)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium, size: 48, color: Colors.white),
          const SizedBox(height: LoloSpacing.spaceSm),
          Text(l10n.unlockFullPotential,
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: LoloSpacing.spaceXs),
          Text(l10n.paywallSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TierComparison extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const features = [
      ('AI Messages', '5/mo', '100/mo', 'Unlimited'),
      ('Action Cards', '3/day', '10/day', 'Unlimited'),
      ('SOS Sessions', '2/mo', '10/mo', 'Unlimited'),
      ('Memories', '20', '200', 'Unlimited'),
      ('Message Modes', '3', '7', '10'),
      ('Streak Freezes', '1/mo', '3/mo', '5/mo'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: LoloColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceMd),
            child: Row(
              children: [
                const Expanded(flex: 3, child: SizedBox()),
                Expanded(flex: 2, child: Text('Free',
                    textAlign: TextAlign.center, style: theme.textTheme.labelMedium)),
                Expanded(flex: 2, child: Text('Pro',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorPrimary))),
                Expanded(flex: 2, child: Text('Legend',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorAccent))),
              ],
            ),
          ),
          const Divider(height: 1),
          ...features.map((f) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: LoloSpacing.spaceMd, vertical: LoloSpacing.spaceSm),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(f.$1, style: theme.textTheme.bodySmall)),
                Expanded(flex: 2, child: Text(f.$2,
                    textAlign: TextAlign.center, style: theme.textTheme.bodySmall)),
                Expanded(flex: 2, child: Text(f.$3,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorPrimary))),
                Expanded(flex: 2, child: Text(f.$4,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: LoloColors.colorAccent))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.package,
    required this.isLoading,
    required this.onTap,
  });
  final Package package;
  final bool isLoading;
  final VoidCallback onTap;

  bool get _isPopular =>
      package.identifier.contains('pro') && package.identifier.contains('yearly');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final price = package.storeProduct.priceString;
    final title = package.storeProduct.title;
    final isLegend = package.identifier.contains('legend');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(LoloSpacing.spaceMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isPopular
                  ? LoloColors.colorPrimary
                  : isLegend
                      ? LoloColors.colorAccent
                      : LoloColors.darkBorderMuted,
              width: _isPopular ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleSmall),
                    Text(price, style: theme.textTheme.headlineSmall?.copyWith(
                      color: isLegend ? LoloColors.colorAccent : LoloColors.colorPrimary,
                    )),
                  ],
                ),
              ),
              FilledButton(
                onPressed: isLoading ? null : onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: isLegend ? LoloColors.colorAccent : LoloColors.colorPrimary,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Subscribe'),
              ),
            ],
          ),
        ),
        if (_isPopular)
          Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: LoloColors.colorPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('MOST POPULAR',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}
