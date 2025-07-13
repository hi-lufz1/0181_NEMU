import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';

class PDFExportHelper {
  // ✅ Format Tanggal Lokal
  static String _formatTanggal(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "-";
    final date = DateTime.tryParse(rawDate);
    if (date == null) return "-";
    return DateFormat("d/M/y, HH.mm.ss", "id_ID").format(date.toLocal());
  }

  // ✅ Export 1 Laporan (untuk detail page user/admin)
  static Future<void> exportSingleLaporan(Data laporan) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                "📄 Detail Laporan",
                style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 16),
            _item("📦 Nama Barang", laporan.namaBarang),
            _item("📌 Tipe", laporan.tipe),
            _item("🏷️ Kategori", laporan.kategori),
            _item("📝 Deskripsi", laporan.deskripsi),
            _item(
              "📍 Lokasi",
              "${laporan.lokasiText ?? '-'} (${laporan.latitude ?? '-'}, ${laporan.longitude ?? '-'})",
            ),
            _item("🔖 Status", laporan.status),
            _item(
              "🗓️ Tanggal",
              laporan.dibuatPada != null
                  ? DateFormat("d/M/y, HH.mm.ss", "id_ID").format(laporan.dibuatPada!.toLocal())
                  : "-",
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // ✅ Export Banyak Laporan (untuk admin page)
  static Future<void> exportAllLaporan(List<Data> laporanList) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Center(
            child: pw.Text(
              "📋 Daftar Semua Laporan",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 16),
          ...laporanList.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final laporan = entry.value;

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  color: PdfColors.grey300,
                  child: pw.Text("🗂️ Laporan $index", style: const pw.TextStyle(fontSize: 14)),
                ),
                pw.SizedBox(height: 8),
                _item("📦 Nama Barang", laporan.namaBarang),
                _item("📌 Tipe", laporan.tipe),
                _item("🏷️ Kategori", laporan.kategori),
                _item("📝 Deskripsi", laporan.deskripsi),
                _item(
                  "📍 Lokasi",
                  "${laporan.lokasiText ?? '-'} (${laporan.latitude ?? '-'}, ${laporan.longitude ?? '-'})",
                ),
                _item("🔖 Status", laporan.status),
                _item(
                  "🗓️ Tanggal",
                  laporan.dibuatPada != null
                      ? DateFormat("d/M/y, HH.mm.ss", "id_ID").format(laporan.dibuatPada!.toLocal())
                      : "-",
                ),
                pw.Divider(),
              ],
            );
          }).toList(),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // 🔧 Widget Bantu (Label & Isi)
  static pw.Widget _item(String label, String? value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Text(
        "$label: ${value ?? '-'}",
        style: const pw.TextStyle(fontSize: 12),
      ),
    );
  }
}
