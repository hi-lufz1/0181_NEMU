import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_outline_button.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteuser/delete_laporan_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLaporanAct extends StatelessWidget {
  final Data data;
  final bool isLaporanSaya;

  const DetailLaporanAct({
    super.key,
    required this.data,
    required this.isLaporanSaya,
  });

  void _showKlaimDialog(BuildContext context) {
    final jawabanController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Verifikasi Klaim"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data.pertanyaanVerifikasi ?? "-"),
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
              CustomButton(
                label: "Klaim Sekarang",
                onPressed: () {
                  final jawaban = jawabanController.text.trim();
                  if (jawaban.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Jawaban tidak boleh kosong"),
                      ),
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
              ),
            ],
          ),
    );
  }

  void _hubungiPenemu(BuildContext context) async {
    final url = data.kontak?.replaceAll(' ', '').replaceAll('+', '62');
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kontak penemu tidak tersedia")),
      );
      return;
    }

    final Uri whatsappUri = Uri.parse("https://wa.me/$url");

    final success = await launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
    );

    if (!success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal membuka WhatsApp")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (isLaporanSaya) ...[
            Row(
              children: [
                Expanded(
                  child: CustomOutlineButton(
                    label: "Edit",
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/edit-laporan',
                        arguments: data,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: "Hapus",
                    color: Colors.red,
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
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Batal"),
                                ),
                                CustomButton(
                                  label: "Hapus",
                                  color: Colors.red,
                                  onPressed: () {
                                    context.read<DeleteLaporanBloc>().add(
                                      DeleteLaporanSubmitted(id: data.id!),
                                    );
                                    Navigator.pop(context);
                                      Navigator.pushNamedAndRemoveUntil(context, '/feed',  (_) => false);
                                  },
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 8),
            if (data.tipe == 'ditemukan') ...[
              CustomButton(
                label: "Klaim Barang Ini",
                onPressed: () => _showKlaimDialog(context),
              ),
            ] else if (data.tipe == 'hilang') ...[
              CustomButton(
                label: "Hubungi Penemu",
                onPressed: () => _hubungiPenemu(context),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
