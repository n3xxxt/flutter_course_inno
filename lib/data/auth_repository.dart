import 'package:firebase_auth/firebase_auth.dart';

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
      'invalid-email' => 'Некорректный email',
      'user-disabled' => 'Аккаунт заблокирован',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'Неверный email или пароль',
      'email-already-in-use' => 'Этот email уже зарегистрирован',
      'weak-password' => 'Слишком короткий пароль — минимум 6 символов',
      'too-many-requests' => 'Слишком много попыток, попробуйте позже',
      'network-request-failed' => 'Нет соединения с интернетом',
      _ => 'Не удалось войти: $code',
    };
  }
}
