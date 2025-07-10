import 'dart:convert';

class GetdetailResModel {
    final int? status;
    final String? message;
    final Data? data;

    GetdetailResModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetdetailResModel.fromJson(String str) => GetdetailResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetdetailResModel.fromMap(Map<String, dynamic> json) => GetdetailResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    final String? id;
    final String? nama;
    final String? userId;
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
    final dynamic catatanAdmin;
    final dynamic dihapusPada;
    final DateTime? dibuatPada;

    Data({
        this.id,
        this.nama,
        this.userId,
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
        this.catatanAdmin,
        this.dihapusPada,
        this.dibuatPada,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
        userId: json["user_id"],
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
        catatanAdmin: json["catatan_admin"],
        dihapusPada: json["dihapus_pada"],
        dibuatPada: json["dibuat_pada"] == null ? null : DateTime.parse(json["dibuat_pada"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "user_id": userId,
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
        "catatan_admin": catatanAdmin,
        "dihapus_pada": dihapusPada,
        "dibuat_pada": dibuatPada?.toIso8601String(),
    };
}
