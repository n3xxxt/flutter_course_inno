import 'package:firebase_auth/firebase_auth.dart';

import '../core/app_strings.dart';
import '../domain/entities/auth_user.dart';

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
    if (user == null) return null;
    return AuthUser(uid: user.uid, email: user.email);
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
      'invalid-email' => AppStrings.withCode(AppStrings.authInvalidEmail, code),
      'user-disabled' => AppStrings.withCode(AppStrings.authUserDisabled, code),
      'user-not-found' || 'wrong-password' || 'invalid-credential' =>
        AppStrings.withCode(AppStrings.authInvalidCredential, code),
      'email-already-in-use' => AppStrings.withCode(
        AppStrings.authEmailInUse,
        code,
      ),
      'weak-password' => AppStrings.withCode(AppStrings.authWeakPassword, code),
      'too-many-requests' => AppStrings.withCode(
        AppStrings.authTooManyRequests,
        code,
      ),
      'network-request-failed' => AppStrings.withCode(
        AppStrings.authNetworkFailed,
        code,
      ),
      _ => AppStrings.withCode(AppStrings.authSignInFailed, code),
    };
  }
}
