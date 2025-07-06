import 'dart:convert';

class AddLaporanReqModel {
    final String? tipe;
    final String? namaBarang;
    final String? deskripsi;
    final String? kategori;
    final String? lokasiText;
    final double? latitude;
    final double? longitude;
    final String? foto;
    final dynamic pertanyaanVerifikasi;
    final dynamic jawabanVerifikasi;

    AddLaporanReqModel({
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
    });

    factory AddLaporanReqModel.fromJson(String str) => AddLaporanReqModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddLaporanReqModel.fromMap(Map<String, dynamic> json) => AddLaporanReqModel(
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
    };
}
