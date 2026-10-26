/// Пользовательские тексты приложения.
abstract final class AppStrings {
  static const String appTitle = 'Каталог космоса';

  static const String loginSignInTitle = 'Вход';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Пароль';
  static const String passwordHelper = 'Минимум 6 символов';
  static const String registerButton = 'Зарегистрироваться';
  static const String signInButton = 'Войти';
  static const String enterEmail = 'Введите email';
  static const String enterPassword = 'Введите пароль';

  static const String addObjectTooltip = 'Добавить объект';
  static const String signOutTooltip = 'Выйти';
  static const String searchHint = 'Поиск по названию';
  static const String clearTooltip = 'Очистить';
  static const String onlyFavorites = 'Только избранные';
  static const String objectAdded = 'Объект добавлен';
  static const String emptyFavorites = 'В избранном пока пусто';
  static const String emptyCatalog = 'Каталог пуст — добавьте первый объект';
  static const String catalogLoadFailed = 'Не удалось загрузить каталог';
  static const String retryButton = 'Обновить';

  static String itemsCount(int count) => '$count объектов в каталоге';

  static String favoritesCount(int count) => 'В избранном: $count';

  static String nothingFound(String query) =>
      'Ничего не найдено по запросу «$query»';

  static const String objectDeleted = 'Объект удалён';
  static const String changesSaved = 'Изменения сохранены';
  static const String deleteDialogTitle = 'Удалить объект?';
  static const String cancelButton = 'Отмена';
  static const String deleteButton = 'Удалить';
  static const String objectNotFound = 'Объект не найден';
  static const String editTooltip = 'Изменить';
  static const String deleteTooltip = 'Удалить';
  static const String descriptionTitle = 'Описание';
  static const String descriptionEmpty = 'Описание пока не добавлено';

  static String deleteDialogContent(String title) =>
      '“$title” будет удалён из каталога для всех пользователей.';

  static String addedAt(String date) => 'Добавлено: $date';

  static const String formEditTitle = 'Редактирование';
  static const String formNewTitle = 'Новый объект';
  static const String titleLabel = 'Название *';
  static const String titleError = 'Введите название';
  static const String subtitleLabel = 'Подпись';
  static const String descriptionLabel = 'Описание';
  static const String saveButton = 'Сохранить';
  static const String addButton = 'Добавить';

  static const String categoryPlanet = 'Планета';
  static const String categoryMission = 'Миссия';
  static const String categoryTelescope = 'Телескоп';

  static const String authInvalidEmail = 'Некорректный email';
  static const String authUserDisabled = 'Аккаунт заблокирован';
  static const String authInvalidCredential = 'Неверный email или пароль';
  static const String authEmailInUse = 'Этот email уже зарегистрирован';
  static const String authWeakPassword =
      'Слишком короткий пароль — минимум 6 символов';
  static const String authTooManyRequests =
      'Слишком много попыток, попробуйте позже';
  static const String authNetworkFailed = 'Нет соединения с интернетом';
  static const String authSignInFailed = 'Не удалось войти';

  static String withCode(String message, String code) =>
      '$message (код: $code)';

  static const String catalogNoConnection = 'Нет соединения с сервером';
  static const String catalogPermissionDenied = 'Нет доступа к каталогу';
  static const String catalogNotFound = 'Объект уже удалён';

  static String catalogServerError(String code) => 'Ошибка сервера: $code';
}
