import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/utils/pdf_export_helper.dart';
import 'package:nemu_app/presentation/bloc/laporan/detail/detail_laporan_bloc.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/components/detail_laporan_act.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/components/detail_laporan_content.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/components/detail_laporan_header_image.dart';

// Tetap gunakan class utama
class DetailLaporanScreen extends StatelessWidget {
  final String laporanId;

  const DetailLaporanScreen({super.key, required this.laporanId});

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
          actions: [
            BlocBuilder<DetailLaporanBloc, DetailLaporanState>(
              builder: (context, state) {
                if (state is DetailLaporanSuccess &&
                    (state.isLaporanSaya || state.isAdmin)) {
                  return IconButton(
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    tooltip: "Export PDF",
                    onPressed: () async {
                      await PDFExportHelper.exportSingleLaporan(
                        state.resModel.data!,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
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
              final decodedImage = _decodeBase64Image(data.foto);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailLaporanHeaderImage(decodedImage: decodedImage),
                    const SizedBox(height: 16),
                    DetailLaporanContent(data: data),
                    const SizedBox(height: 24),
                    DetailLaporanAct(
                      data: data,
                      isLaporanSaya: state.isLaporanSaya,
                      isAdmin: state.isAdmin,
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

  Uint8List? _decodeBase64Image(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }
}
