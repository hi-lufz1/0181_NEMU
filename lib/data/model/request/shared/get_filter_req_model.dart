class GetFilterReqModel {
  final String? status;
  final String? lokasi;
  final String? kategori;
  final String? tipe;
  final String? search;

  GetFilterReqModel({
    this.status,
    this.lokasi,
    this.kategori,
    this.tipe,
    this.search,
  });

  /// Konversi ke query params
  Map<String, String> toQueryParameters() {
    final Map<String, String> query = {};

    if (status != null && status!.isNotEmpty) query['status'] = status!;
    if (lokasi != null && lokasi!.isNotEmpty) query['lokasi'] = lokasi!;
    if (kategori != null && kategori!.isNotEmpty) query['kategori'] = kategori!;
    if (tipe != null && tipe!.isNotEmpty) query['tipe'] = tipe!;
    if (search != null && search!.isNotEmpty) query['search'] = search!;

    return query;
  }
}
