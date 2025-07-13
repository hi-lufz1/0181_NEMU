import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nemu_app/core/routes/role_director.dart';
import 'package:nemu_app/data/datasource/draf_dao.dart';
import 'package:nemu_app/data/repository/auth/auth_repository.dart';
import 'package:nemu_app/data/repository/draf/laporan_draf_repository.dart';
import 'package:nemu_app/data/repository/klaim/klaim_repository.dart';
import 'package:nemu_app/data/repository/laporan/laporan_admin_repository.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';
import 'package:nemu_app/data/repository/notif/notif_repository.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/bloc/klaim/bloc/klaim_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteadmin/delete_admin_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteuser/delete_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/laporan/detail/detail_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanadmin/laporan_admin_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/update/update_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/maps/bloc/map_bloc.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/draf/draf_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/presentation/bloc/notif/bloc/notif_bloc.dart';
import 'package:nemu_app/presentation/screens/admin/feedadmin/admin_feed_screen.dart';
import 'package:nemu_app/presentation/screens/admin/statistik/admin_statistik_screen.dart';
import 'package:nemu_app/presentation/screens/auth/login_screen.dart';
import 'package:nemu_app/presentation/screens/auth/register_screen.dart';
import 'package:nemu_app/presentation/screens/shared/createlaporan/create_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/detail_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/draf/draf_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/editlaporan/edit_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/shared/feed/feed_screen.dart';
import 'package:nemu_app/presentation/screens/shared/maps/map_screen.dart';
import 'package:nemu_app/presentation/screens/shared/search/search_laporan_screen.dart';
import 'package:nemu_app/presentation/screens/umum/notif/notif_screen.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyAppWrapper());
}

// WRAPPER UNTUK RESET APP SAAT LOGOUT
class MyAppWrapper extends StatefulWidget {
  const MyAppWrapper({super.key});

  @override
  State<MyAppWrapper> createState() => _MyAppWrapperState();

  static void restartApp(BuildContext context) {
    final _MyAppWrapperState? state =
        context.findAncestorStateOfType<_MyAppWrapperState>();
    state?.restartApp();
  }
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: const MyApp());
  }
}

// APP UTAMA
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LaporanRepository>(
      create: (context) => LaporanRepository(),
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => LoginBloc(authRepository: AuthRepository()),
              ),
              BlocProvider(
                create: (_) => RegisterBloc(authRepository: AuthRepository()),
              ),
              BlocProvider(
                create:
                    (_) => LaporanUserBloc(
                      laporanRepository: context.read<LaporanRepository>(),
                    ),
              ),
              BlocProvider(
                create:
                    (_) => AddLaporanBloc(
                      laporanRepository: context.read<LaporanRepository>(),
                    ),
              ),
              BlocProvider(
                create:
                    (_) => DetailLaporanBloc(
                      laporanRepository: context.read<LaporanRepository>(),
                    ),
              ),
              BlocProvider(
                create:
                    (_) => DeleteLaporanBloc(
                      laporanRepository: context.read<LaporanRepository>(),
                    ),
              ),
              BlocProvider(
                create:
                    (_) => UpdateLaporanBloc(
                      laporanRepository: context.read<LaporanRepository>(),
                    ),
              ),
              BlocProvider(create: (_) => FotoLaporanBloc()),
              BlocProvider(create: (_) => MapBloc()),
              BlocProvider(
                create:
                    (_) => DrafBloc(
                      repository: LaporanDrafRepository(dao: DrafDao()),
                    ),
              ),
              BlocProvider(create: (_) => FormLaporanCubit()),
              BlocProvider(
                create: (_) => KlaimBloc(klaimRepository: KlaimRepository()),
              ),
              BlocProvider(
                create: (_) => NotifBloc(notifRepository: NotifRepository()),
              ),
              BlocProvider(
                create:
                    (_) =>
                        LaporanAdminBloc(repository: LaporanAdminRepository()),
              ),
              BlocProvider(
                create:
                    (_) =>
                        DeleteAdminBloc(repository: LaporanAdminRepository()),
              ),
            ],
            child: MaterialApp(
              title: 'NEMU App',
              debugShowCheckedModeBanner: false,
              navigatorObservers: [routeObserver],
              home: const RoleRedirector(),
              routes: {
                '/redirect': (context) => const RoleRedirector(),
                '/login': (context) => const LoginScreen(),
                '/register': (context) => const RegisterScreen(),
                '/create-laporan': (context) => CreateLaporanScreen(),
                '/feed': (context) => const FeedScreen(),
                '/map-picker': (context) => const MapScreen(),
                '/draft': (context) => const DraftLaporanScreen(),
                '/detail-laporan': (context) {
                  final id =
                      ModalRoute.of(context)!.settings.arguments as String;
                  return DetailLaporanScreen(laporanId: id);
                },
                '/edit-laporan': (context) {
                  final laporan =
                      ModalRoute.of(context)!.settings.arguments as Data;
                  return EditLaporanScreen(laporan: laporan);
                },
                '/notifikasi': (context) => const NotifScreen(),
                '/search': (_) => const SearchLaporanScreen(),
                '/admin-feed': (_) => const AdminFeedScreen(),
                '/admin-statistik': (_) => const AdminStatistikScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
