import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'auth_state.dart';

/// Следит за текущим пользователем и выходом из аккаунта.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthUnknown()) {
    _subscription = _repository.userChanges.listen((user) {
      emit(
        user == null ? const AuthUnauthenticated() : AuthAuthenticated(user),
      );
    });
  }

  final AuthRepository _repository;
  late final StreamSubscription _subscription;

  Future<void> signOut() => _repository.signOut();

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
