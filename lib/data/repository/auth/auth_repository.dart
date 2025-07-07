import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nemu_app/core/utils/json_helper.dart';
import 'package:nemu_app/data/model/request/auth/login_req_model.dart';
import 'package:nemu_app/data/model/request/auth/register_req_model.dart';
import 'package:nemu_app/data/model/response/auth/login_res_model.dart';
import 'package:nemu_app/data/model/response/auth/register_res_model.dart';
import 'package:nemu_app/services/service_http_client.dart';

class AuthRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Login
  Future<LoginResModel> login(LoginReqModel request) async {
    try {
      final http.Response res = await _httpClient.post(
        'auth/login',
        request.toMap(),
      );

      final jsonMap = parseJsonSafe(res.body);
      final loginRes = LoginResModel.fromMap(jsonMap);

      if (res.statusCode == 200 && loginRes.token != null) {
        await _secureStorage.write(key: 'authToken', value: loginRes.token);
      }

      return loginRes;
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  /// Register
  Future<RegisterResModel> register(RegisterReqModel request) async {
    try {
      final http.Response res = await _httpClient.post(
        'auth/register',
        request.toMap(),
      );

      final jsonMap = parseJsonSafe(res.body);
      final registerRes = RegisterResModel.fromMap(jsonMap);

      return registerRes;
    } catch (e) {
      throw Exception('Registrasi gagal: $e');
    }
  }

  /// Logout
  Future<void> logout() async {
    await _secureStorage.delete(key: 'authToken');
  }

  /// Cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'authToken');
    return token != null;
  }

  /// Ambil token untuk debugging atau pengiriman manual
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'authToken');
  }
}
