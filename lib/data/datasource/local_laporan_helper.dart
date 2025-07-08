import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'laporan_draf.db';
  static const _dbVersion = 1;

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE draf_laporan (
  id TEXT PRIMARY KEY,
  tipe TEXT,
  nama_barang TEXT,
  deskripsi TEXT,
  kategori TEXT,
  lokasi_text TEXT,
  latitude REAL,
  longitude REAL,
  foto TEXT,
  pertanyaan_verifikasi TEXT,
  jawaban_verifikasi TEXT,
  dibuat_pada TEXT NOT NULL
)
    ''');
  }
}
