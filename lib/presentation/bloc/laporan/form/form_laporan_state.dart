// lib/presentation/bloc/laporan/form/form_laporan_state.dart
import 'package:equatable/equatable.dart';

class FormLaporanState extends Equatable {
  final String namaBarang;
  final String deskripsi;
  final String lokasiText;
  final String? tipe;
  final String? kategori;
  final String pertanyaanVerifikasi;
  final String jawabanVerifikasi;

  const FormLaporanState({
    this.namaBarang = '',
    this.deskripsi = '',
    this.lokasiText = '',
    this.tipe,
    this.kategori,
    this.pertanyaanVerifikasi = '',
    this.jawabanVerifikasi = '',
  });

  FormLaporanState copyWith({
    String? namaBarang,
    String? deskripsi,
    String? lokasiText,
    String? tipe,
    String? kategori,
    String? pertanyaanVerifikasi,
    String? jawabanVerifikasi,
  }) {
    return FormLaporanState(
      namaBarang: namaBarang ?? this.namaBarang,
      deskripsi: deskripsi ?? this.deskripsi,
      lokasiText: lokasiText ?? this.lokasiText,
      tipe: tipe ?? this.tipe,
      kategori: kategori ?? this.kategori,
      pertanyaanVerifikasi:
          pertanyaanVerifikasi ?? this.pertanyaanVerifikasi,
      jawabanVerifikasi: jawabanVerifikasi ?? this.jawabanVerifikasi,
    );
  }

  @override
  List<Object?> get props => [
        namaBarang,
        deskripsi,
        lokasiText,
        tipe,
        kategori,
        pertanyaanVerifikasi,
        jawabanVerifikasi,
      ];
}
