import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';

class FeedPostCard extends StatelessWidget {
  final Datum laporan;

  const FeedPostCard({super.key, required this.laporan});

  Uint8List? getDecodedFoto(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tanggal =
        laporan.dibuatPada != null
            ? DateFormat(
              'dd MMMM yyyy HH:mm',
              'id_ID',
            ).format(laporan.dibuatPada!)
            : '-';

    final Uint8List? decodedFoto = getDecodedFoto(laporan.foto);

    return GestureDetector(
      onTap: () {
        if (laporan.id != null) {
          Navigator.pushNamed(
            context,
            '/detail-laporan',
            arguments: laporan.id,
          );
        }
      },
      child: Container(
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
                  backgroundImage: AssetImage('assets/images/splash.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      laporan.nama ?? '-',
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
            Text(
              laporan.deskripsi ?? '-',
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 12),

            // Foto (jika ada)
            if (decodedFoto != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  decodedFoto,
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else if (laporan.foto != null && laporan.foto!.isNotEmpty)
              const Text(
                'Gagal memuat gambar.',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
