import 'package:nemu_app/data/datasource/local_laporan_helper.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:sqflite/sqflite.dart';

class DrafDao {
  final dbProvider = DatabaseHelper();
  final String tableName = 'draf_laporan';

  // Tambah draf
  Future<void> insert(LaporanDrafModel model) async {
    final db = await dbProvider.database;
    await db.insert(tableName, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Ambil semua draf
  Future<List<LaporanDrafModel>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, orderBy: 'dibuat_pada DESC');
    return result.map((e) => LaporanDrafModel.fromMap(e)).toList();
  }

  // Ambil draf by ID
  Future<LaporanDrafModel?> getById(String id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return LaporanDrafModel.fromMap(result.first);
    }
    return null;
  }

  // Hapus satu draf
  Future<void> delete(String id) async {
    final db = await dbProvider.database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  // Hapus semua draf
  Future<void> deleteAll() async {
    final db = await dbProvider.database;
    await db.delete(tableName);
  }

  Future<void> update(LaporanDrafModel model) async {
  final db = await dbProvider.database;
  await db.update(
    tableName,
    model.toMap(),
    where: 'id = ?',
    whereArgs: [model.id],
  );
}

}
