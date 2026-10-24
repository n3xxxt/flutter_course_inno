import 'package:flutter/material.dart';

import '../../data/catalog_repository.dart';
import '../../domain/entities/space_item.dart';

class SpaceItemFormNotifier extends ChangeNotifier {
  SpaceItemFormNotifier({this.initial, required this.onSubmit})
    : titleController = TextEditingController(text: initial?.title),
      subtitleController = TextEditingController(text: initial?.subtitle),
      descriptionController = TextEditingController(text: initial?.description),
      _category = initial?.category ?? SpaceCategory.planet {
    titleController.addListener(_onTitleChanged);
    _lastTitle = titleController.text;
  }

  final SpaceItem? initial;
  final Future<void> Function(SpaceItem item) onSubmit;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  SpaceCategory _category;
  bool _isSending = false;
  bool _showTitleError = false;
  bool _isDisposed = false;
  String _lastTitle = '';
  String? _submitError;

  bool get isEditing => initial != null;

  SpaceCategory get category => _category;

  bool get isSending => _isSending;

  bool get showTitleError => _showTitleError;

  String? get submitError => _submitError;

  void selectCategory(SpaceCategory value) {
    _category = value;
    _notify();
  }

  /// Возвращает true, если элемент успешно сохранён.
  Future<bool> submit() async {
    if (_isSending) return false;
    final title = titleController.text.trim();
    if (title.isEmpty) {
      _showTitleError = true;
      _notify();
      return false;
    }
    _isSending = true;
    _submitError = null;
    _notify();
    final subtitle = subtitleController.text.trim();
    final description = descriptionController.text.trim();
    final base = initial;
    final item = base == null
        ? SpaceItem.draft(
            title: title,
            subtitle: subtitle,
            category: _category,
            description: description,
          )
        : base.copyWith(
            title: title,
            subtitle: subtitle,
            category: _category,
            description: description,
          );
    try {
      await onSubmit(item);
      return true;
    } on CatalogException catch (e) {
      _submitError = e.message;
      return false;
    } finally {
      _isSending = false;
      _notify();
    }
  }

  void _onTitleChanged() {
    final text = titleController.text;
    final changed = text != _lastTitle;
    _lastTitle = text;
    if (changed && _showTitleError) {
      _showTitleError = false;
      _notify();
    }
  }

  void _notify() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    titleController.removeListener(_onTitleChanged);
    titleController.dispose();
    subtitleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
