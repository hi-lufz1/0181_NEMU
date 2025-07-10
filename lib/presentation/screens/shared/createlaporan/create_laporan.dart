import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';

class CreateLaporanScreen extends StatefulWidget {
  const CreateLaporanScreen({super.key});

  @override
  State<CreateLaporanScreen> createState() => _CreateLaporanScreenState();
}

class _CreateLaporanScreenState extends State<CreateLaporanScreen> {
  final _formKey = GlobalKey<FormState>();

  String? tipe;
  String? namaBarang;
  String? deskripsi;
  String? kategori;
  String? lokasiText;
  String? pertanyaan;
  String? jawaban;

  @override
  Widget build(BuildContext context) {
    final fotoState = context.watch<FotoLaporanBloc>().state;
    final File? imageFile = fotoState.file;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan'),
        actions: [
          TextButton(
            onPressed: () {
              // Simpan draf (jika ada fitur draf)
            },
            child: const Text(
              "Simpan Draf",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageFile != null) ...[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        imageFile,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed:
                              () => context.read<FotoLaporanBloc>().add(
                                ClearSelectedFoto(),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tipe Laporan'),
                items: const [
                  DropdownMenuItem(value: 'Hilang', child: Text('Hilang')),
                  DropdownMenuItem(
                    value: 'Ditemukan',
                    child: Text('Ditemukan'),
                  ),
                ],
                onChanged: (value) => tipe = value,
                validator: (value) => value == null ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                onChanged: (value) => namaBarang = value,
                validator:
                    (value) =>
                        (value == null || value.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                onChanged: (value) => deskripsi = value,
                validator:
                    (value) =>
                        (value == null || value.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kategori'),
                onChanged: (value) => kategori = value,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Lokasi (tulisan, opsional)',
                ),
                onChanged: (value) => lokasiText = value,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pertanyaan Verifikasi',
                ),
                onChanged: (value) => pertanyaan = value,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Jawaban Verifikasi',
                ),
                onChanged: (value) => jawaban = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (picked != null) {
                    context.read<FotoLaporanBloc>().add(
                      SetSelectedFoto(File(picked.path)),
                    );
                  }
                },
                icon: const Icon(Icons.photo),
                label: const Text("Pilih Gambar dari Galeri"),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (picked != null) {
                    context.read<FotoLaporanBloc>().add(
                      SetSelectedFoto(File(picked.path)),
                    );
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Ambil Gambar dari Kamera"),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final fotoFile = context.read<FotoLaporanBloc>().state.file;

                    final laporan = AddLaporanReqModel(
                      tipe: tipe,
                      namaBarang: namaBarang,
                      deskripsi: deskripsi,
                      kategori: kategori,
                      lokasiText: lokasiText,
                      pertanyaanVerifikasi: pertanyaan,
                      jawabanVerifikasi: jawaban,
                      foto:
                          fotoFile != null
                              ? base64Encode(await fotoFile.readAsBytes())
                              : null,
                    );

                    context.read<AddLaporanBloc>().add(
                      AddLaporanSubmitted(reqModel: laporan),
                    );
                  }
                },
                child: const Text("Kirim Laporan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
