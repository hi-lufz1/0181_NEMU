import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/repository/laporan/statistik_repository.dart';
import 'package:nemu_app/presentation/bloc/laporan/stat/statistik_bloc.dart';

class AdminStatistikScreen extends StatelessWidget {
  const AdminStatistikScreen({super.key});

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
                    _SectionTitle(title: "📊 Rekap Laporan"),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatCard(
                          label: 'Aktif',
                          count: data.totalAktif,
                          color: AppColors.primary,
                          icon: Icons.visibility,
                        ),
                        _StatCard(
                          label: 'Diklaim',
                          count: data.totalDiklaim,
                          color: AppColors.secondary,
                          icon: Icons.verified,
                        ),
                        _StatCard(
                          label: 'Dihapus',
                          count: data.totalDihapusAdmin,
                          color: Colors.redAccent,
                          icon: Icons.delete_forever,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _SectionTitle(title: "✅ Klaim Berhasil"),
                    const SizedBox(height: 12),
                    _StatCard(
                      label: 'Klaim Berhasil',
                      count: data.klaimBerhasil,
                      color: Colors.green,
                      icon: Icons.check_circle,
                      fullWidth: true,
                    ),

                    const SizedBox(height: 24),
                    _SectionTitle(title: "🏷️ Top Kategori"),
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

class _StatCard extends StatelessWidget {
  final String label;
  final int? count;
  final Color color;
  final IconData icon;
  final bool fullWidth;

  const _StatCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 100,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
