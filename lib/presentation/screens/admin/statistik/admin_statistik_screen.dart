import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/core/utils/pdf_export_helper.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_admin_repository.dart';
import 'package:nemu_app/data/repository/laporan/statistik_repository.dart';
import 'package:nemu_app/presentation/bloc/laporan/stat/statistik_bloc.dart';
import 'package:nemu_app/presentation/screens/admin/statistik/components/stat_card.dart';

class AdminStatistikScreen extends StatelessWidget {
  const AdminStatistikScreen({super.key});

  Future<List<Datum>> _fetchAllLaporanForExport() async {
    final res = await LaporanAdminRepository().getAllAdmin();
    return res.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              StatistikBloc(repository: StatistikRepository())
                ..add(StatistikRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F9F8),
        appBar: AppBar(
          title: const Text('Statistik Admin'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        body: BlocBuilder<StatistikBloc, StatistikState>(
          builder: (context, state) {
            if (state is StatistikLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StatistikFailure) {
              return Center(
                child: Text(state.resModel.message ?? 'Gagal memuat data'),
              );
            } else if (state is StatistikSuccess) {
              final data = state.resModel.data;
              if (data == null) return const Center(child: Text('Data kosong'));

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: "\uD83D\uDCCA Rekap Laporan"),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatCard(
                          label: 'Aktif',
                          count: data.totalAktif,
                          color: AppColors.primary,
                          icon: Icons.visibility,
                        ),
                        StatCard(
                          label: 'Diklaim',
                          count: data.totalDiklaim,
                          color: AppColors.secondary,
                          icon: Icons.verified,
                        ),
                        StatCard(
                          label: 'Dihapus',
                          count: data.totalDihapusAdmin,
                          color: Colors.redAccent,
                          icon: Icons.delete_forever,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SectionTitle(title: "\u2705 Klaim Berhasil"),
                    const SizedBox(height: 12),
                    StatCard(
                      label: 'Klaim Berhasil',
                      count: data.klaimBerhasil,
                      color: Colors.green,
                      icon: Icons.check_circle,
                      fullWidth: true,
                    ),
                    const SizedBox(height: 24),
                    SectionTitle(title: "\uD83C\uDF7F️ Top Kategori"),
                    const SizedBox(height: 12),
                    ...data.topKategori!.map(
                      (kat) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                            color: AppColors.primary,
                          ),
                          title: Text(kat.kategori ?? "-"),
                          trailing: Text('${kat.jumlah ?? 0} laporan'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: CustomButton(
                        label: "Export Semua Laporan",
                        onPressed: () async {
                          final laporanList = await _fetchAllLaporanForExport();
                          await PDFExportHelper.exportAllLaporan(
                            laporanList,
                          ); // ← sekarang ini tidak error
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }
            return const Center(child: Text("Tidak ada data"));
          },
        ),
      ),
    );
  }
}
