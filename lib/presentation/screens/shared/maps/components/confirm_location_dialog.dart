import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_outline_button.dart';
import 'package:nemu_app/core/constants/colors.dart';

class ConfirmLocationDialog extends StatelessWidget {
  final String address;
  final VoidCallback onConfirm;

 const ConfirmLocationDialog({
    super.key, 
    required this.address,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Konfirmasi Alamat',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(address, style: const TextStyle(fontSize: 16)),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                label: 'Batal',
                onPressed: () => Navigator.pop(context),
                borderColor: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                label: 'Pilih',
                onPressed: () {
                  onConfirm(); // Callback untuk lanjutkan
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
