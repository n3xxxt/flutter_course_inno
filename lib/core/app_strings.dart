/// Пользовательские строки приложения.
abstract final class AppStrings {
  static const String appTitle = 'Каталог космоса';

  static const String categoryPlanet = 'Планета';
  static const String categoryMission = 'Миссия';
  static const String categoryTelescope = 'Телескоп';

  static const String authInvalidEmail = 'Некорректный email';
  static const String authUserDisabled = 'Аккаунт заблокирован';
  static const String authInvalidCredentials = 'Неверный email или пароль';
  static const String authEmailInUse = 'Этот email уже зарегистрирован';
  static const String authWeakPassword =
      'Слишком короткий пароль — минимум 6 символов';
  static const String authTooManyRequests =
      'Слишком много попыток, попробуйте позже';
  static const String authNoConnection = 'Нет соединения с интернетом';
  static String authFailed(String code) => 'Не удалось войти: $code';

  static const String catalogNoConnection = 'Нет соединения с сервером';
  static const String catalogNoAccess = 'Нет доступа к каталогу';
  static const String catalogItemGone = 'Объект уже удалён';
  static String catalogServerError(String code) => 'Ошибка сервера: $code';

  static const String loginEnterEmail = 'Введите email';
  static const String loginEnterPassword = 'Введите пароль';
  static const String loginRegistration = 'Регистрация';
  static const String loginSignInTitle = 'Вход';
  static const String email = 'Email';
  static const String password = 'Пароль';
  static const String passwordHelper = 'Минимум 6 символов';
  static const String register = 'Зарегистрироваться';
  static const String signIn = 'Войти';
  static const String haveAccount = 'Уже есть аккаунт? Войти';
  static const String noAccount = 'Нет аккаунта? Зарегистрироваться';

  static const String itemDeleted = 'Объект удалён';
  static const String changesSaved = 'Изменения сохранены';
  static const String deleteItemTitle = 'Удалить объект?';
  static String deleteItemMessage(String title) =>
      '“$title” будет удалён из каталога для всех пользователей.';
  static const String cancel = 'Отмена';
  static const String delete = 'Удалить';
  static const String itemNotFound = 'Объект не найден';
  static const String edit = 'Изменить';
  static const String description = 'Описание';
  static const String noDescription = 'Описание пока не добавлено';
  static String addedOn(String date) => 'Добавлено: $date';

  static const String itemAdded = 'Объект добавлен';
  static String itemsInCatalog(int count) => '$count объектов в каталоге';
  static const String addItem = 'Добавить объект';
  static const String signOut = 'Выйти';
  static const String searchHint = 'Поиск по названию';
  static const String clear = 'Очистить';
  static String favoritesCount(int count) => 'В избранном: $count';
  static const String onlyFavorites = 'Только избранные';
  static String nothingFound(String query) =>
      'Ничего не найдено по запросу «$query»';
  static const String favoritesEmpty = 'В избранном пока пусто';
  static const String catalogEmpty = 'Каталог пуст — добавьте первый объект';
  static const String loadFailed = 'Не удалось загрузить каталог';
  static const String refresh = 'Обновить';

  static const String formEditing = 'Редактирование';
  static const String formNewItem = 'Новый объект';
  static const String formTitleLabel = 'Название *';
  static const String formTitleError = 'Введите название';
  static const String formSubtitleLabel = 'Подпись';
  static const String save = 'Сохранить';
  static const String add = 'Добавить';
}
