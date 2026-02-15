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
