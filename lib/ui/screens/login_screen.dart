import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_cubit.dart';
import '../../bloc/login/login_state.dart';
import '../../core/app_strings.dart';

/// Экран входа и регистрации.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<LoginCubit>().submit(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _LoginView(
      emailController: _emailController,
      passwordController: _passwordController,
      obscure: _obscure,
      onToggleObscure: () => setState(() => _obscure = !_obscure),
      onSubmit: _submit,
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({
    required this.emailController,
    required this.passwordController,
    required this.obscure,
    required this.onToggleObscure,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE6E4DF)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.appTitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.isRegister
                              ? AppStrings.loginRegistration
                              : AppStrings.loginSignInTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: AppStrings.email,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => cubit.clearError(),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: passwordController,
                          obscureText: obscure,
                          autofillHints: [
                            state.isRegister
                                ? AutofillHints.newPassword
                                : AutofillHints.password,
                          ],
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            helperText: state.isRegister
                                ? AppStrings.passwordHelper
                                : null,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: onToggleObscure,
                            ),
                          ),
                          onChanged: (_) => cubit.clearError(),
                          onSubmitted: (_) => onSubmit(),
                        ),
                        if (state.error != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.error!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: state.isLoading ? null : onSubmit,
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  state.isRegister
                                      ? AppStrings.register
                                      : AppStrings.signIn,
                                ),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: state.isLoading ? null : cubit.toggleMode,
                          child: Text(
                            state.isRegister
                                ? AppStrings.haveAccount
                                : AppStrings.noAccount,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
