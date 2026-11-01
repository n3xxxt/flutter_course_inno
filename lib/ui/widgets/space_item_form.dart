import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import '../notifiers/space_item_form_notifier.dart';
import '../../core/app_strings.dart';

/// Форма добавления и редактирования элемента каталога.
class SpaceItemForm extends StatefulWidget {
  const SpaceItemForm({super.key, this.initial, required this.onSubmit});

  final SpaceItem? initial;
  final Future<void> Function(SpaceItem item) onSubmit;

  @override
  State<SpaceItemForm> createState() => _SpaceItemFormState();
}

class _SpaceItemFormState extends State<SpaceItemForm> {
  late final _form = SpaceItemFormNotifier(
    initial: widget.initial,
    onSubmit: widget.onSubmit,
  );

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final saved = await _form.submit();
    if (!mounted || !saved) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _form,
      builder: (context, _) => _buildForm(),
    );
  }

  Widget _buildForm() {
    final isEditing = _form.isEditing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isEditing ? AppStrings.formEditing : AppStrings.formNewItem,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _form.titleController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: AppStrings.formTitleLabel,
            errorText: _form.showTitleError ? AppStrings.formTitleError : null,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _form.subtitleController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: AppStrings.formSubtitleLabel,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _form.descriptionController,
          minLines: 2,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(labelText: AppStrings.description),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final category in SpaceCategory.values)
              ChoiceChip(
                avatar: Icon(category.icon, size: 18),
                label: Text(category.label),
                selected: _form.category == category,
                onSelected: (_) => _form.selectCategory(category),
              ),
          ],
        ),
        if (_form.submitError != null) ...[
          const SizedBox(height: 12),
          Text(
            _form.submitError!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _form.isSending ? null : _submit,
          child: _form.isSending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? AppStrings.save : AppStrings.add),
        ),
      ],
    );
  }
}
