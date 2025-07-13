import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/feed_post_card.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanadmin/laporan_admin_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';

class LaporanListView extends StatelessWidget {
  final dynamic state;

  const LaporanListView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is LaporanUserLoading || state is LaporanAdminLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is LaporanUserFailure || state is LaporanAdminFailure) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          state.resModel.message ?? "Gagal memuat laporan.",
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state is LaporanUserSuccess || state is LaporanAdminSuccess) {
      final List<Datum> laporanList = state.resModel.data ?? [];

      if (laporanList.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Text("Tidak ada hasil ditemukan."),
        );
      }

      return Column(
        children:
            laporanList.map((laporan) => FeedPostCard(laporan: laporan)).toList(),
      );
    }

    return const SizedBox();
  }
}
