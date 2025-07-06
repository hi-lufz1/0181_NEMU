import 'dart:convert';

class RegisterReqModel {
    final String? nama;
    final String? email;
    final String? password;
    final String? konfirmasiPassword;
    final String? kontakWa;

    RegisterReqModel({
        this.nama,
        this.email,
        this.password,
        this.konfirmasiPassword,
        this.kontakWa,
    });

    factory RegisterReqModel.fromJson(String str) => RegisterReqModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterReqModel.fromMap(Map<String, dynamic> json) => RegisterReqModel(
        nama: json["nama"],
        email: json["email"],
        password: json["password"],
        konfirmasiPassword: json["konfirmasi_password"],
        kontakWa: json["kontak_wa"],
    );

    Map<String, dynamic> toMap() => {
        "nama": nama,
        "email": email,
        "password": password,
        "konfirmasi_password": konfirmasiPassword,
        "kontak_wa": kontakWa,
    };
}
