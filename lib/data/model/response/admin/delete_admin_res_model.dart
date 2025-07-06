import 'dart:convert';

class DeleteAdminResModel {
    final int? status;
    final String? message;

    DeleteAdminResModel({
        this.status,
        this.message,
    });

    factory DeleteAdminResModel.fromJson(String str) => DeleteAdminResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DeleteAdminResModel.fromMap(Map<String, dynamic> json) => DeleteAdminResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
