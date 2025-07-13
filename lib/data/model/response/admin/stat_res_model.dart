import 'dart:convert';

class StatResModel {
    final int? status;
    final String? message;
    final Data? data;

    StatResModel({
        this.status,
        this.message,
        this.data,
    });

    factory StatResModel.fromJson(String str) => StatResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StatResModel.fromMap(Map<String, dynamic> json) => StatResModel(
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
    final int? totalAktif;
    final int? totalDiklaim;
    final int? totalDihapusAdmin;
    final int? klaimBerhasil;
    final List<TopKategori>? topKategori;

    Data({
        this.totalAktif,
        this.totalDiklaim,
        this.totalDihapusAdmin,
        this.klaimBerhasil,
        this.topKategori,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalAktif: json["total_aktif"],
        totalDiklaim: json["total_diklaim"],
        totalDihapusAdmin: json["total_dihapus_admin"],
        klaimBerhasil: json["klaim_berhasil"],
        topKategori: json["top_kategori"] == null ? [] : List<TopKategori>.from(json["top_kategori"]!.map((x) => TopKategori.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total_aktif": totalAktif,
        "total_diklaim": totalDiklaim,
        "total_dihapus_admin": totalDihapusAdmin,
        "klaim_berhasil": klaimBerhasil,
        "top_kategori": topKategori == null ? [] : List<dynamic>.from(topKategori!.map((x) => x.toMap())),
    };
}

class TopKategori {
    final String? kategori;
    final int? jumlah;

    TopKategori({
        this.kategori,
        this.jumlah,
    });

    factory TopKategori.fromJson(String str) => TopKategori.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TopKategori.fromMap(Map<String, dynamic> json) => TopKategori(
        kategori: json["kategori"],
        jumlah: json["jumlah"],
    );

    Map<String, dynamic> toMap() => {
        "kategori": kategori,
        "jumlah": jumlah,
    };
}
