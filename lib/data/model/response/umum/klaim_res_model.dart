import 'dart:convert';

class KlaimResModel {
    final int? status;
    final String? message;
    final String? klaimStatus;
    final bool? redirectToWhatsapp;

    KlaimResModel({
        this.status,
        this.message,
        this.klaimStatus,
        this.redirectToWhatsapp,
    });

    factory KlaimResModel.fromJson(String str) => KlaimResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory KlaimResModel.fromMap(Map<String, dynamic> json) => KlaimResModel(
        status: json["status"],
        message: json["message"],
        klaimStatus: json["klaimStatus"],
        redirectToWhatsapp: json["redirectToWhatsapp"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "klaimStatus": klaimStatus,
        "redirectToWhatsapp": redirectToWhatsapp,
    };
}
