import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/draf/draf_bloc.dart';

class DraftLaporanScreen extends StatelessWidget {
  const DraftLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draf Laporan'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<DrafBloc, DrafState>(
        builder: (context, state) {
          if (state is DrafLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DrafError) {
            return Center(child: Text(state.message));
          } else if (state is DrafLoaded) {
            final List<LaporanDrafModel> draftList = state.list;

            if (draftList.isEmpty) {
              return const Center(child: Text('Belum ada draf tersimpan.'));
            }

            return ListView.builder(
              itemCount: draftList.length,
              itemBuilder: (context, index) {
                final draft = draftList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () {
                      debugPrint('Navigasi dengan ID: ${draft.id}');
                      Navigator.pushNamed(
                        context,
                        '/create-laporan',
                        arguments: draft, // Kirim draft sebagai argumen
                      );
                    },
                    title: Text(draft.namaBarang ?? 'Tanpa Nama'),
                    subtitle: Text(
                      draft.tipe == 'hilang'
                          ? 'Laporan Hilang'
                          : 'Laporan Ditemukan',
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
