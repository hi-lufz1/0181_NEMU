import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemu_app/core/components/custom_text_field.dart';
import 'package:nemu_app/core/components/image_popup_viewer.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/core/constants/kategori_list.dart';
import 'package:nemu_app/data/model/kategori_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/maps/bloc/map_bloc.dart';
import 'laporan_type_selector.dart';
import 'image_option_button.dart';

class FormLaporan extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const FormLaporan({super.key, required this.formKey});

  void _showImagePopup(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (_) => ImagePopupViewer(imageFile: imageFile),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = context.watch<FotoLaporanBloc>().state.file;
    final state = context.watch<FormLaporanCubit>().state;
    final cubit = context.read<FormLaporanCubit>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageFile != null) ...[
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _showImagePopup(context, imageFile),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      imageFile,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
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
          const SizedBox(height: 6),
          CustomTextField(
            hintText: 'Nama Barang',
            icon: Icons.label_outline,
            initialValue: state.namaBarang,
            onChanged: cubit.setNamaBarang,
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Nama barang harus diisi'
                        : null,
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
            initialValue: state.deskripsi,
            keyboardType: TextInputType.multiline,
            onChanged: cubit.setDeskripsi,
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Deskripsi harus diisi'
                        : null,
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.secondary, width: 2),
              ),
            ),
            value:
                state.kategori == null
                    ? null
                    : KategoriList.all.firstWhere(
                      (kat) => kat.nama == state.kategori,
                      orElse: () => KategoriList.all.first,
                    ),
            onChanged: (val) => cubit.setKategori(val?.nama),
            items:
                KategoriList.all
                    .map(
                      (kategori) => DropdownMenuItem(
                        value: kategori,
                        child: Text(kategori.nama),
                      ),
                    )
                    .toList(),
            validator: (val) => val == null ? 'Kategori harus dipilih' : null,
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
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.lokasiText),
                  decoration: InputDecoration(
                    hintText: 'Pilih lokasi dari peta',
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/map-picker').then((result) {
                        debugPrint('🌍 Hasil MapPicker (Field): $result');
                      if (result != null &&
                          result is Map &&
                          result['address'] is String &&
                          result['latlng'] is LatLng) {
                        cubit.setLokasi(result['address'], result['latlng']);
                        context.read<MapBloc>().add(
                          SetPickedLatLng(
                            latitude: result['latlng'].latitude,
                            longitude: result['latlng'].longitude,
                          ),
                        );
                      }
                    });
                  },

                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'Lokasi harus dipilih'
                              : null,
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
                  Navigator.pushNamed(context, '/map-picker').then((result) {
                       debugPrint('🌍 Hasil MapPicker (IconButton): $result');
                    if (result != null &&
                        result is Map &&
                        result['address'] is String &&
                        result['latlng'] is LatLng) {
                      cubit.setLokasi(result['address'], result['latlng']);
                      context.read<MapBloc>().add(
                        SetPickedLatLng(
                          latitude: result['latlng'].latitude,
                          longitude: result['latlng'].longitude,
                        ),
                      );
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          LaporanTypeSelector(
            selectedType: state.tipe,
            onSelected: cubit.setTipe,
          ),
          const SizedBox(height: 12),

          if (state.tipe == 'Ditemukan') ...[
            const Text(
              'Pertanyaan Verifikasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            CustomTextField(
              hintText: 'Pertanyaan Verifikasi',
              icon: Icons.question_answer,
              initialValue: state.pertanyaanVerifikasi,
              onChanged: cubit.setPertanyaan,
              validator:
                  (val) =>
                      val == null || val.isEmpty
                          ? 'Pertanyaan wajib diisi'
                          : null,
            ),
            const SizedBox(height: 12),
            const Text(
              'Jawaban Verifikasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomTextField(
              hintText: 'Jawaban Verifikasi',
              icon: Icons.lock_outline,
              initialValue: state.jawabanVerifikasi,
              onChanged: cubit.setJawaban,
              validator:
                  (val) =>
                      val == null || val.isEmpty ? 'Jawaban wajib diisi' : null,
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
                  context.read<FotoLaporanBloc>().add(TakeFromCamera());
                },
              ),
              ImageOptionButton(
                icon: Icons.photo_library_outlined,
                label: "Galeri",
                onTap: () async {
                  context.read<FotoLaporanBloc>().add(PickFromGallery());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
