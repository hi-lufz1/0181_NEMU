import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_bottom_navbar.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/main.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanadmin/laporan_admin_bloc.dart';
import 'package:nemu_app/core/components/feed_post_card.dart';
import 'package:nemu_app/presentation/screens/admin/feedadmin/components/admin_bottom_navbar.dart';
import 'package:nemu_app/presentation/screens/admin/feedadmin/components/admin_feed_header.dart'; // Tetap pakai card yang sama
// Jika berbeda dengan user, bisa buat ulang

class AdminFeedScreen extends StatefulWidget {
  const AdminFeedScreen({super.key});

  @override
  State<AdminFeedScreen> createState() => _AdminFeedScreenState();
}

class _AdminFeedScreenState extends State<AdminFeedScreen> with RouteAware {
  int currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<LaporanAdminBloc>().add(LaporanAdminRequested());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void didPopNext() {
    context.read<LaporanAdminBloc>().add(LaporanAdminRequested());
  }

  void _onNavTapped(int index) {
    setState(() => currentNavIndex = index);

    if (index == 0) {
      // Tetap di halaman ini (AdminFeedScreen)
    } else if (index == 1) {
      Navigator.pushNamed(context, '/search');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/admin-statistik');
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentNavIndex = 0;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 2,
                      colors: [
                        Color.fromARGB(255, 163, 242, 234),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AdminFeedHeader(), // Ganti jika ingin header admin
                        const SizedBox(height: 8),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Semua Laporan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Komponen daftar laporan (khusus admin)
                        BlocBuilder<LaporanAdminBloc, LaporanAdminState>(
                          builder: (context, state) {
                            if (state is LaporanAdminLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state is LaporanAdminFailure) {
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  state.resModel.message ??
                                      'Gagal memuat laporan',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            if (state is LaporanAdminSuccess) {
                              final List<Datum> laporanList =
                                  state.resModel.data ?? [];

                              if (laporanList.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Text("Belum ada laporan."),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children:
                                      laporanList
                                          .map(
                                            (laporan) =>
                                                FeedPostCard(laporan: laporan),
                                          )
                                          .toList(),
                                ),
                              );
                            }

                            return const SizedBox();
                          },
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AdminBottomNavbar(currentIndex: currentNavIndex, onTap: _onNavTapped),
        ],
      ),
    );
  }
}
