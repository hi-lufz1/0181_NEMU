import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/draf/draf_bloc.dart';

class DraftLaporanScreen extends StatelessWidget {
  const DraftLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F8),
      appBar: AppBar(
        title: const Text('Draf Laporan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<DrafBloc, DrafState>(
        builder: (context, state) {
          if (state is DrafLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DrafError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is DrafLoaded) {
            final List<LaporanDrafModel> draftList = state.list;

            if (draftList.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada draf tersimpan.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: draftList.length,
              itemBuilder: (context, index) {
                final draft = draftList[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    onTap: () {
                      debugPrint('Navigasi dengan ID: ${draft.id}');
                      Navigator.pushNamed(
                        context,
                        '/create-laporan',
                        arguments: draft,
                      );
                    },
                    leading: Icon(
                      draft.tipe == 'hilang'
                          ? Icons.report
                          : Icons.check_circle,
                      color:
                          draft.tipe == 'hilang' ? Colors.orange : Colors.green,
                    ),
                    title: Text(
                      draft.namaBarang ?? 'Tanpa Nama',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      draft.tipe == 'hilang'
                          ? 'Laporan Hilang'
                          : 'Laporan Ditemukan',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<DrafBloc>().add(DeleteDrafEvent(draft.id));
                      },
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
