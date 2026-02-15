import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/sos_coaching_card.dart';
import 'package:lolo/features/sos_mode/presentation/providers/sos_provider.dart';
import 'package:lolo/features/sos_mode/presentation/widgets/coaching_message_bubble.dart';
import 'package:lolo/features/sos_mode/presentation/widgets/severity_indicator.dart';

/// Real-time SSE streaming coaching interface.
///
/// Displays AI coaching steps as they arrive. Each step has "say this",
/// "why it works", "don't say", body language tips, and tone advice.
class SosCoachingScreen extends ConsumerStatefulWidget {
  const SosCoachingScreen({super.key});

  @override
  ConsumerState<SosCoachingScreen> createState() => _SosCoachingScreenState();
}

class _SosCoachingScreenState extends ConsumerState<SosCoachingScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Start streaming coaching steps once mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sosNotifierProvider.notifier).startCoaching();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final sosState = ref.watch(sosNotifierProvider);
    final assessment = sosState.assessment;
    final steps = sosState.coachingSteps;

    // Auto-scroll when new steps arrive.
    ref.listen<SosState>(sosNotifierProvider, (prev, next) {
      if (next.coachingSteps.length > (prev?.coachingSteps.length ?? 0)) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });

    return Scaffold(
      appBar: LoloAppBar(title: 'Live Coaching', showBackButton: true),
      body: Column(
        children: [
          // Severity header
          if (assessment != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(LoloSpacing.spaceMd),
              color: isDark
                  ? LoloColors.darkBgSecondary
                  : LoloColors.lightBgSecondary,
              child: Column(
                children: [
                  SeverityIndicator(
                    score: assessment.severityScore,
                    label: assessment.severityLabel,
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Text(
                    assessment.coachingPlan.keyInsight,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: isDark
                          ? LoloColors.darkTextSecondary
                          : LoloColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

          // Coaching steps list
          Expanded(
            child: steps.isEmpty && sosState.isStreaming
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            LoloColors.colorPrimary,
                          ),
                        ),
                        const SizedBox(height: LoloSpacing.spaceMd),
                        Text(
                          'Analyzing situation...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? LoloColors.darkTextSecondary
                                : LoloColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(
                      LoloSpacing.screenHorizontalPadding,
                    ),
                    itemCount: steps.length + (sosState.isStreaming ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Streaming indicator at the end
                      if (index == steps.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  LoloColors.colorPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      final step = steps[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: LoloSpacing.spaceMd,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step header
                            CoachingMessageBubble(
                              message:
                                  'Step ${step.stepNumber} of ${step.totalSteps}',
                              isAi: true,
                              subtitle: step.toneAdvice,
                            ),
                            const SizedBox(height: LoloSpacing.spaceXs),

                            // Say this card
                            SOSCoachingCard(
                              variant: SOSCardVariant.sayThis,
                              header: 'Say This',
                              content: step.sayThis,
                              example: step.sayThis,
                            ),
                            const SizedBox(height: LoloSpacing.spaceXs),

                            // Why it works
                            CoachingMessageBubble(
                              message: step.whyItWorks,
                              isAi: true,
                              subtitle: 'Why this works',
                            ),

                            // Don't say
                            if (step.doNotSay.isNotEmpty) ...[
                              const SizedBox(height: LoloSpacing.spaceXs),
                              SOSCoachingCard(
                                variant: SOSCardVariant.dontSay,
                                header: "Don't Say",
                                content: step.doNotSay.join('\n'),
                              ),
                            ],

                            // Body language tip
                            const SizedBox(height: LoloSpacing.spaceXs),
                            SOSCoachingCard(
                              variant: SOSCardVariant.doThis,
                              header: 'Body Language',
                              content: step.bodyLanguageTip,
                            ),

                            // Wait for prompt
                            if (step.waitFor != null) ...[
                              const SizedBox(height: LoloSpacing.spaceXs),
                              CoachingMessageBubble(
                                message: 'Wait for: ${step.waitFor}',
                                isAi: true,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Bottom action bar
          if (!sosState.isStreaming && steps.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
              decoration: BoxDecoration(
                color: isDark
                    ? LoloColors.darkBgSecondary
                    : LoloColors.lightBgSecondary,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? LoloColors.darkBorderMuted
                        : LoloColors.lightBorderMuted,
                  ),
                ),
              ),
              child: SafeArea(
                child: LoloPrimaryButton(
                  label: 'Finish Coaching',
                  icon: Icons.check_circle_outline,
                  onPressed: () => context.push('/sos/complete'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
