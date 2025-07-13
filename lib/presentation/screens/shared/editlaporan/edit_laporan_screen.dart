import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/data/model/request/shared/update_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/laporan/update/update_laporan_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/presentation/screens/shared/createlaporan/components/form_laporan.dart';

class EditLaporanScreen extends StatelessWidget {
  final Data laporan;

  const EditLaporanScreen({super.key, required this.laporan});

  void _loadInitialData(BuildContext context) {
    final formCubit = context.read<FormLaporanCubit>();
    formCubit.setInitialFromDetail(laporan);

    if (laporan.foto != null) {
      context.read<FotoLaporanBloc>().add(SetFromBase64(base64: laporan.foto!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    debugPrint("EditLaporanScreen dibuild ulang");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData(context);
    });

    return BlocProvider(
      create: (_) => UpdateLaporanBloc(laporanRepository: context.read()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Laporan"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          centerTitle: true,
        ),
        body: BlocListener<UpdateLaporanBloc, UpdateLaporanState>(
          listener: (context, state) {
            if (state is UpdateLaporanSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.resModel.message ?? 'Laporan berhasil diperbarui',
                  ),
                ),
              );
              Navigator.pop(context, true); // kembali ke halaman sebelumnya
            } else if (state is UpdateLaporanFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.resModel.message ?? 'Gagal memperbarui laporan',
                  ),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormLaporan(formKey: formKey),
                  const SizedBox(height: 24),
                  BlocBuilder<UpdateLaporanBloc, UpdateLaporanState>(
                    builder: (context, state) {
                      final isLoading = state is UpdateLaporanLoading;

                      return CustomButton(
                        label: isLoading ? "Menyimpan..." : "Simpan Perubahan",
                        onPressed: () async {
                          if (isLoading) return;

                          if (formKey.currentState!.validate()) {
                            final formCubit = context.read<FormLaporanCubit>();
                            final fotoBloc = context.read<FotoLaporanBloc>();

                            // Konversi file ke base64
                            final file = fotoBloc.state.file;
                            final bytes = await file?.readAsBytes();
                            final base64Foto =
                                bytes != null ? base64Encode(bytes) : null;

                            // Dapatkan AddLaporanReqModel dari FormCubit
                            final lokasiLatLng = formCubit.state.lokasiLatLng;

                            final addModel = formCubit.toRequestModel(
                              base64Foto: base64Foto,
                              latitude: lokasiLatLng?.latitude,
                              longitude: lokasiLatLng?.longitude,
                            );

                            // Konversi ke UpdateReqModel
                            final updateModel = UpdateReqModel.fromAdd(
                              addModel,
                            );

                            // Kirim event ke BLoC
                            context.read<UpdateLaporanBloc>().add(
                              UpdateLaporanSubmitted(
                                id: laporan.id!,
                                reqModel: updateModel,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
