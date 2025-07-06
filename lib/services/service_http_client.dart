import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = "http://10.0.2.2:3000/api/";
  final secureStorage = FlutterSecureStorage();

  Future<Map<String, String>> _headers({bool withToken = false}) async {
    final token = await secureStorage.read(key: 'authToken');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (withToken && token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> getHeaders({bool withToken = false}) async {
    return await _headers(withToken: withToken);
  }

  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endPoint');
    final headers = await _headers();

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  Future<http.Response> get(String endPoint) async {
    final url = Uri.parse('$baseUrl$endPoint');
    final headers = await _headers(withToken: true);

    try {
      final response = await http.get(url, headers: headers);
      return response;
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  Future<http.Response> postWithToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse("$baseUrl$endPoint");
    final headers = await _headers(withToken: true);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST with token failed: $e");
    }
  }

  Future<http.Response> putWithToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }
}
