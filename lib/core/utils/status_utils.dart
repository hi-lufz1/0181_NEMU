// lib/core/utils/status_utils.dart

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

/// (map<value_backend, label_UI>)
Map<String, String> getStatusFilterOptions() {
  return {
    'aktif': 'Aktif',
    'diklaim': 'Sudah Diklaim',
    'selesai': 'Selesai',
    'dihapus': 'Dihapus oleh Admin',
    'dihapus_sendiri': 'Dihapus oleh Pengguna',
  };
}
