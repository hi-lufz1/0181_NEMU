import 'dart:convert';

class RegisterResModel {
    final int? status;
    final String? message;

    RegisterResModel({
        this.status,
        this.message,
    });

    factory RegisterResModel.fromJson(String str) => RegisterResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterResModel.fromMap(Map<String, dynamic> json) => RegisterResModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
