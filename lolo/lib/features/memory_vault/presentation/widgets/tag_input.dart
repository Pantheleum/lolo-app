import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Tag input field with chip display.
///
/// Tags are added by pressing Enter or the add button.
/// Each tag appears as a removable chip.
class TagInput extends StatefulWidget {
  const TagInput({
    required this.tags,
    required this.onTagsChanged,
    this.hint = 'Add a tag...',
    super.key,
  });

  final List<String> tags;
  final ValueChanged<List<String>> onTagsChanged;
  final String hint;

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTag() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.tags.contains(text)) {
      widget.onTagsChanged([...widget.tags, text]);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  void _removeTag(String tag) {
    widget.onTagsChanged(widget.tags.where((t) => t != tag).toList());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Existing tags
        if (widget.tags.isNotEmpty) ...[
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.tags.map((tag) {
              return Chip(
                label: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 12,
                    color: LoloColors.colorPrimary,
                  ),
                ),
                backgroundColor:
                    LoloColors.colorPrimary.withValues(alpha: 0.1),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  color: LoloColors.colorPrimary,
                ),
                onDeleted: () => _removeTag(tag),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: LoloColors.colorPrimary.withValues(alpha: 0.3),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
        ],

        // Input field
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onSubmitted: (_) => _addTag(),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  isDense: true,
                  filled: true,
                  fillColor: isDark
                      ? LoloColors.darkBgTertiary
                      : LoloColors.lightBgTertiary,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isDark
                          ? LoloColors.darkBorderDefault
                          : LoloColors.lightBorderDefault,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: LoloSpacing.spaceXs),
            IconButton(
              onPressed: _addTag,
              icon: const Icon(Icons.add_circle, color: LoloColors.colorPrimary),
              tooltip: 'Add tag',
            ),
          ],
        ),
      ],
    );
  }
}
