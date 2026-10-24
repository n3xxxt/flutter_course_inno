import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/catalog_repository.dart';
import '../../domain/entities/space_item.dart';
import 'catalog_state.dart';

/// Кубит каталога: загрузка, реалтайм, избранное, фильтр и поиск.
class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._repository, {required String uid})
    : _uid = uid,
      super(const CatalogLoading());

  final CatalogRepository _repository;
  final String _uid;

  StreamSubscription<List<SpaceItem>>? _itemsSub;
  StreamSubscription<Set<String>>? _favoritesSub;
  Set<String> _favorites = const {};
  bool _onlyFavorites = false;
  String _query = '';
  int _generation = 0;

  /// Загружает каталог и подписывается на изменения.
  Future<void> load() async {
    final generation = ++_generation;
    await _cancelSubscriptions();
    if (isClosed || generation != _generation) return;
    emit(const CatalogLoading());
    _favoritesSub = _repository.watchFavorites(_uid).listen((favorites) {
      _favorites = favorites;
      final current = state;
      if (current is CatalogLoaded) {
        emit(current.copyWith(favorites: favorites));
      }
    }, onError: (Object error) => _fail(error, generation));
    final List<SpaceItem> items;
    try {
      items = await _repository.fetchItems();
    } on CatalogException catch (e) {
      if (isClosed || generation != _generation) return;
      await _cancelSubscriptions();
      emit(CatalogError(e.message));
      return;
    }
    if (isClosed || generation != _generation) return;
    emit(
      CatalogLoaded(
        items: items,
        favorites: _favorites,
        onlyFavorites: _onlyFavorites,
        query: _query,
      ),
    );
    _itemsSub = _repository.watchItems().listen((items) {
      final current = state;
      if (current is CatalogLoaded) emit(current.copyWith(items: items));
    }, onError: (Object error) => _fail(error, generation));
  }

  /// Переключает лайк элемента для текущего пользователя.
  Future<void> toggleLike(String id) {
    return _repository.setFavorite(_uid, id, liked: !_favorites.contains(id));
  }

  /// Включает или выключает фильтр «Только избранные».
  void toggleOnlyFavorites() {
    final current = state;
    if (current is! CatalogLoaded) return;
    _onlyFavorites = !current.onlyFavorites;
    emit(current.copyWith(onlyFavorites: _onlyFavorites));
  }

  /// Задаёт поисковый запрос по названию.
  void search(String query) {
    final current = state;
    if (current is! CatalogLoaded) return;
    _query = query;
    emit(current.copyWith(query: query));
  }

  /// Добавляет новый элемент в каталог.
  Future<void> addItem(SpaceItem draft) => _repository.addItem(draft);

  /// Сохраняет изменения элемента.
  Future<void> updateItem(SpaceItem item) => _repository.updateItem(item);

  /// Удаляет элемент каталога.
  Future<void> deleteItem(String id) => _repository.deleteItem(id);

  @override
  Future<void> close() async {
    _generation++;
    await _cancelSubscriptions();
    return super.close();
  }

  void _fail(Object error, int generation) {
    if (isClosed || generation != _generation) return;
    _generation++;
    unawaited(_cancelSubscriptions());
    emit(CatalogError(error is CatalogException ? error.message : '$error'));
  }

  Future<void> _cancelSubscriptions() async {
    final items = _itemsSub;
    final favorites = _favoritesSub;
    _itemsSub = null;
    _favoritesSub = null;
    await items?.cancel();
    await favorites?.cancel();
  }
}
