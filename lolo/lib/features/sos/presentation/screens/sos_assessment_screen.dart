import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/router/route_names.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/features/sos/presentation/providers/sos_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class SosAssessmentScreen extends ConsumerStatefulWidget {
  const SosAssessmentScreen({super.key});
  @override
  ConsumerState<SosAssessmentScreen> createState() => _State();
}

class _State extends ConsumerState<SosAssessmentScreen> {
  int _step = 0;
  final _answers = <String, dynamic>{};

  static const _questions = [
    ('howLongAgo', 'How long ago did this happen?', ['minutes', 'hours', 'today', 'yesterday']),
    ('herCurrentState', 'How is she right now?', ['calm', 'upset', 'very_upset', 'crying', 'furious', 'silent']),
    ('haveYouSpoken', 'Have you spoken to her?', ['yes', 'no']),
    ('isSheTalking', 'Is she talking to you?', ['yes', 'no']),
    ('yourFault', 'Is it your fault?', ['yes', 'no', 'partially', 'unsure']),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    ref.listen(sosSessionNotifierProvider, (_, next) {
      next.whenOrNull(
        assessed: (_, __) => context.pushNamed(RouteNames.sosCoaching),
      );
    });

    final q = _questions[_step];

    return Scaffold(
      appBar: LoloAppBar(title: l10n.assessment),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_step + 1) / _questions.length,
              backgroundColor: LoloColors.darkBorderMuted,
              valueColor: const AlwaysStoppedAnimation(LoloColors.colorError),
            ),
            const SizedBox(height: LoloSpacing.xl),
            Text('${_step + 1}/${_questions.length}',
                style: theme.textTheme.labelMedium?.copyWith(color: LoloColors.colorError)),
            const SizedBox(height: LoloSpacing.sm),
            Text(q.$2, style: theme.textTheme.headlineSmall),
            const SizedBox(height: LoloSpacing.lg),
            Expanded(
              child: ListView.separated(
                itemCount: q.$3.length,
                separatorBuilder: (_, __) => const SizedBox(height: LoloSpacing.sm),
                itemBuilder: (_, i) {
                  final opt = q.$3[i];
                  final isSelected = _answers[q.$1]?.toString() == opt;
                  return Semantics(
                    label: opt.replaceAll('_', ' '),
                    selected: isSelected,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? LoloColors.colorError
                              : LoloColors.darkBorderMuted,
                        ),
                      ),
                      tileColor: isSelected
                          ? LoloColors.colorError.withValues(alpha: 0.1)
                          : null,
                      title: Text(opt.replaceAll('_', ' ').toUpperCase(),
                          style: const TextStyle(fontSize: 14)),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: LoloColors.colorError)
                          : null,
                      onTap: () {
                        setState(() {
                          if (q.$1 == 'haveYouSpoken' || q.$1 == 'isSheTalking') {
                            _answers[q.$1] = opt == 'yes';
                          } else {
                            _answers[q.$1] = opt;
                          }
                        });
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (_step < _questions.length - 1) {
                            setState(() => _step++);
                          } else {
                            ref.read(sosSessionNotifierProvider.notifier).assess(_answers);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            if (_step > 0)
              TextButton.icon(
                onPressed: () => setState(() => _step--),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: Text(l10n.back),
              ),
          ],
        ),
      ),
    );
  }
}
