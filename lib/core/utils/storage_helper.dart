// lib/helper/storage_helper.dart

import 'dart:io';
import 'package:path/path.dart' as path;

class StorageHelper {
  static Future<String> _getFolderPath() async {
    final dir = Directory('/storage/emulated/0/DCIM/NEMUApp');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir.path;
  }

  static Future<File> saveImage(File file, String prefix) async {
    final folder = await _getFolderPath();
    final fileName =
        '$prefix${DateTime.now().microsecondsSinceEpoch}${path.extension(file.path)}';
    final savedPath = path.join(folder, fileName);
    return await file.copy(savedPath);
  }
}
