import 'package:nemu_app/data/model/request/umum/klaim_req_model.dart';
import 'package:nemu_app/data/model/response/umum/klaim_res_model.dart';
import 'package:nemu_app/core/utils/json_helper.dart';
import 'package:nemu_app/services/service_http_client.dart';

class KlaimRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();

  Future<KlaimResModel> buatKlaim(String laporanId, KlaimReqModel req) async {
    try {
      final response = await _httpClient.postWithToken(
        'klaim/$laporanId',
        req.toMap(),
      );

      final jsonBody = parseJsonSafe(response.body);
      return KlaimResModel.fromMap(jsonBody);
    } catch (e) {
      return KlaimResModel(
        status: 500,
        message: 'Gagal mengirim klaim. Silakan coba lagi.',
        klaimStatus: 'gagal',
        redirectToWhatsapp: false,
      );
    }
  }
}
