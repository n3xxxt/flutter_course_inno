import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_strings.dart';
import '../../domain/entities/space_item.dart';
import '../cubits/space_item_form_cubit.dart';
import '../cubits/space_item_form_state.dart';

/// Форма добавления и редактирования элемента каталога.
class SpaceItemForm extends StatefulWidget {
  const SpaceItemForm({super.key, this.initial, required this.onSubmit});

  final SpaceItem? initial;
  final Future<void> Function(SpaceItem item) onSubmit;

  @override
  State<SpaceItemForm> createState() => _SpaceItemFormState();
}

class _SpaceItemFormState extends State<SpaceItemForm> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _subtitle = TextEditingController(text: widget.initial?.subtitle);
  late final _description = TextEditingController(
    text: widget.initial?.description,
  );

  @override
  void dispose() {
    _title.dispose();
    _subtitle.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpaceItemFormCubit(
        initial: widget.initial,
        onSubmit: widget.onSubmit,
      ),
      child: BlocConsumer<SpaceItemFormCubit, SpaceItemFormState>(
        listenWhen: (previous, current) => !previous.saved && current.saved,
        listener: (context, state) => Navigator.pop(context, true),
        builder: (context, state) => _buildForm(context, state),
      ),
    );
  }

  Widget _buildForm(BuildContext context, SpaceItemFormState state) {
    final cubit = context.read<SpaceItemFormCubit>();
    final isEditing = cubit.isEditing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isEditing ? AppStrings.formEditTitle : AppStrings.formNewTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _title,
          onChanged: (_) => cubit.titleChanged(),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: AppStrings.titleLabel,
            errorText: state.showTitleError ? AppStrings.titleError : null,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _subtitle,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: AppStrings.subtitleLabel,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _description,
          minLines: 2,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            labelText: AppStrings.descriptionLabel,
          ),
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
          onPressed: state.isSending
              ? null
              : () => cubit.submit(
                  title: _title.text,
                  subtitle: _subtitle.text,
                  description: _description.text,
                ),
          child: state.isSending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? AppStrings.saveButton : AppStrings.addButton),
        ),
      ],
    );
  }
}
