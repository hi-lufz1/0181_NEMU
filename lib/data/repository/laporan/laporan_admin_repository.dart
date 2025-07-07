
import 'package:http/http.dart' as http;
import 'package:nemu_app/core/utils/json_helper.dart';
import 'package:nemu_app/data/model/request/admin/delete_admin_req_model.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/data/model/response/umum/delete_res_model.dart';
import 'package:nemu_app/services/service_http_client.dart';


class LaporanAdminRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();
  
  /// Filter laporan admin
  Future<GetallResModel> filterAdmin(GetFilterReqModel req) async {
    try {
      final query = req.toQueryParameters();
      final uri = Uri.parse('${_httpClient.baseUrl}laporan/admin/filter').replace(queryParameters: query);
      final headers = await _httpClient.getHeaders(withToken: true);

      final res = await http.get(uri, headers: headers);
      return GetallResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal memfilter laporan admin: $e');
    }
  }

  /// Ambil semua laporan untuk admin (tanpa filter)
  Future<GetallResModel> getAllAdmin() async {
    try {
      final http.Response res = await _httpClient.get('laporan/admin');
      return GetallResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal mengambil semua laporan admin: $e');
    }
  }

  
 Future<DeleteResModel> deleteLaporanByAdmin({
  required String id,
  required DeleteAdminReqModel deleteReq,
}) async {
  try {
    final body = deleteReq.toMap();  // <-- ini Map<String, dynamic>

    final response = await _httpClient.putWithToken(
      'laporan/del/admin/$id',
      body,
    );

    final jsonBody = parseJsonSafe(response.body);

    return DeleteResModel.fromMap(jsonBody);
  } catch (e) {
    return DeleteResModel(
      status: 500,
      message: 'Terjadi kesalahan saat menghapus laporan oleh admin. Silakan coba lagi.',
    );
  }
}

}
