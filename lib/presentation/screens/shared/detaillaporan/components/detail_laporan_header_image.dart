import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/image_popup_viewer.dart';

class DetailLaporanHeaderImage extends StatelessWidget {
  final Uint8List? decodedImage;

  const DetailLaporanHeaderImage({super.key, required this.decodedImage});

  @override
  Widget build(BuildContext context) {
    if (decodedImage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => ImagePopupViewer(imageBytes: decodedImage!),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              decodedImage!,
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image, size: 80, color: Colors.grey),
    );
  }
}
