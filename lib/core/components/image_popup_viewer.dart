import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePopupViewer extends StatelessWidget {
  final File? imageFile;
  final Uint8List? imageBytes;

  const ImagePopupViewer({super.key, this.imageFile, this.imageBytes});

  @override
  Widget build(BuildContext context) {
    final imageWidget =
        imageFile != null
            ? Image.file(imageFile!, fit: BoxFit.contain)
            : imageBytes != null
            ? Image.memory(imageBytes!, fit: BoxFit.contain)
            : const SizedBox.shrink();

    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          InteractiveViewer(child: Center(child: imageWidget)),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
