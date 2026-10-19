import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import '../notifiers/add_item_form_notifier.dart';
import '../notifiers/catalog_notifier.dart';

class AddSpaceItemForm extends StatefulWidget {
  const AddSpaceItemForm({super.key, required this.catalog});

  final CatalogNotifier catalog;

  @override
  State<AddSpaceItemForm> createState() => _AddSpaceItemFormState();
}

class _AddSpaceItemFormState extends State<AddSpaceItemForm> {
  late final _form = AddItemFormNotifier(widget.catalog);

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final result = await _form.submit();
    if (!mounted) return;
    if (result.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось добавить объект: ${result.error}')),
      );
    } else if (result.sent) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _form,
      builder: (context, _) => _buildForm(),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6E4DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _form.titleController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Название',
              errorText: _form.showTitleError ? 'Введите название' : null,
            ),
            onSubmitted: (_) => _submit(),
          ),
          ExpansionTile(
            title: const Text('Дополнительно'),
            shape: const Border(),
            collapsedShape: const Border(),
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 8),
            children: [
              TextField(
                controller: _form.subtitleController,
                decoration: const InputDecoration(labelText: 'Подзаголовок'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<SpaceCategory>(
                key: ValueKey(_form.category),
                initialValue: _form.category,
                decoration: const InputDecoration(labelText: 'Категория'),
                items: [
                  for (final category in SpaceCategory.values)
                    DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          Icon(category.icon, size: 18),
                          const SizedBox(width: 8),
                          Text(category.label),
                        ],
                      ),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) _form.selectCategory(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          FilledButton(
            onPressed: _form.isSending ? null : _submit,
            child: _form.isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Отправить'),
          ),
        ],
      ),
    );
  }
}
