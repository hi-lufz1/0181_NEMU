import 'dart:convert';

class GetallResModel {
    final int? status;
    final List<Datum>? data;

    GetallResModel({
        this.status,
        this.data,
    });

    factory GetallResModel.fromJson(String str) => GetallResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetallResModel.fromMap(Map<String, dynamic> json) => GetallResModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final String? id;
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
    final String? catatanAdmin;
    final DateTime? dihapusPada;
    final DateTime? dibuatPada;

    Datum({
        this.id,
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

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
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
        dihapusPada: json["dihapus_pada"] == null ? null : DateTime.parse(json["dihapus_pada"]),
        dibuatPada: json["dibuat_pada"] == null ? null : DateTime.parse(json["dibuat_pada"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
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
        "dihapus_pada": dihapusPada?.toIso8601String(),
        "dibuat_pada": dibuatPada?.toIso8601String(),
    };
}
