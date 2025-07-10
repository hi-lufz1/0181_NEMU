import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';

class FeedPostCard extends StatelessWidget {
  final Datum laporan;

  const FeedPostCard({super.key, required this.laporan});

  @override
  Widget build(BuildContext context) {
    final tanggal =
        laporan.dibuatPada != null
            ? DateFormat('dd MMMM yyyy', 'id_ID').format(laporan.dibuatPada!)
            : '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Nama & Tanggal
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/logo.png',
                ), // Placeholder
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laporan.nama ?? '-', // <- akan ditambahkan dari backend
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tanggal,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tipe + Nama Barang
          Text(
            "[${laporan.tipe?.toUpperCase() ?? '-'}] ${laporan.namaBarang ?? '-'}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 6),

          // Lokasi
          if (laporan.lokasiText != null && laporan.lokasiText!.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    laporan.lokasiText!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 8),

          // Deskripsi
          Text(laporan.deskripsi ?? '-', style: const TextStyle(fontSize: 14)),

          const SizedBox(height: 12),

          // Foto (jika ada)
          if (laporan.foto != null && laporan.foto!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                laporan.foto!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Gagal memuat gambar.',
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
