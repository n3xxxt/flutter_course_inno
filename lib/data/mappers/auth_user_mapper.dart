import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user.dart';

/// Преобразует пользователя Firebase в энтити.
extension FirebaseUserMapper on User {
  AuthUser toEntity() => AuthUser(uid: uid, email: email);
}
