import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/constants/colors.dart';
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

  final List<String> _options = [
    "Konten tidak relevan",
    "Informasi menyesatkan",
    "Spam atau duplikat",
    "Melanggar kebijakan",
    "Lainnya",
  ];

  String? _selectedReason;

  @override
  void dispose() {
    _alasanController.dispose();
    super.dispose();
  }

  void _submit() {
    final isOther = _selectedReason == "Lainnya";
    final reason = isOther ? _alasanController.text : _selectedReason;

    if (reason == null || reason.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alasan tidak boleh kosong")),
      );
      return;
    }

    context.read<DeleteAdminBloc>().add(
      DeleteAdminSubmitted(
        id: widget.laporanId,
        reqModel: DeleteAdminReqModel(catatanAdmin: reason),
      ),
    );

    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/admin-feed', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Hapus Laporan oleh Admin"),
      content: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedReason,
                  isExpanded: true,
                  items: _options.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedReason = value;
                      if (value != "Lainnya") {
                        _alasanController.clear();
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Pilih Alasan',
                    prefixIcon: const Icon(Icons.report_problem),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.secondary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (_selectedReason == "Lainnya")
                  TextField(
                    controller: _alasanController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Tulis alasan lainnya...",
                      prefixIcon: const Icon(Icons.edit_note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.secondary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
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
