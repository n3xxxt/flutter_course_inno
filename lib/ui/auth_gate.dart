import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import '../data/catalog_repository.dart';
import '../bloc/auth/auth_cubit.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/catalog/catalog_cubit.dart';
import '../bloc/login/login_cubit.dart';
import 'screens/catalog_screen.dart';
import 'screens/login_screen.dart';

/// Выбирает экран по состоянию авторизации.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) => current is AuthUnauthenticated,
      listener: (context, state) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      builder: (context, state) {
        return switch (state) {
          AuthUnknown() => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          AuthUnauthenticated() => BlocProvider(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
            child: const LoginScreen(),
          ),
          AuthAuthenticated(:final user) => BlocProvider(
            key: ValueKey(user.uid),
            create: (context) =>
                CatalogCubit(context.read<CatalogRepository>(), uid: user.uid)
                  ..load(),
            child: const CatalogScreen(),
          ),
        };
      },
    );
  }
}
