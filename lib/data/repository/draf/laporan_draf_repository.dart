import 'package:nemu_app/data/datasource/draf_dao.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';

import '../../datasource/draf_dao.dart';
import '../../model/laporan_draf_model.dart';

class LaporanDrafRepository {
  final DrafDao dao;

  LaporanDrafRepository({required this.dao});

  // Simpan draf baru
  Future<void> simpanDraf(LaporanDrafModel model) async {
    await dao.insert(model);
  }

  // Ambil semua draf
  Future<List<LaporanDrafModel>> ambilSemuaDraf() async {
    return await dao.getAll();
  }

  // Ambil draf berdasarkan ID
  Future<LaporanDrafModel?> ambilDrafById(String id) async {
    return await dao.getById(id);
  }

  // Hapus draf tertentu
  Future<void> hapusDraf(String id) async {
    await dao.delete(id);
  }

  // Update draf yang sudah ada
  Future<void> updateDraf(LaporanDrafModel model) async {
    await dao.update(model);
  }

  // Hapus semua draf
  Future<void> hapusSemuaDraf() async {
    await dao.deleteAll();
  }
}
