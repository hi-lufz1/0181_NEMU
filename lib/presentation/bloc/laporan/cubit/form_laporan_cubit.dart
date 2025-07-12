import 'package:bloc/bloc.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/cubit/form_laporan_state.dart';

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

  AddLaporanReqModel toRequestModel({
    required String? base64Foto,
    required double? latitude,
    required double? longitude,
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
