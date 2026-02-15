import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/presentation/providers/memory_provider.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/mood_selector.dart';
import 'package:lolo/features/memory_vault/presentation/widgets/tag_input.dart';

/// Form to create a new memory: title, description, date, category,
/// mood, tags, and photo upload option.
class CreateMemoryScreen extends ConsumerStatefulWidget {
  const CreateMemoryScreen({super.key});

  @override
  ConsumerState<CreateMemoryScreen> createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends ConsumerState<CreateMemoryScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  MemoryCategory _category = MemoryCategory.moment;
  String? _selectedMood;
  List<String> _tags = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _titleController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _selectedMood != null;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: LoloColors.colorPrimary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;

    setState(() => _isSubmitting = true);

    final memory = Memory(
      id: '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _selectedDate,
      category: _category,
      mood: _selectedMood!,
      tags: _tags,
    );

    final repository = ref.read(memoryRepositoryProvider);
    final result = await repository.createMemory(memory);

    setState(() => _isSubmitting = false);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: LoloColors.colorError,
          ),
        );
      },
      (_) {
        ref.invalidate(memoriesNotifierProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Memory saved!'),
            backgroundColor: LoloColors.colorSuccess,
          ),
        );
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(title: 'New Memory', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LoloSpacing.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LoloSpacing.spaceMd),

            // Title
            LoloTextField(
              label: 'Title',
              controller: _titleController,
              hint: 'Give this memory a name...',
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: LoloSpacing.spaceMd),

            // Description
            LoloTextField(
              label: 'Description',
              controller: _descriptionController,
              hint: 'What happened? How did you feel?',
              maxLines: 4,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Date picker
            Text(
              'Date',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                decoration: BoxDecoration(
                  color: isDark
                      ? LoloColors.darkBgTertiary
                      : LoloColors.lightBgTertiary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark
                        ? LoloColors.darkBorderDefault
                        : LoloColors.lightBorderDefault,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 18, color: LoloColors.colorPrimary),
                    const SizedBox(width: LoloSpacing.spaceXs),
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Category selector
            Text(
              'Category',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: MemoryCategory.values.map((cat) {
                final isSelected = _category == cat;
                return GestureDetector(
                  onTap: () => setState(() => _category = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? LoloColors.colorAccent
                              .withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? LoloColors.colorAccent
                            : (isDark
                                ? LoloColors.darkBorderDefault
                                : LoloColors.lightBorderDefault),
                      ),
                    ),
                    child: Text(
                      '${cat.emoji} ${cat.label}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? LoloColors.colorAccent
                            : (isDark
                                ? LoloColors.darkTextSecondary
                                : LoloColors.lightTextSecondary),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Mood selector
            Text(
              'How were you feeling?',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            MoodSelector(
              selectedMood: _selectedMood,
              onMoodSelected: (mood) =>
                  setState(() => _selectedMood = mood),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Tags
            Text(
              'Tags',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: LoloSpacing.spaceXs),
            TagInput(
              tags: _tags,
              onTagsChanged: (tags) => setState(() => _tags = tags),
            ),
            const SizedBox(height: LoloSpacing.spaceXl),

            // Photo upload placeholder
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Photo upload coming soon!')),
                );
              },
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: isDark
                      ? LoloColors.darkBgTertiary
                      : LoloColors.lightBgTertiary,
                  borderRadius: BorderRadius.circular(
                      LoloSpacing.cardBorderRadius),
                  border: Border.all(
                    color: isDark
                        ? LoloColors.darkBorderDefault
                        : LoloColors.lightBorderDefault,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 32,
                      color: isDark
                          ? LoloColors.darkTextTertiary
                          : LoloColors.lightTextTertiary,
                    ),
                    const SizedBox(height: LoloSpacing.space2xs),
                    Text(
                      'Add photos',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? LoloColors.darkTextTertiary
                            : LoloColors.lightTextTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: LoloSpacing.space2xl),

            // Submit button
            LoloPrimaryButton(
              label: 'Save Memory',
              icon: Icons.save_outlined,
              isLoading: _isSubmitting,
              isEnabled: _canSubmit,
              onPressed: _canSubmit ? _submit : null,
            ),
            const SizedBox(height: LoloSpacing.screenBottomPaddingNoNav),
          ],
        ),
      ),
    );
  }
}
