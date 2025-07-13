import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nemu_app/data/model/response/admin/stat_res_model.dart';
import 'package:nemu_app/core/utils/json_helper.dart';
import 'package:nemu_app/services/service_http_client.dart';

class StatistikRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<StatResModel> getStatistikAdmin() async {
    try {
      final http.Response res = await _httpClient.getWithToken('statistik/admin');

      final jsonMap = parseJsonSafe(res.body);
      return StatResModel.fromMap(jsonMap);
    } catch (e) {
      return StatResModel(
        status: 500,
        message: 'Gagal memuat statistik',
      );
    }
  }
}
