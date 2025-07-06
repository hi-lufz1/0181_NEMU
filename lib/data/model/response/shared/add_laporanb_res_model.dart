import 'dart:convert';

class AddLaporanResModel {
    final int? status;
    final String? message;

    AddLaporanResModel({
        this.status,
        this.message,
    });

    factory AddLaporanResModel.fromJson(String str) => AddLaporanResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddLaporanResModel.fromMap(Map<String, dynamic> json) => AddLaporanResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
