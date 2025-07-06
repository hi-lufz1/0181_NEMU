import 'dart:convert';

class DeleteAdminReqModel {
    final String? catatanAdmin;

    DeleteAdminReqModel({
        this.catatanAdmin,
    });

    factory DeleteAdminReqModel.fromJson(String str) => DeleteAdminReqModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DeleteAdminReqModel.fromMap(Map<String, dynamic> json) => DeleteAdminReqModel(
        catatanAdmin: json["catatan_admin"],
    );

    Map<String, dynamic> toMap() => {
        "catatan_admin": catatanAdmin,
    };
}
