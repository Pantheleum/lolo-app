import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_mode_provider.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_mode_card.dart';
import 'package:lolo/features/subscription/presentation/providers/subscription_providers.dart';

/// Screen 19: AI Message Mode Picker.
///
/// Displays a 2-column grid of 10 mode cards. Free tier users
/// see modes 0-2 unlocked; modes 3-9 show a lock overlay.
/// Premium/free-pass users see all modes unlocked.
/// Tapping an unlocked mode navigates to the configuration screen.
/// Tapping a locked mode navigates to the paywall.
class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider).valueOrNull ?? false;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'AI Messages',
        showBackButton: false,
        showLogo: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('message-history'),
            tooltip: 'Message History',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              // Header text
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: LoloSpacing.spaceLg,
                    bottom: LoloSpacing.spaceMd,
                  ),
                  child: Text(
                    'Choose a message mode',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              // 2-column grid of mode cards
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: LoloSpacing.spaceSm,
                  crossAxisSpacing: LoloSpacing.spaceSm,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final mode = MessageMode.values[index];
                    final isLocked = !isPremium && mode.isLocked;
                    return MessageModeCard(
                      mode: mode,
                      isLocked: isLocked,
                      onTap: () => _onModeTapped(context, ref, mode, isLocked),
                    );
                  },
                  childCount: MessageMode.values.length,
                ),
              ),

              // Bottom spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: LoloSpacing.screenBottomPadding),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onModeTapped(
      BuildContext context, WidgetRef ref, MessageMode mode, bool isLocked) {
    if (isLocked) {
      context.pushNamed('paywall', extra: 'ai_messages');
      return;
    }

    ref.read(selectedMessageModeProvider.notifier).select(mode);
    context.pushNamed('generate-message');
  }
}
