import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemu_app/core/components/custom_text_field.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/core/constants/kategori_list.dart';
import 'package:nemu_app/data/model/kategori_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'laporan_type_selector.dart';
import 'image_option_button.dart';

class FormLaporan extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController namaBarangController;
  final TextEditingController deskripsiController;
  final TextEditingController lokasiTextController;
  final TextEditingController pertanyaanController;
  final TextEditingController jawabanController;
  final Function(String?) onTipeChanged;
  final Function(String?) onKategoriChanged;
  final String? selectedTipe;
  final String? selectedKategori;

  const FormLaporan({
    super.key,
    required this.formKey,
    required this.namaBarangController,
    required this.deskripsiController,
    required this.lokasiTextController,
    required this.pertanyaanController,
    required this.jawabanController,
    required this.onTipeChanged,
    required this.onKategoriChanged,
    required this.selectedTipe,
    required this.selectedKategori,
  });

  @override
  State<FormLaporan> createState() => _FormLaporanState();
}

class _FormLaporanState extends State<FormLaporan> {
  @override
  Widget build(BuildContext context) {
    final imageFile = context.watch<FotoLaporanBloc>().state.file;

    return Form(
      key: widget.formKey,
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
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        context.read<FotoLaporanBloc>().add(
                          ClearSelectedFoto(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          const Text(
            'Nama Barang',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CustomTextField(
            hintText: 'Nama Barang',
            icon: Icons.label_outline,
            controller: widget.namaBarangController,
          ),
          const SizedBox(height: 12),

          const Text(
            'Deskripsi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          CustomTextField(
            hintText: 'Deskripsi',
            icon: Icons.description,
            controller: widget.deskripsiController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 12),

          const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          DropdownButtonFormField<KategoriModel>(
            decoration: InputDecoration(
              hintText: 'Pilih Kategori',
              prefixIcon: const Icon(Icons.category),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            value:
                widget.selectedKategori == null
                    ? null
                    : KategoriList.all.firstWhere(
                      (kat) => kat.nama == widget.selectedKategori,
                      orElse: () => KategoriList.all.first,
                    ),
            onChanged: (value) {
              widget.onKategoriChanged(value?.nama);
            },
            items:
                KategoriList.all.map((kategori) {
                  return DropdownMenuItem<KategoriModel>(
                    value: kategori,
                    child: Text(kategori.nama),
                  );
                }).toList(),
            validator:
                (value) => value == null ? 'Kategori harus dipilih' : null,
          ),

          const SizedBox(height: 12),
          const Text(
            'Lokasi Kehilangan / Penemuan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.lokasiTextController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Pilih lokasi dari peta',
                    prefixIcon: const Icon(Icons.location_on),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.map_rounded,
                  color: AppColors.primary,
                  size: 42,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/map-picker').then((
                    selectedLocationText,
                  ) {
                    if (selectedLocationText != null &&
                        selectedLocationText is String) {
                      widget.lokasiTextController.text = selectedLocationText;
                    }
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 12),
          LaporanTypeSelector(
            selectedType: widget.selectedTipe,
            onSelected: widget.onTipeChanged,
          ),

          const SizedBox(height: 12),
          if (widget.selectedTipe == 'Ditemukan') ...[
            const Text(
              'Pertanyaan Verifikasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            CustomTextField(
              hintText: 'Pertanyaan Verifikasi',
              icon: Icons.question_answer,
              controller: widget.pertanyaanController,
            ),
            const SizedBox(height: 12),
            const Text(
              'Jawaban Verifikasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomTextField(
              hintText: 'Jawaban Verifikasi',
              icon: Icons.lock_outline,
              controller: widget.jawabanController,
            ),
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageOptionButton(
                icon: Icons.camera_alt_outlined,
                label: "Kamera",
                onTap: () async {
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
              ),
              ImageOptionButton(
                icon: Icons.photo_library_outlined,
                label: "Galeri",
                onTap: () async {
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
