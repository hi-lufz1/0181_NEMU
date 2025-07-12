import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getCurrentUserId() async {
    final token = await _storage.read(key: 'authToken');
    if (token == null) return null;

    try {
      final decoded = Jwt.parseJwt(token);
      return decoded['id']?.toString();
    } catch (_) {
      return null;
    }
  }
}
