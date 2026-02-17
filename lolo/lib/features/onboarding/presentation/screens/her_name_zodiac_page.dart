import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Step 4: Her name + zodiac sign horizontal carousel.
///
/// The zodiac picker is a horizontally scrollable list of sign icons.
/// Selecting "I don't know" skips the zodiac selection.
class HerNameZodiacPage extends ConsumerStatefulWidget {
  const HerNameZodiacPage({super.key});

  @override
  ConsumerState<HerNameZodiacPage> createState() => _HerNameZodiacPageState();
}

class _HerNameZodiacPageState extends ConsumerState<HerNameZodiacPage> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedZodiac;

  static const _zodiacSigns = [
    ('aries', '\u2648', 'Aries'),
    ('taurus', '\u2649', 'Taurus'),
    ('gemini', '\u264A', 'Gemini'),
    ('cancer', '\u264B', 'Cancer'),
    ('leo', '\u264C', 'Leo'),
    ('virgo', '\u264D', 'Virgo'),
    ('libra', '\u264E', 'Libra'),
    ('scorpio', '\u264F', 'Scorpio'),
    ('sagittarius', '\u2650', 'Sagittarius'),
    ('capricorn', '\u2651', 'Capricorn'),
    ('aquarius', '\u2652', 'Aquarius'),
    ('pisces', '\u2653', 'Pisces'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: LoloSpacing.space2xl),

            Text(
              l10n.onboarding_partner_title,
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Partner name input
            LoloTextField(
              label: l10n.onboarding_partner_hint,
              controller: _nameController,
              hint: l10n.onboarding_partner_hint,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter her name';
                }
                return null;
              },
            ),
            const SizedBox(height: LoloSpacing.spaceMd),

            // Partner nickname input (optional)
            LoloTextField(
              label: 'What do you call her?',
              controller: _nicknameController,
              hint: 'e.g., Babe, Habibi, Baby',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Zodiac label
            Text(
              l10n.onboarding_partner_label_zodiac,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: LoloSpacing.spaceSm),

            // Horizontal zodiac carousel
            SizedBox(
              height: 88,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _zodiacSigns.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: LoloSpacing.spaceXs),
                itemBuilder: (context, index) {
                  final (key, symbol, name) = _zodiacSigns[index];
                  final isSelected = _selectedZodiac == key;

                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedZodiac = isSelected ? null : key;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 72,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? LoloColors.colorPrimary.withValues(alpha: 0.15)
                            : isDark
                                ? LoloColors.darkSurfaceElevated1
                                : LoloColors.lightBgTertiary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? LoloColors.colorPrimary
                              : isDark
                                  ? LoloColors.darkBorderDefault
                                  : LoloColors.lightBorderDefault,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            symbol,
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            name,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isSelected
                                  ? LoloColors.colorPrimary
                                  : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: LoloSpacing.spaceSm),

            // "I don't know" option
            TextButton(
              onPressed: () => setState(() => _selectedZodiac = null),
              child: Text(
                l10n.onboarding_partner_label_zodiacUnknown,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.colorPrimary,
                ),
              ),
            ),

            const Spacer(),

            LoloPrimaryButton(
              label: l10n.common_button_continue,
              onPressed: _submit,
            ),
            const SizedBox(height: LoloSpacing.space2xl),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final nickname = _nicknameController.text.trim();
      ref.read(onboardingNotifierProvider.notifier).setPartnerInfo(
            name: _nameController.text.trim(),
            nickname: nickname.isNotEmpty ? nickname : null,
            zodiacSign: _selectedZodiac,
          );
    }
  }
}
