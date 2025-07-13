class GetFilterReqModel {
  final String? status;
  final String? lokasi;
  final String? kategori;
  final String? tipe;
  final String? search;
  final DateTime? tanggalAwal;
  final DateTime? tanggalAkhir;

  GetFilterReqModel({
    this.status,
    this.lokasi,
    this.kategori,
    this.tipe,
    this.search,
    this.tanggalAwal,
    this.tanggalAkhir,
  });

  /// Konversi ke query params
  Map<String, String> toQueryParameters() {
    final Map<String, String> query = {};

    if (status != null && status!.isNotEmpty) query['status'] = status!;
    if (lokasi != null && lokasi!.isNotEmpty) query['lokasi'] = lokasi!;
    if (kategori != null && kategori!.isNotEmpty) query['kategori'] = kategori!;
    if (tipe != null && tipe!.isNotEmpty) query['tipe'] = tipe!;
    if (search != null && search!.isNotEmpty) query['search'] = search!;
    if (tanggalAwal != null) {
      query['tanggal_awal'] = _formatDate(tanggalAwal!);
    }
    if (tanggalAkhir != null) {
      query['tanggal_akhir'] = _formatDate(tanggalAkhir!);
    }

    return query;
  }
  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
