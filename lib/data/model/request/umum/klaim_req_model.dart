import 'dart:convert';

class KlaimReqModel {
    final String? jawabanUser;

    KlaimReqModel({
        this.jawabanUser,
    });

    factory KlaimReqModel.fromJson(String str) => KlaimReqModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory KlaimReqModel.fromMap(Map<String, dynamic> json) => KlaimReqModel(
        jawabanUser: json["jawaban_user"],
    );

    Map<String, dynamic> toMap() => {
        "jawaban_user": jawabanUser,
    };
}
