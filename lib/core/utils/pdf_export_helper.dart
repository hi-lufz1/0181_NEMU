import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';

class PDFExportHelper {
  // Format tanggal lokal
  static String _formatTanggal(DateTime? date) {
    if (date == null) return "-";
    return DateFormat("d/M/y, HH.mm.ss", "id_ID").format(date.toLocal());
  }

  // Header untuk setiap halaman (logo + teks + divider)
  static Future<pw.Widget> _buildHeader() async {
    final logoImage = await imageFromAssetBundle("assets/images/logo.png");
    final logoText = await imageFromAssetBundle("assets/images/logotext.png");

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Image(logoImage, width: 40, height: 40),
            pw.SizedBox(width: 8),
            pw.Image(logoText, height: 25),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Divider(),
        pw.SizedBox(height: 12),
      ],
    );
  }

  // Komponen field
  static pw.Widget _item(String label, String? value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Text(
        "$label: ${value ?? '-'}",
        style: const pw.TextStyle(fontSize: 12),
      ),
    );
  }

  // Export 1 laporan (detail)
  static Future<void> exportSingleLaporan(Data laporan) async {
    final pdf = pw.Document();
    final header = await _buildHeader();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            header,
            pw.Text(
              "Detail Laporan",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),
            _item("Nama Barang", laporan.namaBarang),
            _item("Tipe", laporan.tipe),
            _item("Kategori", laporan.kategori),
            _item("Deskripsi", laporan.deskripsi),
            _item(
              "Lokasi",
              "${laporan.lokasiText ?? '-'} (${laporan.latitude ?? '-'}, ${laporan.longitude ?? '-'})",
            ),
            _item("Status", laporan.status),
            _item("Tanggal", _formatTanggal(laporan.dibuatPada)),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // Export semua laporan (admin)
  static Future<void> exportAllLaporan(List<Datum> laporanList) async {
    final pdf = pw.Document();
    final logoImage = await imageFromAssetBundle("assets/images/logo.png");
    final logoText = await imageFromAssetBundle("assets/images/logotext.png");

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        // Header muncul di setiap halaman
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Image(logoImage, width: 40, height: 40),
                pw.SizedBox(width: 8),
                pw.Image(logoText, height: 25),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 12),
          ],
        ),
        build: (context) => [
          pw.Text(
            "Daftar Semua Laporan",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          ...laporanList.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final laporan = entry.value;

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  color: PdfColors.grey300,
                  child: pw.Text(
                    "Laporan $index",
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ),
                pw.SizedBox(height: 6),
                _item("Nama Barang", laporan.namaBarang),
                _item("Tipe", laporan.tipe),
                _item("Kategori", laporan.kategori),
                _item("Deskripsi", laporan.deskripsi),
                _item(
                  "Lokasi",
                  "${laporan.lokasiText ?? '-'} (${laporan.latitude ?? '-'}, ${laporan.longitude ?? '-'})",
                ),
                _item("Status", laporan.status),
                _item("Tanggal", _formatTanggal(laporan.dibuatPada)),
                pw.Divider(),
              ],
            );
          }).toList(),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}
