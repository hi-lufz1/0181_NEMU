import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

class LaporanTypeSelector extends StatelessWidget {
  final String? selectedType;
  final void Function(String type) onSelected;

  const LaporanTypeSelector({
    super.key,
    required this.selectedType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipe Laporan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedType == 'Hilang'
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  foregroundColor:
                      selectedType == 'Hilang' ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => onSelected('Hilang'),
                child: const Text('Hilang'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedType == 'Ditemukan'
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  foregroundColor: selectedType == 'Ditemukan'
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => onSelected('Ditemukan'),
                child: const Text('Ditemukan'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
