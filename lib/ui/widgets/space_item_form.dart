import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/space_item.dart';
import '../../bloc/space_item_form/space_item_form_cubit.dart';
import '../../bloc/space_item_form/space_item_form_state.dart';
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
  late final _titleController = TextEditingController(
    text: widget.initial?.title,
  );
  late final _subtitleController = TextEditingController(
    text: widget.initial?.subtitle,
  );
  late final _descriptionController = TextEditingController(
    text: widget.initial?.description,
  );

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit(SpaceItemFormCubit cubit) async {
    final saved = await cubit.submit(
      title: _titleController.text,
      subtitle: _subtitleController.text,
      description: _descriptionController.text,
    );
    if (!mounted || !saved) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpaceItemFormCubit(
        initial: widget.initial,
        onSubmit: widget.onSubmit,
      ),
      child: BlocBuilder<SpaceItemFormCubit, SpaceItemFormState>(
        builder: (context, state) => _SpaceItemFormView(
          state: state,
          titleController: _titleController,
          subtitleController: _subtitleController,
          descriptionController: _descriptionController,
          onSubmit: () => _submit(context.read<SpaceItemFormCubit>()),
        ),
      ),
    );
  }
}

class _SpaceItemFormView extends StatelessWidget {
  const _SpaceItemFormView({
    required this.state,
    required this.titleController,
    required this.subtitleController,
    required this.descriptionController,
    required this.onSubmit,
  });

  final SpaceItemFormState state;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpaceItemFormCubit>();
    final isEditing = state.isEditing;
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
          controller: titleController,
          textInputAction: TextInputAction.next,
          onChanged: cubit.titleChanged,
          decoration: InputDecoration(
            labelText: AppStrings.formTitleLabel,
            errorText: state.showTitleError ? AppStrings.formTitleError : null,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: subtitleController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: AppStrings.formSubtitleLabel,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: descriptionController,
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
                selected: state.category == category,
                onSelected: (_) => cubit.selectCategory(category),
              ),
          ],
        ),
        if (state.submitError != null) ...[
          const SizedBox(height: 12),
          Text(
            state.submitError!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 16),
        FilledButton(
          onPressed: state.isSending ? null : onSubmit,
          child: state.isSending
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
