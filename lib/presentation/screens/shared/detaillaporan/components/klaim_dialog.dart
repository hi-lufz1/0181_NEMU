import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/data/model/request/umum/klaim_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/klaim/bloc/klaim_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class KlaimDialog extends StatefulWidget {
  final Data data;

  const KlaimDialog({super.key, required this.data});

  @override
  State<KlaimDialog> createState() => _KlaimDialogState();
}

class _KlaimDialogState extends State<KlaimDialog> {
  final jawabanController = TextEditingController();

  Future<void> _redirectToWhatsapp(String? nomor) async {
    final nomorFormatted = nomor?.replaceAll(' ', '').replaceAll('+', '62');
    if (nomorFormatted == null || nomorFormatted.isEmpty) return;

    final uri = Uri.parse("https://wa.me/$nomorFormatted");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal membuka WhatsApp")));
    }
  }

  void _submitKlaim(BuildContext context) {
    final jawaban = jawabanController.text.trim();
    if (jawaban.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Jawaban tidak boleh kosong")),
      );
      return;
    }

    context.read<KlaimBloc>().add(
      KlaimSubmitted(
        laporanId: widget.data.id!,
        reqModel: KlaimReqModel(jawabanUser: jawaban),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Verifikasi Klaim"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.data.pertanyaanVerifikasi ?? "-"),
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
        BlocConsumer<KlaimBloc, KlaimState>(
          listener: (context, state) async {
            if (state is KlaimSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.resModel.message ?? 'Klaim berhasil'),
                ),
              );
              if (state.resModel.redirectToWhatsapp == true) {
                await _redirectToWhatsapp(widget.data.kontak);
              }
            } else if (state is KlaimFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.resModel.message ?? 'Klaim gagal'),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is KlaimLoading;
            return CustomButton(
              label: isLoading ? "Memproses..." : "Klaim Sekarang",
              onPressed: isLoading ? null : () => _submitKlaim(context),
            );
          },
        ),
      ],
    );
  }
}
