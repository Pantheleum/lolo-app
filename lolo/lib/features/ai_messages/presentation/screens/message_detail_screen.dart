import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_provider.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_result_card.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/copy_share_bar.dart';
import 'package:lolo/features/ai_messages/presentation/widgets/message_feedback_widget.dart';
import 'package:share_plus/share_plus.dart';

/// Screen 21: Generated Message Result.
///
/// Displays the AI-generated message with typewriter animation,
/// action row (copy/share/edit/regenerate), star rating,
/// favorite toggle, model badge, and usage counter.
class MessageDetailScreen extends ConsumerStatefulWidget {
  const MessageDetailScreen({super.key});

  @override
  ConsumerState<MessageDetailScreen> createState() =>
      _MessageDetailScreenState();
}

class _MessageDetailScreenState
    extends ConsumerState<MessageDetailScreen> {
  bool _isEditing = false;
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController();
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generationState = ref.watch(messageGenerationNotifierProvider);
    final usageAsync = ref.watch(messageUsageProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: 'Your Message',
        showBackButton: true,
      ),
      body: generationState.when(
        idle: () => const Center(child: Text('No message generated yet.')),
        generating: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: LoloColors.colorPrimary),
              SizedBox(height: LoloSpacing.spaceMd),
              Text('Crafting your message...'),
            ],
          ),
        ),
        error: (errorMsg) => Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48,
                  color: LoloColors.colorError),
                const SizedBox(height: LoloSpacing.spaceMd),
                Text(errorMsg, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        success: (message) => _buildSuccessContent(
          context, message, usageAsync, theme, isDark,
        ),
      ),
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    GeneratedMessageEntity message,
    AsyncValue<({int used, int limit})> usageAsync,
    ThemeData theme,
    bool isDark,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LoloSpacing.spaceLg),

          // Hero message card with typewriter animation
          MessageResultCard(
            content: _isEditing ? null : message.content,
            isEditing: _isEditing,
            editController: _editController,
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          // Actions row: Copy, Share, Edit, Regenerate
          CopyShareBar(
            onCopy: () => _copyToClipboard(context, message.content),
            onShare: () => _shareMessage(message.content),
            onEdit: () => _toggleEdit(message.content),
            onRegenerate: () => ref
                .read(messageGenerationNotifierProvider.notifier)
                .regenerate(message.id),
            isEditing: _isEditing,
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // 5-star rating
          MessageFeedbackWidget(
            currentRating: message.rating,
            onRatingChanged: (rating) => ref
                .read(messageGenerationNotifierProvider.notifier)
                .rate(message.id, rating),
          ),

          const SizedBox(height: LoloSpacing.spaceMd),

          // Favorite toggle
          _FavoriteRow(
            isFavorite: message.isFavorite,
            onToggle: () => ref
                .read(messageGenerationNotifierProvider.notifier)
                .toggleFavorite(message.id),
          ),

          const SizedBox(height: LoloSpacing.spaceXl),

          // AI model badge
          if (message.modelBadge != null)
            Text(
              'Generated by ${message.modelBadge}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
            ),

          const SizedBox(height: LoloSpacing.spaceXs),

          // Usage counter
          usageAsync.when(
            data: (usage) => Text(
              '${usage.used} of ${usage.limit} messages used this month',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? LoloColors.darkTextTertiary
                    : LoloColors.lightTextTertiary,
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: LoloSpacing.space2xl),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareMessage(String content) {
    Share.share(content, subject: 'Message from LOLO');
  }

  void _toggleEdit(String content) {
    setState(() {
      if (!_isEditing) {
        _editController.text = content;
      }
      _isEditing = !_isEditing;
    });
  }
}

/// Favorite toggle row with animated heart icon.
class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({
    required this.isFavorite,
    required this.onToggle,
  });

  final bool isFavorite;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
                color: isFavorite
                    ? LoloColors.colorError
                    : LoloColors.darkTextSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isFavorite ? 'Saved to Favorites' : 'Save to Favorites',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
