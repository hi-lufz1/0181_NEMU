import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_bottom_navbar.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/presentation/screens/shared/feed/components/feed_post_card.dart';
import 'package:nemu_app/presentation/screens/shared/feed/components/feed_toggle_tab.dart';
import 'components/feed_header.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int selectedIndex = 0; // Untuk tab "Semua" atau "Laporan Saya"
  int currentNavIndex = 0; // Untuk bottom navbar

  @override
  void initState() {
    super.initState();
    context.read<LaporanUserBloc>().add(GetAllAktifLaporan());
  }

  void _onTabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      context.read<LaporanUserBloc>().add(GetAllAktifLaporan());
    } else {
      context.read<LaporanUserBloc>().add(GetLaporanSaya());
    }
  }

  void _onNavTapped(int index) {
    setState(() => currentNavIndex = index);

    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
      context.read<FotoLaporanBloc>().add(TakeFromCamera(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // biar navbar melayang
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
                      radius: 1.5,
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
                        const FeedHeader(),
                        const SizedBox(height: 8),

                        // Tab Toggle
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              FeedToggleTab(
                                title: "Semua",
                                isSelected: selectedIndex == 0,
                                onTap: () => _onTabChanged(0),
                              ),
                              const SizedBox(width: 16),
                              FeedToggleTab(
                                title: "Laporan Saya",
                                isSelected: selectedIndex == 1,
                                onTap: () => _onTabChanged(1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Recently Post",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Feed List
                        BlocBuilder<LaporanUserBloc, LaporanUserState>(
                          builder: (context, state) {
                            if (state is LaporanUserLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state is LaporanUserFailure) {
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  state.resModel.message ??
                                      'Gagal memuat laporan',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            if (state is LaporanUserSuccess) {
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

                        const SizedBox(
                          height: 100,
                        ), // Beri ruang agar tidak ketimpa navbar
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating Bottom Navbar
          CustomBottomNavbar(
            currentIndex: currentNavIndex,
            onTap: _onNavTapped,
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        onPressed: () {
          // TODO: Navigasi ke tambah laporan
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
