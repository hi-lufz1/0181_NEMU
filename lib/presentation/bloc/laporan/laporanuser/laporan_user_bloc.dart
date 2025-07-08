import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';

part 'laporan_user_event.dart';
part 'laporan_user_state.dart';

class LaporanUserBloc extends Bloc<LaporanUserEvent, LaporanUserState> {
  final LaporanRepository laporanRepository;

  LaporanUserBloc({required this.laporanRepository})
    : super(LaporanUserInitial()) {
    on<GetAllLaporanAktif>(_onGetAllAktif);
    on<GetLaporanSaya>(_onGetLaporanSaya);
    on<FilterLaporanAktif>(_onFilterLaporanUser);
  }

  Future<void> _onGetAllAktif(
    GetAllLaporanAktif event,
    Emitter<LaporanUserState> emit,
  ) async {
    emit(LaporanUserLoading());
    final res = await laporanRepository.getAllAktif();
    if (res.status == 200) {
      emit(LaporanUserSuccess(resModel: res));
    } else {
      emit(LaporanUserFailure(resModel: res));
    }
  }

  Future<void> _onGetLaporanSaya(
    GetLaporanSaya event,
    Emitter<LaporanUserState> emit,
  ) async {
    emit(LaporanUserLoading());
    final res = await laporanRepository.getLaporanSaya();
    if (res.status == 200) {
      emit(LaporanUserSuccess(resModel: res));
    } else {
      emit(LaporanUserFailure(resModel: res));
    }
  }

  Future<void> _onFilterLaporanUser(
    FilterLaporanAktif event,
    Emitter<LaporanUserState> emit,
  ) async {
    emit(LaporanUserLoading());
    final res = await laporanRepository.filterAktif(event.filter);
    if (res.status == 200) {
      emit(LaporanUserSuccess(resModel: res));
    } else {
      emit(LaporanUserFailure(resModel: res));
    }
  }
}
