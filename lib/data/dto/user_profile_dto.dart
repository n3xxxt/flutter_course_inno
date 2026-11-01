import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// Документ профиля пользователя в Firestore.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({@Default(<String>[]) List<String> favorites}) =
      _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}
