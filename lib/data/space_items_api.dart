import '../domain/entities/space_item.dart';

/// Ошибка обращения к серверу с понятным пользователю сообщением.
class SpaceItemsApiException implements Exception {
  const SpaceItemsApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Источник объектов каталога.
abstract interface class SpaceItemsApi {
  /// Загружает все объекты каталога.
  Future<List<SpaceItem>> fetchItems();

  /// Создаёт объект на сервере и возвращает его с выданным id.
  Future<SpaceItem> createItem(SpaceItem item);
}
