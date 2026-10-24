import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'login_state.dart';

/// Логика формы входа и регистрации по email и паролю.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(const LoginState());

  final AuthRepository _repository;

  void toggleMode() {
    emit(state.copyWith(isRegister: !state.isRegister, clearError: true));
  }

  void clearError() {
    if (state.error != null) emit(state.copyWith(clearError: true));
  }

  Future<void> submit({required String email, required String password}) async {
    if (state.isLoading) return;
    if (email.trim().isEmpty) {
      emit(state.copyWith(error: 'Введите email'));
      return;
    }
    if (password.isEmpty) {
      emit(state.copyWith(error: 'Введите пароль'));
      return;
    }
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      if (state.isRegister) {
        await _repository.signUp(email: email, password: password);
      } else {
        await _repository.signIn(email: email, password: password);
      }
    } on AuthException catch (e) {
      if (!isClosed) emit(state.copyWith(error: e.message));
    } finally {
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }
}
