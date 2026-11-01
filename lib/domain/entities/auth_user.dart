import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Авторизованный пользователь.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({required String uid, String? email}) = _AuthUser;
}
