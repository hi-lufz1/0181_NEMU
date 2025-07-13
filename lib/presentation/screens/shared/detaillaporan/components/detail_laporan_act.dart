import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_outline_button.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/camera/bloc/foto_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteuser/delete_laporan_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_cubit.dart';
import 'package:nemu_app/presentation/bloc/laporan/update/update_laporan_bloc.dart';
import 'package:nemu_app/presentation/screens/admin/delete/delete_by_admin_dialog.dart';
import 'package:nemu_app/presentation/screens/shared/detaillaporan/components/klaim_dialog.dart';
import 'package:nemu_app/presentation/screens/shared/editlaporan/edit_laporan_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLaporanAct extends StatelessWidget {
  final Data data;
  final bool isLaporanSaya;
  final bool isAdmin;

  const DetailLaporanAct({
    super.key,
    required this.data,
    required this.isLaporanSaya,
    this.isAdmin = false,
  });

  void _hubungiPenemu(BuildContext context) async {
    final url = data.kontak?.replaceAll(' ', '').replaceAll('+', '62');
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kontak penemu tidak tersedia")),
      );
      return;
    }

    final Uri whatsappUri = Uri.parse("https://wa.me/$url");

    final success = await launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
    );

    if (!success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal membuka WhatsApp")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAktif = data.status == 'aktif';
    final bool isDihapus =
        data.status == 'dihapus' || data.status == 'dihapus_sendiri';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(
        builder: (_) {
          if (isDihapus) {
            return const SizedBox(height: 0);
          }

          if (isLaporanSaya && isAktif) {
            return Row(
              children: [
                Expanded(
                  child: CustomOutlineButton(
                    label: "Edit",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create:
                                        (_) =>
                                            FormLaporanCubit()
                                              ..setInitialFromDetail(data),
                                  ),
                                  BlocProvider(
                                    create: (_) {
                                      final bloc = FotoLaporanBloc();
                                      if (data.foto != null) {
                                        bloc.add(
                                          SetFromBase64(base64: data.foto!),
                                        );
                                      }
                                      return bloc;
                                    },
                                  ),
                                  BlocProvider(
                                    create:
                                        (_) => DeleteLaporanBloc(
                                          laporanRepository: context.read(),
                                        ),
                                  ),
                                  BlocProvider(
                                    create:
                                        (_) => UpdateLaporanBloc(
                                          laporanRepository: context.read(),
                                        ),
                                  ),
                                ],
                                child: EditLaporanScreen(laporan: data),
                              ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: "Hapus",
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("Hapus Laporan"),
                              content: const Text(
                                "Yakin ingin menghapus laporan ini?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Batal"),
                                ),
                                CustomButton(
                                  label: "Hapus",
                                  color: Colors.red,
                                  onPressed: () {
                                    context.read<DeleteLaporanBloc>().add(
                                      DeleteLaporanSubmitted(id: data.id!),
                                    );
                                    Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/feed',
                                      (_) => false,
                                    );
                                  },
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (isLaporanSaya && !isAktif) {
            return CustomButton(
              label: "Hapus",
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text("Hapus Laporan"),
                        content: const Text(
                          "Yakin ingin menghapus laporan ini?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Batal"),
                          ),
                          CustomButton(
                            label: "Hapus",
                            color: Colors.red,
                            onPressed: () {
                              context.read<DeleteLaporanBloc>().add(
                                DeleteLaporanSubmitted(id: data.id!),
                              );
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/feed',
                                (_) => false,
                              );
                            },
                          ),
                        ],
                      ),
                );
              },
            );
          } else if (isAdmin && isAktif) {
            return CustomButton(
              label: "Hapus oleh Admin",
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DeleteByAdminDialog(laporanId: data.id!),
                );
              },
            );
          } else if (!isLaporanSaya && isAktif) {
            return Column(
              children: [
                const SizedBox(height: 8),
                if (data.tipe == 'ditemukan') ...[
                  CustomButton(
                    label: "Klaim Barang Ini",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => KlaimDialog(data: data),
                      );
                    },
                  ),
                ] else if (data.tipe == 'hilang') ...[
                  CustomButton(
                    label: "Hubungi Penemu",
                    onPressed: () => _hubungiPenemu(context),
                  ),
                ],
              ],
            );
          }
          return const SizedBox(height: 0);
        },
      ),
    );
  }
}
