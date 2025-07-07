import 'dart:convert';

Map<String, dynamic> parseJsonSafe(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    } else {
      // Bentuk JSON tidak sesuai ekspektasi
      return {
        'status': 500,
        'message': 'Terjadi kesalahan tak terduga. Coba lagi nanti.', // User message
        '_devMessage': 'Response JSON bukan Map<String, dynamic>',   // Dev log
      };
    }
  } catch (e) {
    return {
      'status': 500,
      'message': 'Terjadi gangguan pada server. Coba beberapa saat lagi.',
      '_devMessage': 'Gagal decode JSON: $e\nResponse: $body', // bisa dicetak ke console log
    };
  }
}
