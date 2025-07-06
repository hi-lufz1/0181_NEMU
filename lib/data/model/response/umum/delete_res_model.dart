import 'dart:convert';

class DeleteResModel {
    final int? status;
    final String? message;

    DeleteResModel({
        this.status,
        this.message,
    });

    factory DeleteResModel.fromJson(String str) => DeleteResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DeleteResModel.fromMap(Map<String, dynamic> json) => DeleteResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
