import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/core/widgets/reminder_tile.dart';
import 'package:lolo/core/widgets/action_card.dart';
import 'package:lolo/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:lolo/features/dashboard/presentation/widgets/greeting_header.dart';
import 'package:lolo/features/dashboard/presentation/widgets/streak_widget.dart';
import 'package:lolo/features/dashboard/presentation/widgets/quick_actions_row.dart';
import 'package:lolo/features/notifications/presentation/providers/notifications_provider.dart';

/// Home / Dashboard screen showing greeting, streak, reminders,
/// daily action cards, and quick action buttons.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: 'LOLO',
        showBackButton: false,
        showLogo: true,
        actions: [
          _NotificationBellButton(),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const _HomeSkeleton(),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Something went wrong', style: theme.textTheme.bodyLarge),
              const SizedBox(height: LoloSpacing.spaceMd),
              TextButton(
                onPressed: () =>
                    ref.read(dashboardNotifierProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (dashboard) => RefreshIndicator(
          onRefresh: () =>
              ref.read(dashboardNotifierProvider.notifier).refresh(),
          color: LoloColors.colorPrimary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: LoloSpacing.spaceXs),

                // Greeting
                GreetingHeader(
                  userName: dashboard.userName,
                  partnerName: dashboard.partnerName,
                ),
                const SizedBox(height: LoloSpacing.spaceMd),

                // Streak + Level
                StreakWidget(
                  streak: dashboard.streak,
                  level: dashboard.level,
                  xpProgress: dashboard.xpProgress,
                  activeDays: dashboard.activeDays,
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Quick Actions
                QuickActionsRow(
                  onSos: () => context.pushNamed('sos'),
                  onAiMessage: () => context.pushNamed('messages'),
                  onGiftIdeas: () => context.pushNamed('gifts'),
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Upcoming Reminders
                if (dashboard.upcomingReminders.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: LoloSpacing.screenHorizontalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Reminders',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.pushNamed('reminders'),
                          child: Text(
                            'See All',
                            style: TextStyle(color: LoloColors.colorPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  ...dashboard.upcomingReminders.map(
                    (reminder) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: LoloSpacing.screenHorizontalPadding,
                        vertical: LoloSpacing.space2xs,
                      ),
                      child: ReminderTile(
                        title: reminder.title,
                        date: reminder.date,
                        category: _mapCategory(reminder.category),
                        onTap: () => context.pushNamed('reminders'),
                      ),
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXl),
                ],

                // Daily Action Cards
                if (dashboard.dailyCards.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: LoloSpacing.screenHorizontalPadding,
                    ),
                    child: Text(
                      'Today\'s Actions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceSm),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      padEnds: false,
                      controller: _pageController,
                      itemCount: dashboard.dailyCards.length,
                      itemBuilder: (context, index) {
                        final card = dashboard.dailyCards[index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: LoloSpacing.screenHorizontalPadding,
                            end: LoloSpacing.spaceXs,
                          ),
                          child: ActionCard(
                            type: _mapCardType(card.type),
                            title: card.title,
                            body: card.body,
                            difficulty: card.difficulty,
                            xpValue: card.xpValue,
                            isCompact: true,
                            onTap: () => context.pushNamed(
                              'action-card-detail',
                              pathParameters: {'id': card.id},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                const SizedBox(height: LoloSpacing.screenBottomPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ReminderCategory _mapCategory(String category) => switch (category) {
        'birthday' => ReminderCategory.birthday,
        'anniversary' => ReminderCategory.anniversary,
        'holiday' => ReminderCategory.holiday,
        _ => ReminderCategory.custom,
      };

  ActionCardType _mapCardType(String type) => switch (type) {
        'say' => ActionCardType.say,
        'do' => ActionCardType.doo,
        'buy' => ActionCardType.buy,
        'go' => ActionCardType.go,
        _ => ActionCardType.say,
      };
}

class _HomeSkeleton extends StatelessWidget {
  const _HomeSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LoloSpacing.spaceMd),
            const LoloSkeleton(width: 200, height: 28),
            const SizedBox(height: LoloSpacing.spaceXs),
            const LoloSkeleton(width: 260, height: 16),
            const SizedBox(height: LoloSpacing.spaceXl),
            const LoloSkeleton(width: double.infinity, height: 100),
            const SizedBox(height: LoloSpacing.spaceXl),
            const LoloSkeleton(width: double.infinity, height: 64),
            const SizedBox(height: LoloSpacing.spaceXl),
            const LoloSkeleton(width: 160, height: 20),
            const SizedBox(height: LoloSpacing.spaceSm),
            ...List.generate(
              3,
              (_) => const Padding(
                padding: EdgeInsets.only(bottom: LoloSpacing.spaceXs),
                child: LoloSkeleton(width: double.infinity, height: 80),
              ),
            ),
          ],
        ),
      );
}

class _NotificationBellButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider);

    return IconButton(
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(
          unread > 9 ? '9+' : '$unread',
          style: const TextStyle(fontSize: 10),
        ),
        child: const Icon(Icons.notifications_outlined),
      ),
      onPressed: () => context.pushNamed('notifications'),
      tooltip: 'Notifications',
    );
  }
}
