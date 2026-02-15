// FILE: lib/features/ai/presentation/widgets/usage_indicator.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class AiUsageIndicator extends ConsumerWidget {
  final AiRequestType type;
  final bool compact;

  const AiUsageIndicator({
    super.key,
    required this.type,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(costTrackerProvider)[type];
    if (snapshot == null) return const SizedBox.shrink();
    if (snapshot.isUnlimited) {
      return compact
          ? const Icon(Icons.all_inclusive, size: 16)
          : const Text('Unlimited');
    }

    final theme = Theme.of(context);
    final percentage = snapshot.usagePercentage;
    final color = percentage > 0.9
        ? theme.colorScheme.error
        : percentage > 0.7
            ? Colors.orange
            : theme.colorScheme.primary;

    if (compact) {
      return Text(
        '${snapshot.remaining}',
        style: theme.textTheme.labelSmall?.copyWith(color: color),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${snapshot.used}/${snapshot.limit}',
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
            const SizedBox(width: 4),
            Text(
              _typeLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 120,
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(color),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  String get _typeLabel => switch (type) {
        AiRequestType.message => 'messages this month',
        AiRequestType.gift => 'gift requests this month',
        AiRequestType.sosAssessment => 'SOS sessions this month',
        AiRequestType.actionCard => 'cards today',
        _ => 'requests',
      };
}
