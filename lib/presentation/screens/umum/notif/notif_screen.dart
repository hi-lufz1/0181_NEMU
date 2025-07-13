import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/data/model/response/umum/notif_res_model.dart';
import 'package:nemu_app/presentation/bloc/notif/bloc/notif_bloc.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({super.key});

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotifBloc>().add(LoadNotifikasi());
  }

  Future<void> _refresh() async {
    context.read<NotifBloc>().add(LoadNotifikasi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F8),
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<NotifBloc, NotifState>(
        builder: (context, state) {
          if (state is NotifLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotifFailure) {
            return Center(
              child: Text(state.resModel.message ?? "Gagal memuat notifikasi"),
            );
          }

          if (state is NotifSuccess) {
            final notifikasi = state.resModel.data ?? [];

            if (notifikasi.isEmpty) {
              return const Center(child: Text("Tidak ada notifikasi"));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notifikasi.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notif = notifikasi[index];

                  return ListTile(
                    tileColor:
                        notif.sudahDibaca == 0
                            ? Colors.grey.shade200
                            : Colors.white,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.isi ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if ((notif.namaPengklaim ?? "").isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            "Oleh: ${notif.namaPengklaim}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(
                      notif.dibuatPada != null
                          ? DateFormat(
                            'dd MMM yyyy, HH:mm',
                            'id_ID',
                          ).format(notif.dibuatPada!)
                          : '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing:
                        notif.sudahDibaca == 0
                            ? const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 10,
                            )
                            : null,
                    onTap: () async {
                      if (notif.sudahDibaca == 0) {
                        context.read<NotifBloc>().add(
                          TandaiNotifSudahDibaca(
                            id: notif.id!,
                            terkaitId: notif.terkaitId ?? '',
                          ),
                        );
                      }

                      if ((notif.terkaitId ?? '').isNotEmpty) {
                        await Navigator.pushNamed(
                          context,
                          '/detail-laporan',
                          arguments: notif.terkaitId,
                        );
                        _refresh();
                      }
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox(); // default fallback
        },
      ),
    );
  }
}
