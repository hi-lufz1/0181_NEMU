import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/data/model/request/admin/delete_admin_req_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/deleteadmin/delete_admin_bloc.dart';

class DeleteByAdminDialog extends StatefulWidget {
  final String laporanId;

  const DeleteByAdminDialog({super.key, required this.laporanId});

  @override
  State<DeleteByAdminDialog> createState() => _DeleteByAdminDialogState();
}

class _DeleteByAdminDialogState extends State<DeleteByAdminDialog> {
  final TextEditingController _alasanController = TextEditingController();

  @override
  void dispose() {
    _alasanController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<DeleteAdminBloc>().add(
          DeleteAdminSubmitted(
            id: widget.laporanId,
            reqModel: DeleteAdminReqModel(
              catatanAdmin: _alasanController.text,
            ),
          ),
        );
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/admin-feed', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Hapus Laporan oleh Admin"),
      content: TextField(
        controller: _alasanController,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "Masukkan alasan penghapusan...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        CustomButton(
          label: "Hapus",
          color: Colors.red,
          onPressed: _submit,
        ),
      ],
    );
  }
}
