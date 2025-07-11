import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';
import 'components/form_laporan.dart';

class CreateLaporanScreen extends StatefulWidget {
  const CreateLaporanScreen({super.key});

  @override
  State<CreateLaporanScreen> createState() => _CreateLaporanScreenState();
}

class _CreateLaporanScreenState extends State<CreateLaporanScreen> {
  final _formKey = GlobalKey<FormState>();

  final namaBarangController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiTextController = TextEditingController();
  final pertanyaanController = TextEditingController();
  final jawabanController = TextEditingController();

  String? tipe;
  String? selectedKategori;

  @override
  void dispose() {
    namaBarangController.dispose();
    deskripsiController.dispose();
    lokasiTextController.dispose();
    pertanyaanController.dispose();
    jawabanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLaporanBloc, AddLaporanState>(
      listener: (context, state) {
        if (state is AddLaporanSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.resModel.message ?? 'Berhasil')),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/feed', (_) => false);
        } else if (state is AddLaporanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.resModel.message ?? 'Gagal mengirim laporan'))
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Buat Laporan')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormLaporan(
            formKey: _formKey,
            namaBarangController: namaBarangController,
            deskripsiController: deskripsiController,
            lokasiTextController: lokasiTextController,
            pertanyaanController: pertanyaanController,
            jawabanController: jawabanController,
            selectedTipe: tipe,
            selectedKategori: selectedKategori,
            onTipeChanged: (val) => setState(() => tipe = val),
            onKategoriChanged: (val) => setState(() => selectedKategori = val),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Tombol Simpan Draf
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Simpan ke sqflite
                    },
                    icon: const Icon(Icons.save, color: AppColors.primary),
                    label: const Text(
                      "Draf",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(color: AppColors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Tombol Kirim Laporan
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final fotoFile =
                            context.read<FotoLaporanBloc>().state.file;
                        final base64Foto = fotoFile != null
                            ? base64Encode(await fotoFile.readAsBytes())
                            : null;

                        final laporan = AddLaporanReqModel(
                          tipe: tipe,
                          namaBarang: namaBarangController.text,
                          deskripsi: deskripsiController.text,
                          kategori: selectedKategori ?? '',
                          lokasiText: lokasiTextController.text,
                          pertanyaanVerifikasi: tipe == 'Ditemukan'
                              ? pertanyaanController.text
                              : null,
                          jawabanVerifikasi: tipe == 'Ditemukan'
                              ? jawabanController.text
                              : null,
                          foto: base64Foto,
                        );

                        context
                            .read<AddLaporanBloc>()
                            .add(AddLaporanSubmitted(reqModel: laporan));
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      "Kirim",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
