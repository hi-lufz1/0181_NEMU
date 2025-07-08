import 'package:uuid/uuid.dart';

class LaporanDrafModel {
  final String id;
  final String? tipe;
  final String? namaBarang;
  final String? deskripsi;
  final String? kategori;
  final String? lokasiText;
  final double? latitude;
  final double? longitude;
  final String? foto;
  final String? pertanyaanVerifikasi;
  final String? jawabanVerifikasi;
  final String dibuatPada;

  LaporanDrafModel({
    String? id,
    this.tipe,
    this.namaBarang,
    this.deskripsi,
    this.kategori,
    this.lokasiText,
    this.latitude,
    this.longitude,
    this.foto,
    this.pertanyaanVerifikasi,
    this.jawabanVerifikasi,
    String? dibuatPada,
  }) : id = id ?? const Uuid().v4(),
       dibuatPada = dibuatPada ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() => {
    'id': id,
    'tipe': tipe,
    'nama_barang': namaBarang,
    'deskripsi': deskripsi,
    'kategori': kategori,
    'lokasi_text': lokasiText,
    'latitude': latitude,
    'longitude': longitude,
    'foto': foto,
    'pertanyaan_verifikasi': pertanyaanVerifikasi,
    'jawaban_verifikasi': jawabanVerifikasi,
    'dibuat_pada': dibuatPada,
  };

  factory LaporanDrafModel.fromMap(Map<String, dynamic> map) =>
      LaporanDrafModel(
        id: map['id'],
        tipe: map['tipe'],
        namaBarang: map['nama_barang'],
        deskripsi: map['deskripsi'],
        kategori: map['kategori'],
        lokasiText: map['lokasi_text'],
        latitude: map['latitude'] != null ? map['latitude'] as double : null,
        longitude: map['longitude'] != null ? map['longitude'] as double : null,
        foto: map['foto'],
        pertanyaanVerifikasi: map['pertanyaan_verifikasi'],
        jawabanVerifikasi: map['jawaban_verifikasi'],
        dibuatPada: map['dibuat_pada'],
      );
}
