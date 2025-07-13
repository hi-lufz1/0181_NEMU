import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/custom_text_field.dart';
import 'package:nemu_app/core/constants/colors.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchChanged;
  final VoidCallback onFilterPressed;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: searchController,
            hintText: "Cari nama barang...",
            icon: Icons.search,
            onChanged: (_) => onSearchChanged(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onFilterPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(72, 54),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
        ),
      ],
    );
  }
}
