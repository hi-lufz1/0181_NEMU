import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart'; // Tambahkan ini
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/login_screen.dart';
import 'package:nemu_app/presentation/screens/auth/register_screen.dart';
import 'package:nemu_app/presentation/screens/shared/feed/feed_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

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
        BlocProvider(
          create: (context) => LaporanUserBloc(
            laporanRepository: LaporanRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'NEMU App',
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        routes: {
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
