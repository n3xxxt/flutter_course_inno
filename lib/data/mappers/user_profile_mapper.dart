import '../dto/user_profile_dto.dart';

/// Преобразует DTO профиля в множество избранного.
extension UserProfileDtoMapper on UserProfileDto {
  Set<String> toFavorites() => favorites.toSet();
}
