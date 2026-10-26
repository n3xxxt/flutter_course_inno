/// Состояние формы входа и регистрации.
class LoginState {
  const LoginState({
    this.registering = false,
    this.isLoading = false,
    this.error,
    this.obscurePassword = true,
  });

  final bool registering;
  final bool isLoading;
  final String? error;
  final bool obscurePassword;

  LoginState copyWith({
    bool? registering,
    bool? isLoading,
    String? error,
    bool? obscurePassword,
    bool clearError = false,
  }) {
    return LoginState(
      registering: registering ?? this.registering,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
