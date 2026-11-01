import '../../domain/entities/space_item.dart';

/// Состояние экрана каталога.
sealed class CatalogState {
  const CatalogState();
}

/// Каталог загружается.
class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

/// Загрузка или подписка завершились ошибкой.
class CatalogError extends CatalogState {
  const CatalogError(this.message);

  final String message;
}

/// Каталог загружен.
class CatalogLoaded extends CatalogState {
  const CatalogLoaded({
    required this.items,
    required this.favorites,
    this.onlyFavorites = false,
    this.query = '',
  });

  final List<SpaceItem> items;
  final Set<String> favorites;
  final bool onlyFavorites;
  final String query;

  /// Элементы с учётом фильтра избранного и поискового запроса.
  List<SpaceItem> get visibleItems {
    final needle = query.trim().toLowerCase();
    return items.where((item) {
      if (onlyFavorites && !favorites.contains(item.id)) return false;
      return needle.isEmpty || item.title.toLowerCase().contains(needle);
    }).toList();
  }

  /// Количество элементов каталога в избранном.
  int get favoritesCount =>
      items.where((item) => favorites.contains(item.id)).length;

  /// Лайкнут ли элемент текущим пользователем.
  bool isLiked(String id) => favorites.contains(id);

  /// Элемент каталога по id или null.
  SpaceItem? itemById(String id) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// Копия состояния с изменёнными полями.
  CatalogLoaded copyWith({
    List<SpaceItem>? items,
    Set<String>? favorites,
    bool? onlyFavorites,
    String? query,
  }) {
    return CatalogLoaded(
      items: items ?? this.items,
      favorites: favorites ?? this.favorites,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
      query: query ?? this.query,
    );
  }
}
