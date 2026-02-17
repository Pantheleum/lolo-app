import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';

/// Stats & Trends screen (Screen 32) with line chart, action breakdown,
/// personal bests, and AI insight tip.
class StatsTrendsScreen extends ConsumerStatefulWidget {
  const StatsTrendsScreen({super.key});

  @override
  ConsumerState<StatsTrendsScreen> createState() => _StatsTrendsScreenState();
}

class _StatsTrendsScreenState extends ConsumerState<StatsTrendsScreen> {
  int _selectedPeriod = 0; // 0=Week, 1=Month, 2=All Time
  bool _tipDismissed = false;

  static const _periodLabels = ['Week', 'Month', 'All Time'];

  @override
  Widget build(BuildContext context) {
    final asyncProfile = ref.watch(gamificationProfileProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(title: 'Stats & Trends'),
      body: asyncProfile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LoloSpacing.spaceSm),

              // Period toggle chips
              Row(
                children: List.generate(_periodLabels.length, (i) {
                  final selected = i == _selectedPeriod;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_periodLabels[i]),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedPeriod = i),
                      selectedColor: LoloColors.colorPrimary.withValues(alpha: 0.2),
                      side: selected
                          ? const BorderSide(color: LoloColors.colorPrimary)
                          : BorderSide.none,
                      labelStyle: TextStyle(
                        color: selected
                            ? LoloColors.colorPrimary
                            : (isDark
                                ? LoloColors.darkTextTertiary
                                : LoloColors.lightTextTertiary),
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: LoloSpacing.spaceXl),

              // Line chart (XP over time)
              Text('Activity Over Time', style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceMd),
              _ActivityLineChart(weeklyXp: profile.weeklyXp, isDark: isDark),
              const SizedBox(height: LoloSpacing.spaceXl),

              // Action breakdown bar chart
              Text('Action Breakdown', style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceMd),
              _ActionBreakdown(isDark: isDark),
              const SizedBox(height: LoloSpacing.spaceXl),

              // Personal bests
              Text('Personal Bests', style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceMd),
              _PersonalBests(profile: profile, isDark: isDark),
              const SizedBox(height: LoloSpacing.spaceXl),

              // AI Insight tip
              if (!_tipDismissed)
                _AiTipCard(
                  isDark: isDark,
                  onDismiss: () => setState(() => _tipDismissed = true),
                ),

              const SizedBox(height: LoloSpacing.screenBottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple line-style chart using XP bars with connected dots.
class _ActivityLineChart extends StatelessWidget {
  const _ActivityLineChart({required this.weeklyXp, required this.isDark});
  final List<WeeklyXp> weeklyXp;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (weeklyXp.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No activity for this period.\nStart by completing an action today!',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? LoloColors.darkTextTertiary
                  : LoloColors.lightTextTertiary,
            ),
          ),
        ),
      );
    }

    final maxXp = weeklyXp.fold<int>(1, (m, w) => w.xp > m ? w.xp : m);

    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: _LineChartPainter(
          data: weeklyXp,
          maxXp: maxXp,
          lineColor: LoloColors.colorPrimary,
          fillColor: LoloColors.colorPrimary.withValues(alpha: isDark ? 0.1 : 0.08),
          gridColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weeklyXp
                  .map((w) => Text(w.day,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? LoloColors.darkTextTertiary
                            : LoloColors.lightTextTertiary,
                      )))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.data,
    required this.maxXp,
    required this.lineColor,
    required this.fillColor,
    required this.gridColor,
  });

  final List<WeeklyXp> data;
  final int maxXp;
  final Color lineColor;
  final Color fillColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final chartH = size.height - 24; // leave room for labels
    final chartW = size.width;
    final stepX = chartW / (data.length - 1).clamp(1, data.length);

    // Grid lines
    final gridPaint = Paint()..color = gridColor..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = chartH * i / 3;
      canvas.drawLine(Offset(0, y), Offset(chartW, y), gridPaint);
    }

    // Build points
    final points = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1 ? chartW / 2 : i * stepX;
      final y = chartH - (data[i].xp / maxXp * chartH);
      points.add(Offset(x, y));
    }

    // Fill area
    final fillPath = Path()..moveTo(points.first.dx, chartH);
    for (final p in points) {
      fillPath.lineTo(p.dx, p.dy);
    }
    fillPath.lineTo(points.last.dx, chartH);
    fillPath.close();
    canvas.drawPath(fillPath, Paint()..color = fillColor);

    // Line
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Dots
    final dotPaint = Paint()..color = lineColor;
    for (final p in points) {
      canvas.drawCircle(p, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => true;
}

class _ActionBreakdown extends StatelessWidget {
  const _ActionBreakdown({required this.isDark});
  final bool isDark;

  // Placeholder data — would come from a provider in production
  static const _actions = [
    ('SAY', 0.45, Color(0xFF4A90D9)),
    ('DO', 0.28, Color(0xFF3FB950)),
    ('BUY', 0.17, Color(0xFFC9A96E)),
    ('GO', 0.10, Color(0xFFA371F7)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: _actions.map((action) {
        final (label, percent, color) = action;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(label,
                    style: theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: isDark
                        ? LoloColors.darkBgTertiary
                        : LoloColors.lightBgTertiary,
                    color: color,
                    minHeight: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 36,
                child: Text(
                  '${(percent * 100).round()}%',
                  style: theme.textTheme.labelSmall,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _PersonalBests extends StatelessWidget {
  const _PersonalBests({required this.profile, required this.isDark});
  final GamificationProfile profile;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cards = [
      (Icons.local_fire_department, 'Highest\nStreak', '${profile.longestStreak} days'),
      (Icons.emoji_events, 'Most Active\nWeek', '${profile.weeklyXp.fold<int>(0, (s, w) => s + w.xp)} XP'),
      (Icons.star, 'Favorite\nAction', 'SAY'),
    ];

    return Row(
      children: cards.map((card) {
        final (icon, label, value) = card;
        return Expanded(
          child: Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? LoloColors.darkSurfaceElevated1
                  : LoloColors.lightSurfaceElevated1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: LoloColors.colorAccent),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AiTipCard extends StatelessWidget {
  const _AiTipCard({required this.isDark, required this.onDismiss});
  final bool isDark;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? LoloColors.darkSurfaceElevated1
            : LoloColors.lightSurfaceElevated1,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(width: 4, color: LoloColors.colorAccent),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: LoloColors.colorAccent),
              const SizedBox(width: 6),
              Text('AI Insight',
                  style: theme.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(Icons.close, size: 18,
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "You're strongest in SAY actions but haven't tried a GO action "
            "this week. Plan a date night to balance your approach!",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? LoloColors.darkTextSecondary
                  : LoloColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
