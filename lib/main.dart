import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart'; // Tambahkan ini
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/datasource/draf_dao.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';
import 'package:nemu_app/data/repository/draf/laporan_draf_repository.dart';
import 'package:nemu_app/data/repository/klaim/klaim_repository.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';
import 'package:nemu_app/data/repository/notif/notif_repository.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/bloc/klaim/bloc/klaim_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteuser/delete_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/laporan/detail/detail_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/update/update_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/maps/bloc/map_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/draf/draf_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/presentation/bloc/notif/bloc/notif_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/login_screen.dart';
import 'package:nemu_app/presentation/screens/auth/register_screen.dart';
import 'package:nemu_app/presentation/screens/shared/createlaporan/create_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/detail_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/draf/draf_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/editlaporan/edit_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/feed/feed_screen.dart';
import 'package:nemu_app/presentation/screens/shared/maps/map_screen.dart';
import 'package:nemu_app/presentation/screens/umum/notif/notif_screen.dart';

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
          BlocProvider<MapBloc>(create: (context) => MapBloc()),
          BlocProvider(
            create:
                (_) =>
                    DrafBloc(repository: LaporanDrafRepository(dao: DrafDao())),
          ),
          BlocProvider<FormLaporanCubit>(create: (_) => FormLaporanCubit()),
          BlocProvider<DetailLaporanBloc>(
            create:
                (context) => DetailLaporanBloc(
                  laporanRepository: context.read<LaporanRepository>(),
                ),
          ),
          BlocProvider<DeleteLaporanBloc>(
            create:
                (context) => DeleteLaporanBloc(
                  laporanRepository: context.read<LaporanRepository>(),
                ),
          ),
          BlocProvider<UpdateLaporanBloc>(
            create:
                (context) => UpdateLaporanBloc(
                  laporanRepository: context.read<LaporanRepository>(),
                ),
          ),
          BlocProvider(
            create: (_) => KlaimBloc(klaimRepository: KlaimRepository()),
          ),
          BlocProvider(
            create: (_) => NotifBloc(notifRepository: NotifRepository()),
          ),
        ],
        child: MaterialApp(
          title: 'NEMU App',
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          routes: {
            '/register': (context) => const RegisterScreen(),
            '/create-laporan': (context) => CreateLaporanScreen(),
            '/feed': (context) => const FeedScreen(),
            '/map-picker': (context) => const MapScreen(),
            '/draft': (context) => const DraftLaporanScreen(),
            '/detail-laporan': (context) {
              final id = ModalRoute.of(context)!.settings.arguments as String;
              return DetailLaporanScreen(laporanId: id);
            },
            '/edit-laporan': (context) {
              final laporan =
                  ModalRoute.of(context)!.settings.arguments as Data;
              return EditLaporanScreen(laporan: laporan);
            },
            '/notifikasi': (context) => const NotifScreen(),
          },
        ),
      ),
    );
  }
}
