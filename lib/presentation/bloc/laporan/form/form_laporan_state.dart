import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormLaporanState extends Equatable {
  final String namaBarang;
  final String deskripsi;
  final String lokasiText;
  final String? tipe;
  final String? kategori;
  final String pertanyaanVerifikasi;
  final String jawabanVerifikasi;

  final String? lokasiAddress; 
  final LatLng? lokasiLatLng; 

  const FormLaporanState({
    this.namaBarang = '',
    this.deskripsi = '',
    this.lokasiText = '',
    this.tipe,
    this.kategori,
    this.pertanyaanVerifikasi = '',
    this.jawabanVerifikasi = '',
    this.lokasiAddress,
    this.lokasiLatLng,
  });

  FormLaporanState copyWith({
    String? namaBarang,
    String? deskripsi,
    String? lokasiText,
    String? tipe,
    String? kategori,
    String? pertanyaanVerifikasi,
    String? jawabanVerifikasi,
    String? lokasiAddress,
    LatLng? lokasiLatLng,
  }) {
    return FormLaporanState(
      namaBarang: namaBarang ?? this.namaBarang,
      deskripsi: deskripsi ?? this.deskripsi,
      lokasiText: lokasiText ?? this.lokasiText,
      tipe: tipe ?? this.tipe,
      kategori: kategori ?? this.kategori,
      pertanyaanVerifikasi: pertanyaanVerifikasi ?? this.pertanyaanVerifikasi,
      jawabanVerifikasi: jawabanVerifikasi ?? this.jawabanVerifikasi,
      lokasiAddress: lokasiAddress ?? this.lokasiAddress,
      lokasiLatLng: lokasiLatLng ?? this.lokasiLatLng,
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
        lokasiAddress,
        lokasiLatLng,
      ];
}
