import 'dart:convert';

class NotifResModel {
    final int? status;
    final String? message;
    final List<Datum>? data;

    NotifResModel({
        this.status,
        this.message,
        this.data,
    });

    factory NotifResModel.fromJson(String str) => NotifResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NotifResModel.fromMap(Map<String, dynamic> json) => NotifResModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final String? id;
    final String? userId;
    final String? isi;
    final int? sudahDibaca;
    final DateTime? dibuatPada;
    final String? tipe;
    final String? terkaitId;
    final String? pengklaimId;
    final String? namaPengklaim;

    Datum({
        this.id,
        this.userId,
        this.isi,
        this.sudahDibaca,
        this.dibuatPada,
        this.tipe,
        this.terkaitId,
        this.pengklaimId,
        this.namaPengklaim,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        isi: json["isi"],
        sudahDibaca: json["sudah_dibaca"],
        dibuatPada: json["dibuat_pada"] == null ? null : DateTime.parse(json["dibuat_pada"]),
        tipe: json["tipe"],
        terkaitId: json["terkait_id"],
        pengklaimId: json["pengklaim_id"],
        namaPengklaim: json["nama_pengklaim"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "isi": isi,
        "sudah_dibaca": sudahDibaca,
        "dibuat_pada": dibuatPada?.toIso8601String(),
        "tipe": tipe,
        "terkait_id": terkaitId,
        "pengklaim_id": pengklaimId,
        "nama_pengklaim": namaPengklaim,
    };
}
