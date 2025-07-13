import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/form/form_laporan_state.dart';

class FormLaporanCubit extends Cubit<FormLaporanState> {
  FormLaporanCubit() : super(const FormLaporanState());

  void setNamaBarang(String val) => emit(state.copyWith(namaBarang: val));
  void setDeskripsi(String val) => emit(state.copyWith(deskripsi: val));
  void setLokasiText(String val) => emit(state.copyWith(lokasiText: val));
  void setTipe(String? val) => emit(state.copyWith(tipe: val));
  void setKategori(String? val) => emit(state.copyWith(kategori: val));
  void setPertanyaan(String val) =>
      emit(state.copyWith(pertanyaanVerifikasi: val));
  void setJawaban(String val) => emit(state.copyWith(jawabanVerifikasi: val));

  void setFromDraft(LaporanDrafModel draf) {
    emit(
      FormLaporanState(
        namaBarang: draf.namaBarang ?? '',
        deskripsi: draf.deskripsi ?? '',
        lokasiText: draf.lokasiText ?? '',
        tipe: draf.tipe,
        kategori: draf.kategori,
        pertanyaanVerifikasi: draf.pertanyaanVerifikasi ?? '',
        jawabanVerifikasi: draf.jawabanVerifikasi ?? '',
      ),
    );
  }

  void setLokasi(String address, LatLng latlng) {
    emit(
      state.copyWith(
        lokasiText: address,
        lokasiAddress: address,
        lokasiLatLng: latlng,
      ),
    );
  }

  void restoreLokasi() {
    if (state.lokasiAddress != null && state.lokasiLatLng != null) {
      emit(state.copyWith(lokasiText: state.lokasiAddress));
    }
  }

  void setInitialFromDetail(Data data) {
    emit(
      FormLaporanState(
        namaBarang: data.namaBarang ?? '',
        deskripsi: data.deskripsi ?? '',
        lokasiText: data.lokasiText ?? '',
        tipe: data.tipe,
        kategori: data.kategori,
        pertanyaanVerifikasi: data.pertanyaanVerifikasi ?? '',
        jawabanVerifikasi: data.jawabanVerifikasi ?? '',
      ),
    );
  }

  AddLaporanReqModel toRequestModel({
    String? base64Foto,
    double? latitude,
    double? longitude,
  }) {
    return AddLaporanReqModel(
      tipe: state.tipe,
      namaBarang: state.namaBarang,
      deskripsi: state.deskripsi,
      kategori: state.kategori,
      lokasiText: state.lokasiText,
      latitude: latitude,
      longitude: longitude,
      foto: base64Foto,
      pertanyaanVerifikasi:
          state.tipe == 'Ditemukan' ? state.pertanyaanVerifikasi : null,
      jawabanVerifikasi:
          state.tipe == 'Ditemukan' ? state.jawabanVerifikasi : null,
    );
  }

  String? _draftId;
  String? get draftId => _draftId;

  void setDraftId(String? id) {
    _draftId = id;
  }

  void clear() => emit(const FormLaporanState());
}
