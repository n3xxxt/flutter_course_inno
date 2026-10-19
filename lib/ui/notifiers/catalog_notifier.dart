import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../data/space_items_api.dart';
import '../../domain/entities/space_item.dart';

class CatalogNotifier extends ChangeNotifier {
  CatalogNotifier(this._api);

  final SpaceItemsApi _api;
  List<SpaceItem> _items = [];
  bool _isLoading = true;
  String? _error;
  bool _isDisposed = false;
  bool _loadStarted = false;

  bool get isLoading => _isLoading;

  String? get error => _error;

  List<SpaceItem> get items => UnmodifiableListView(_items);

  Future<void> load() async {
    if (_loadStarted) return;
    _loadStarted = true;
    _isLoading = true;
    _error = null;
    _notify();
    try {
      _items = await _api.fetchItems();
    } on SpaceItemsApiException catch (e) {
      _error = e.message;
    } finally {
      _loadStarted = false;
      _isLoading = false;
      _notify();
    }
  }

  Future<void> add(SpaceItem draft) async {
    final created = await _api.createItem(draft);
    _items = [created, ..._items];
    _notify();
  }

  void _notify() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
