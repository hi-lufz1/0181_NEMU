import 'dart:io';
import 'package:flutter/material.dart';

class ImagePopupViewer extends StatelessWidget {
  final File imageFile;

  const ImagePopupViewer({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          InteractiveViewer(
            child: Center(
              child: Image.file(
                imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
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
