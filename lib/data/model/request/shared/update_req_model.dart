import 'dart:convert';

import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';

class UpdateReqModel {
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
  final String? status;

  UpdateReqModel({
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
    this.status,
  });

  factory UpdateReqModel.fromJson(String str) =>
      UpdateReqModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateReqModel.fromMap(Map<String, dynamic> json) => UpdateReqModel(
    tipe: json["tipe"],
    namaBarang: json["nama_barang"],
    deskripsi: json["deskripsi"],
    kategori: json["kategori"],
    lokasiText: json["lokasi_text"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    foto: json["foto"],
    pertanyaanVerifikasi: json["pertanyaan_verifikasi"],
    jawabanVerifikasi: json["jawaban_verifikasi"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "tipe": tipe,
    "nama_barang": namaBarang,
    "deskripsi": deskripsi,
    "kategori": kategori,
    "lokasi_text": lokasiText,
    "latitude": latitude,
    "longitude": longitude,
    "foto": foto,
    "pertanyaan_verifikasi": pertanyaanVerifikasi,
    "jawaban_verifikasi": jawabanVerifikasi,
    "status": status,
  };
    factory UpdateReqModel.fromAdd(AddLaporanReqModel model) {
    return UpdateReqModel(
      tipe: model.tipe,
      namaBarang: model.namaBarang,
      deskripsi: model.deskripsi,
      kategori: model.kategori,
      lokasiText: model.lokasiText,
      latitude: model.latitude,
      longitude: model.longitude,
      foto: model.foto,
      pertanyaanVerifikasi: model.pertanyaanVerifikasi,
      jawabanVerifikasi: model.jawabanVerifikasi,
    );
  }
}

