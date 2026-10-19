import 'package:flutter/material.dart';

import '../../data/space_items_api.dart';
import '../../domain/entities/space_item.dart';
import 'catalog_notifier.dart';

class AddItemFormNotifier extends ChangeNotifier {
  AddItemFormNotifier(this._catalog) {
    titleController.addListener(_onTitleChanged);
    _lastTitle = titleController.text;
  }

  final CatalogNotifier _catalog;
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  SpaceCategory _category = SpaceCategory.planet;
  bool _isSending = false;
  bool _showTitleError = false;
  bool _isDisposed = false;
  String _lastTitle = '';

  SpaceCategory get category => _category;

  bool get isSending => _isSending;

  bool get showTitleError => _showTitleError;

  void selectCategory(SpaceCategory value) {
    _category = value;
    _notify();
  }

  /// `sent` — объект создан; `error` — сообщение об ошибке отправки.
  Future<({bool sent, String? error})> submit() async {
    if (_isSending) return (sent: false, error: null);
    final title = titleController.text.trim();
    if (title.isEmpty) {
      _showTitleError = true;
      _notify();
      return (sent: false, error: null);
    }
    _isSending = true;
    _notify();
    try {
      await _catalog.add(
        SpaceItem.draft(
          title: title,
          subtitle: subtitleController.text.trim(),
          category: _category,
        ),
      );
      if (_isDisposed) return (sent: true, error: null);
      titleController.clear();
      subtitleController.clear();
      _category = SpaceCategory.planet;
      return (sent: true, error: null);
    } on SpaceItemsApiException catch (e) {
      return (sent: false, error: e.message);
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
    super.dispose();
  }
}
