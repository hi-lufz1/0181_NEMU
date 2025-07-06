import 'dart:convert';

class LoginReqModel {
    final String? email;
    final String? password;

    LoginReqModel({
        this.email,
        this.password,
    });

    factory LoginReqModel.fromJson(String str) => LoginReqModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginReqModel.fromMap(Map<String, dynamic> json) => LoginReqModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
    };
}
