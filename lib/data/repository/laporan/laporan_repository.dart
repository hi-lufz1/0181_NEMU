import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nemu_app/core/utils/json_helper.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/request/shared/update_req_model.dart';
import 'package:nemu_app/data/model/response/shared/add_laporan_res_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/data/model/response/shared/update_res_model.dart';
import 'package:nemu_app/data/model/response/umum/delete_res_model.dart';
import 'package:nemu_app/services/service_http_client.dart';

class LaporanRepository {
  final ServiceHttpClient _httpClient = ServiceHttpClient();

  /// GET: Ambil semua laporan aktif (user)
  Future<GetallResModel> getAllAktif() async {
    try {
      final res = await _httpClient.getWithToken('laporan');
      return GetallResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal mengambil laporan aktif: $e');
    }
  }

  /// GET: Ambil laporan berdasarkan ID
  Future<GetdetailResModel> getById(String id) async {
    try {
      final res = await _httpClient.getWithToken('laporan/$id');
      return GetdetailResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal mengambil detail laporan: $e');
    }
  }

  /// GET: Ambil laporan milik user sendiri
  Future<GetallResModel> getLaporanSaya() async {
    try {
      final res = await _httpClient.getWithToken('laporan/saya');
      return GetallResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal mengambil laporan sendiri: $e');
    }
  }

  /// GET: Filter laporan aktif (user)
  Future<GetallResModel> filterAktif(GetFilterReqModel req) async {
    try {
      final query = req.toQueryParameters();
      final uri = Uri.parse(
        '${_httpClient.baseUrl}laporan/filter',
      ).replace(queryParameters: query);
      final headers = await _httpClient.getHeaders(withToken: true);

      final res = await http.get(uri, headers: headers);
      return GetallResModel.fromJson(res.body);
    } catch (e) {
      throw Exception('Gagal memfilter laporan aktif: $e');
    }
  }

  Future<AddLaporanResModel> createLaporan(AddLaporanReqModel req) async {
    try {
      final response = await _httpClient.postWithToken('laporan', req.toMap());

      final jsonBody = parseJsonSafe(response.body);
      return AddLaporanResModel.fromMap(jsonBody);
    } catch (e) {
      return AddLaporanResModel(
        status: 500,
        message: 'Gagal membuat laporan. Silakan coba lagi.',
      );
    }
  }

  Future<UpdateResModel> updateLaporan(String id, UpdateReqModel req) async {
    try {
      final response = await _httpClient.putWithToken(
        'laporan/$id',
        req.toMap(),
      );

      final jsonBody = parseJsonSafe(response.body);
      return UpdateResModel.fromMap(jsonBody);
    } catch (e) {
      return UpdateResModel(
        status: 500,
        message: 'Gagal memperbarui laporan. Silakan coba lagi.',
      );
    }
  }

  /// PUT: Hapus laporan oleh user (soft delete)
  Future<DeleteResModel> deleteLaporanByUser(String id) async {
    try {
      final response = await _httpClient.putWithToken('laporan/del/$id', {});
      final jsonBody = parseJsonSafe(response.body);
      return DeleteResModel.fromMap(jsonBody);
    } catch (e) {
      return DeleteResModel(
        status: 500,
        message: 'Terjadi kesalahan saat menghapus laporan. Silakan coba lagi.',
      );
    }
  }
}
