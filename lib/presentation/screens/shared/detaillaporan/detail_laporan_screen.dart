// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/core/components/image_popup_viewer.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteuser/delete_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/detail/detail_laporan_bloc.dart';

class DetailLaporanScreen extends StatelessWidget {
  final String laporanId;

  const DetailLaporanScreen({super.key, required this.laporanId});

  Uint8List? decodeBase64Image(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return "-";
    return DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(dateTime);
  }

  void showKlaimDialog(BuildContext context, Data data) {
    final TextEditingController jawabanController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Verifikasi Klaim"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.pertanyaanVerifikasi ?? 'Tidak ada pertanyaan'),
              const SizedBox(height: 12),
              TextField(
                controller: jawabanController,
                decoration: const InputDecoration(
                  labelText: 'Jawaban Anda',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                final jawaban = jawabanController.text.trim();
                if (jawaban.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Jawaban tidak boleh kosong")),
                  );
                  return;
                }

                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/klaim',
                  arguments: {"laporanId": data.id, "jawaban": jawaban},
                );
              },
              child: const Text("Klaim Sekarang"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DetailLaporanBloc(laporanRepository: context.read())
                ..add(DetailLaporanRequested(id: laporanId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Detail Laporan",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<DetailLaporanBloc, DetailLaporanState>(
          builder: (context, state) {
            if (state is DetailLaporanLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailLaporanFailure) {
              return Center(
                child: Text(state.resModel.message ?? 'Gagal memuat data'),
              );
            } else if (state is DetailLaporanSuccess) {
              final data = state.resModel.data!;
              final decodedImage = decodeBase64Image(data.foto);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (decodedImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => ImagePopupViewer(
                                    imageBytes: decodedImage,
                                  ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              decodedImage,
                              width: double.infinity,
                              height: 260,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 260,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.namaBarang ?? '-',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Chip(
                                label: Text(data.tipe?.toUpperCase() ?? '-'),
                                backgroundColor:
                                    data.tipe == 'hilang'
                                        ? Colors.black
                                        : AppColors.primary,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(data.kategori ?? '-'),
                                backgroundColor: Colors.grey[200],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Text(
                            "Deskripsi:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data.deskripsi ?? '-',
                            style: TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            "Status:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (data.status == 'Terverifikasi')
                                      ? Colors.green[100]
                                      : (data.status == 'Menunggu Verifikasi')
                                      ? Colors.orange[100]
                                      : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              data.status ?? '-',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    (data.status == 'Terverifikasi')
                                        ? Colors.green[800]
                                        : (data.status == 'Menunggu Verifikasi')
                                        ? Colors.orange[800]
                                        : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            "Nama Pelapor:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                data.nama ?? '-',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Text(
                            "Dibuat pada:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            formatDate(data.dibuatPada),
                            style: TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 12),
                          Text(
                            "Lokasi:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data.lokasiText ?? '-',
                            style: TextStyle(fontSize: 14),
                          ),

                          if (data.catatanAdmin != null &&
                              data.catatanAdmin!.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Text(
                              "Catatan Admin:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              data.catatanAdmin!,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    if (data.latitude != null && data.longitude != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 180,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(data.latitude!, data.longitude!),
                                zoom: 14,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("lokasi"),
                                  position: LatLng(
                                    data.latitude!,
                                    data.longitude!,
                                  ),
                                ),
                              },
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              liteModeEnabled: true,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    if (state.isLaporanSaya)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/edit-laporan',
                                    arguments: data,
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Edit"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                          title: const Text("Hapus Laporan"),
                                          content: const Text(
                                            "Yakin ingin menghapus laporan ini?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text("Batal"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<DeleteLaporanBloc>()
                                                    .add(
                                                      DeleteLaporanSubmitted(
                                                        id: data.id!,
                                                      ),
                                                    );
                                              },
                                              child: const Text("Hapus"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Hapus"),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (data.tipe == 'ditemukan')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () => showKlaimDialog(context, data),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Klaim Barang Ini",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                    const SizedBox(height: 32),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
