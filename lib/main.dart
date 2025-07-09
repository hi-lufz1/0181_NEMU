import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/login_screen.dart';
import 'package:nemu_app/presentation/screens/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: AuthRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'NEMU App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
        routes: {
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
