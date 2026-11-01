/// Состояние формы входа и регистрации.
class LoginState {
  const LoginState({
    this.isRegister = false,
    this.isLoading = false,
    this.error,
  });

  final bool isRegister;
  final bool isLoading;
  final String? error;

  LoginState copyWith({
    bool? isRegister,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return LoginState(
      isRegister: isRegister ?? this.isRegister,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
