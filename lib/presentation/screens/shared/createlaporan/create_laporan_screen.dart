import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/maps/bloc/map_bloc.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/add/add_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/draf/draf_bloc.dart';
import 'components/form_laporan.dart';

class CreateLaporanScreen extends StatefulWidget {
  const CreateLaporanScreen({super.key});

  @override
  State<CreateLaporanScreen> createState() => _CreateLaporanScreenState();
}

class _CreateLaporanScreenState extends State<CreateLaporanScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is LaporanDrafModel) {
        final formCubit = context.read<FormLaporanCubit>();
        formCubit.setFromDraft(args);
        formCubit.setDraftId(args.id);

        if (args.latitude != null && args.longitude != null) {
          context.read<MapBloc>().add(
            SetPickedLatLng(
              latitude: args.latitude!,
              longitude: args.longitude!,
            ),
          );
        }

        if (args.foto != null) {
          context.read<FotoLaporanBloc>().add(LoadFotoFromPath(args.foto!));
        }

        isLoaded = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("CreateLaporanScreen dibuild ulang");

    final formCubit = context.read<FormLaporanCubit>();
    final foto = context.watch<FotoLaporanBloc>().state.file;
    final pickedLatLng = context.watch<MapBloc>().state.pickedLatLng;

    return BlocListener<AddLaporanBloc, AddLaporanState>(
      listener: (context, state) {
        if (state is AddLaporanSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.resModel.message ?? 'Berhasil')),
          );
          formCubit.clear();
          context.read<FotoLaporanBloc>().add(ClearSelectedFoto());
          Navigator.pushNamedAndRemoveUntil(context, '/feed', (_) => false);
        } else if (state is AddLaporanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.resModel.message ?? 'Gagal mengirim laporan'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Buat Laporan')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormLaporan(formKey: _formKey),
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
                      final form = formCubit.state;
                      if (form.namaBarang.isEmpty &&
                          form.deskripsi.isEmpty &&
                          form.lokasiText.isEmpty &&
                          foto == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Isi minimal satu data sebelum simpan draf",
                            ),
                          ),
                        );
                        return;
                      }

                      final draf = LaporanDrafModel(
                        id: formCubit.draftId,
                        namaBarang: form.namaBarang,
                        deskripsi: form.deskripsi,
                        lokasiText: form.lokasiText,
                        tipe: form.tipe ?? '',
                        kategori: form.kategori ?? '',
                        pertanyaanVerifikasi: form.pertanyaanVerifikasi,
                        jawabanVerifikasi: form.jawabanVerifikasi,
                        foto: foto?.path,
                        latitude: pickedLatLng?.latitude,
                        longitude: pickedLatLng?.longitude,
                      );

                      debugPrint('Simpan draf: ${formCubit.draftId ?? 'baru'}');

                      context.read<DrafBloc>().add(AddDrafEvent(draf));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Disimpan ke draf")),
                      );
                      formCubit.clear();
                      Navigator.pushReplacementNamed(context, '/draft');
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
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final form = formCubit.state;
                      if (form.tipe == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Pilih tipe laporan terlebih dahulu"),
                          ),
                        );
                        return;
                      }
                      debugPrint(
                        'Hapus draf: ${formCubit.draftId ?? 'tidak ada'}',
                      );

                      if (formCubit.draftId != null) {
                        context.read<DrafBloc>().add(
                          DeleteDrafEvent(formCubit.draftId!),
                        );
                      }

                      if (_formKey.currentState!.validate()) {
                        final base64Foto =
                            foto != null
                                ? base64Encode(await foto.readAsBytes())
                                : null;

                        final laporan = formCubit.toRequestModel(
                          base64Foto: base64Foto,
                          latitude: pickedLatLng?.latitude,
                          longitude: pickedLatLng?.longitude,
                        );

                        context.read<AddLaporanBloc>().add(
                          AddLaporanSubmitted(reqModel: laporan),
                        );
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
