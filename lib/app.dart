import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/auth_repository.dart';
import 'data/catalog_repository.dart';
import 'ui/auth_gate.dart';
import 'bloc/auth/auth_cubit.dart';
import 'core/app_strings.dart';

/// Корневой виджет приложения.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => CatalogRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2F5D50),
            ),
            scaffoldBackgroundColor: const Color(0xFFF3F1EC),
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}
