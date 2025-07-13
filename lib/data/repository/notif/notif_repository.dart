import 'package:http/http.dart' as http;
import 'package:nemu_app/data/model/response/umum/notif_res_model.dart';
import 'package:nemu_app/services/service_http_client.dart';

class NotifRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();

  Future<NotifResModel> getNotifikasiUser() async {
    try {
      final res = await _httpClient.getWithToken('notif');
      return NotifResModel.fromJson(res.body);
    } catch (e) {
      return NotifResModel(
        status: 500,
        message: 'Gagal mengambil notifikasi.',
        data: [],
      );
    }
  }

  Future<NotifResModel> tandaiSudahDibaca(String id) async {
  try {
    final res = await _httpClient.putWithToken(
      'notif/$id/read',
      {},
    );
    return NotifResModel.fromJson(res.body); 
  } catch (e) {
    return NotifResModel(
      status: 500,
      message: 'Gagal menandai notifikasi.',
      data: [], 
    );
  }
}

}
