import 'dart:convert';

class LoginResModel {
    final int? status;
    final String? message;
    final String? token;
    final User? user;

    LoginResModel({
        this.status,
        this.message,
        this.token,
        this.user,
    });

    factory LoginResModel.fromJson(String str) => LoginResModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResModel.fromMap(Map<String, dynamic> json) => LoginResModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toMap(),
    };
}

class User {
    final String? id;
    final String? nama;
    final String? role;
    final String? kontakWa;

    User({
        this.id,
        this.nama,
        this.role,
        this.kontakWa,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        role: json["role"],
        kontakWa: json["kontak_wa"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "role": role,
        "kontak_wa": kontakWa,
    };
}
