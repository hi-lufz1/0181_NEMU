import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

String getDisplayStatus(String? status) {
  switch (status) {
    case 'aktif':
      return 'Aktif';
    case 'diklaim':
      return 'Sudah Diklaim';
    case 'selesai':
      return 'Selesai';
    case 'dihapus':
      return 'Dihapus oleh Admin';
    case 'dihapus_sendiri':
      return 'Dihapus oleh Pengguna';
    default:
      return status ?? '-';
  }
}

Map<String, String> getStatusFilterOptions() {
  return {
    'aktif': 'Aktif',
    'diklaim': 'Sudah Diklaim',
    'selesai': 'Selesai',
    'dihapus': 'Dihapus oleh Admin',
    'dihapus_sendiri': 'Dihapus oleh Pengguna',
  };
}

// Background color soft + harmonis dengan tema aplikasi
Color? getStatusBackgroundColor(String? status) {
  switch (status) {
    case 'aktif':
      return AppColors.primarylight;
    case 'diklaim':
      return const Color(0xFFFFF1E6); // peach soft
    case 'selesai':
      return const Color(0xFFE1F6F3); // mint soft
    case 'dihapus':
      return const Color(0xFFFFE8E6); // soft red
    case 'dihapus_sendiri':
      return const Color(0xFFF0F0F0); // soft grey
    default:
      return Colors.grey[200];
  }
}

// Text color yang kontras dan tetap konsisten
Color? getStatusTextColor(String? status) {
  switch (status) {
    case 'aktif':
      return AppColors.secondary;
    case 'diklaim':
      return const Color(0xFFB85C00); // deep orange
    case 'selesai':
      return AppColors.primary;
    case 'dihapus':
      return const Color(0xFFD32F2F); // red
    case 'dihapus_sendiri':
      return AppColors.greytext;
    default:
      return Colors.black87;
  }
}
