import 'package:firebase_auth/firebase_auth.dart';

import '../domain/entities/auth_user.dart';
import '../core/app_strings.dart';
import 'mappers/auth_user_mapper.dart';

/// Ошибка аутентификации с текстом для пользователя.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Репозиторий аутентификации на Firebase Auth.
class AuthRepository {
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<AuthUser?> get userChanges => _auth.authStateChanges().map(_toUser);

  AuthUser? get currentUser => _toUser(_auth.currentUser);

  Future<void> signIn({required String email, required String password}) {
    return _guard(
      () => _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  Future<void> signUp({required String email, required String password}) {
    return _guard(
      () => _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  Future<void> signOut() => _guard(_auth.signOut);

  AuthUser? _toUser(User? user) {
    return user?.toEntity();
  }

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_message(e.code));
    }
  }

  String _message(String code) {
    return switch (code) {
      'invalid-email' => AppStrings.authInvalidEmail,
      'user-disabled' => AppStrings.authUserDisabled,
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => AppStrings.authInvalidCredentials,
      'email-already-in-use' => AppStrings.authEmailInUse,
      'weak-password' => AppStrings.authWeakPassword,
      'too-many-requests' => AppStrings.authTooManyRequests,
      'network-request-failed' => AppStrings.authNoConnection,
      _ => AppStrings.authFailed(code),
    };
  }
}
