import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart'; // Tambahkan ini
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/maps/bloc/map_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/login_screen.dart';
import 'package:nemu_app/presentation/screens/auth/register_screen.dart';
import 'package:nemu_app/presentation/screens/shared/createlaporan/create_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/feed/feed_screen.dart';
import 'package:nemu_app/presentation/screens/shared/maps/map_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LaporanRepository>(
      create: (context) => LaporanRepository(), // buat instance-nya
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository: AuthRepository()),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(authRepository: AuthRepository()),
          ),
          BlocProvider(
            create:
                (context) => LaporanUserBloc(
                  laporanRepository: context.read<LaporanRepository>(),
                ),
          ),
          BlocProvider<FotoLaporanBloc>(create: (context) => FotoLaporanBloc()),
          BlocProvider<AddLaporanBloc>(
            create:
                (context) => AddLaporanBloc(
                  laporanRepository: context.read<LaporanRepository>(),
                ),
          ),
        ],
        child: MaterialApp(
          title: 'NEMU App',
          debugShowCheckedModeBanner: false,
          home: const CreateLaporanScreen(),
          routes: {
            '/register': (context) => const RegisterScreen(),
            '/create-laporan': (context) => const CreateLaporanScreen(),
            '/feed': (context) => const FeedScreen(),
            '/map-picker':
                (context) => BlocProvider(
                  create: (_) => MapBloc(),
                  child: const MapScreen(),
                ),
          },
        ),
      ),
    );
  }
}
