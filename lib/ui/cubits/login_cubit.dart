import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_strings.dart';
import '../../data/auth_repository.dart';
import 'login_state.dart';

/// Логика формы входа и регистрации по email и паролю.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(const LoginState());

  final AuthRepository _repository;

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void clearError() {
    if (state.error != null) emit(state.copyWith(clearError: true));
  }

  Future<void> signIn({required String email, required String password}) {
    return _authenticate(email: email, password: password, register: false);
  }

  Future<void> register({required String email, required String password}) {
    return _authenticate(email: email, password: password, register: true);
  }

  Future<void> _authenticate({
    required String email,
    required String password,
    required bool register,
  }) async {
    if (state.isLoading) return;
    if (email.trim().isEmpty) {
      emit(state.copyWith(error: AppStrings.enterEmail));
      return;
    }
    if (password.isEmpty) {
      emit(state.copyWith(error: AppStrings.enterPassword));
      return;
    }
    emit(
      state.copyWith(isLoading: true, registering: register, clearError: true),
    );
    try {
      if (register) {
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
