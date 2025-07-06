import 'dart:convert';

class UpdateResModel {
    final int? status;
    final String? message;

    UpdateResModel({
        this.status,
        this.message,
    });

    factory UpdateResModel.fromJson(String str) => UpdateResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UpdateResModel.fromMap(Map<String, dynamic> json) => UpdateResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
