import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/core/utils/status_utils.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';

class DetailLaporanContent extends StatelessWidget {
  final Data data;

  const DetailLaporanContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime? dateTime) {
      if (dateTime == null) return "-";
      return DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(dateTime);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.namaBarang ?? '-',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Chip(
                label: Text(data.tipe?.toUpperCase() ?? '-'),
                backgroundColor:
                    data.tipe == 'hilang' ? Colors.black : AppColors.primary,
                labelStyle: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(data.kategori ?? '-'),
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.w600)),
          Text(data.deskripsi ?? '-', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text("Status:", style: TextStyle(fontWeight: FontWeight.w600)),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getStatusBackgroundColor(data.status),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              getDisplayStatus(data.status),
              style: TextStyle(
                fontSize: 14,
                color: getStatusTextColor(data.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text("Nama Pelapor:", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/splash.png'),
              ),
              const SizedBox(width: 8),
              Text(data.nama ?? '-', style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Text("Dibuat pada:", style: TextStyle(fontWeight: FontWeight.w600)),
          Text(formatDate(data.dibuatPada), style: TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text("Lokasi:", style: TextStyle(fontWeight: FontWeight.w600)),
          Text(data.lokasiText ?? '-', style: TextStyle(fontSize: 14)),
          if (data.catatanAdmin != null && data.catatanAdmin!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              "Catatan Admin:",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
            ),
            Text(data.catatanAdmin!, style: TextStyle(fontSize: 14)),
          ],
          const SizedBox(height: 16),
          if (data.latitude != null && data.longitude != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(data.latitude!, data.longitude!),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("lokasi"),
                      position: LatLng(data.latitude!, data.longitude!),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  liteModeEnabled: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
