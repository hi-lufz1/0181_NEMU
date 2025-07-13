import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/constants/kategori_list.dart';

class SearchFilterSheet extends StatelessWidget {
  final String? selectedTipe;
  final String? selectedKategori;
  final String? selectedLokasi;
  final DateTime? tanggalAwal;
  final DateTime? tanggalAkhir;
  final String? selectedStatus;

  final Function(String?)? onStatusChanged;
  final Function(String?) onTipeChanged;
  final Function(String?) onKategoriChanged;
  final Function(String?) onLokasiChanged;
  final Function(DateTime?) onTanggalAwalChanged;
  final Function(DateTime?) onTanggalAkhirChanged;
  final VoidCallback onSubmit;

  const SearchFilterSheet({
    super.key,
    required this.selectedTipe,
    required this.selectedKategori,
    required this.selectedLokasi,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    this.selectedStatus,
    this.onStatusChanged,
    required this.onTipeChanged,
    required this.onKategoriChanged,
    required this.onLokasiChanged,
    required this.onTanggalAwalChanged,
    required this.onTanggalAkhirChanged,
    required this.onSubmit,
    re,
  });

  @override
  Widget build(BuildContext context) {
    final rootContext = context;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filter Laporan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (onStatusChanged != null) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: const InputDecoration(labelText: "Status"),
                  items: const [
                    DropdownMenuItem(value: null, child: Text("Semua")),
                    DropdownMenuItem(value: "aktif", child: Text("Aktif")),
                    DropdownMenuItem(value: "selesai", child: Text("Selesai")),
                    DropdownMenuItem(value: "ditolak", child: Text("Ditolak")),
                  ],
                  onChanged:
                      (val) => setModalState(() => onStatusChanged!(val)),
                ),
              ],

              // Lokasi
              TextFormField(
                initialValue: selectedLokasi,
                decoration: const InputDecoration(labelText: "Lokasi"),
                onChanged: (val) => setModalState(() => onLokasiChanged(val)),
              ),

              const SizedBox(height: 16),

              // Kategori
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: const InputDecoration(labelText: "Kategori"),
                items:
                    KategoriList.all
                        .map(
                          (k) => DropdownMenuItem(
                            value: k.nama,
                            child: Text(k.nama),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setModalState(() => onKategoriChanged(val)),
              ),

              const SizedBox(height: 16),

              // Tipe
              DropdownButtonFormField<String>(
                value: selectedTipe,
                decoration: const InputDecoration(labelText: "Tipe"),
                items: const [
                  DropdownMenuItem(value: 'hilang', child: Text('Hilang')),
                  DropdownMenuItem(
                    value: 'ditemukan',
                    child: Text('Ditemukan'),
                  ),
                ],
                onChanged: (val) => setModalState(() => onTipeChanged(val)),
              ),

              const SizedBox(height: 16),

              // Tanggal
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: "Tanggal Awal",
                      date: tanggalAwal,
                      onPick:
                          (date) =>
                              setModalState(() => onTanggalAwalChanged(date)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DateField(
                      label: "Tanggal Akhir",
                      date: tanggalAkhir,
                      onPick:
                          (date) =>
                              setModalState(() => onTanggalAkhirChanged(date)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              CustomButton(
                label: "Terapkan Filter",
                onPressed: () {
                  if (tanggalAwal != null &&
                      tanggalAkhir != null &&
                      tanggalAkhir!.isBefore(tanggalAwal!)) {
                    ScaffoldMessenger.of(rootContext).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Tanggal akhir tidak boleh sebelum tanggal awal.",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  Navigator.pop(context);
                  onSubmit();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final Function(DateTime?) onPick;

  const _DateField({
    required this.label,
    required this.date,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700])),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) onPick(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date != null
                  ? DateFormat('dd MMMM yyyy', 'id_ID').format(date!)
                  : "Pilih tanggal",
            ),
          ),
        ),
      ],
    );
  }
}
