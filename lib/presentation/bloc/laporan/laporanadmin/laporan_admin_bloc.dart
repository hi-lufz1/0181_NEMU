import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_admin_repository.dart';

part 'laporan_admin_event.dart';
part 'laporan_admin_state.dart';

class LaporanAdminBloc extends Bloc<LaporanAdminEvent, LaporanAdminState> {
  final LaporanAdminRepository repository;

  LaporanAdminBloc({required this.repository}) : super(LaporanAdminInitial()) {
    on<LaporanAdminRequested>(_onGetAll);
    on<LaporanAdminFiltered>(_onFiltered);
  }

  Future<void> _onGetAll(
    LaporanAdminRequested event,
    Emitter<LaporanAdminState> emit,
  ) async {
    emit(LaporanAdminLoading());

    final res = await repository.getAllAdmin();

    if (res.status == 200) {
      emit(LaporanAdminSuccess(resModel: res));
    } else {
      emit(LaporanAdminFailure(resModel: res));
    }
  }

  Future<void> _onFiltered(
    LaporanAdminFiltered event,
    Emitter<LaporanAdminState> emit,
  ) async {
    emit(LaporanAdminLoading());

    final res = await repository.filterAdmin(event.filter);

    if (res.status == 200) {
      emit(LaporanAdminSuccess(resModel: res));
    } else {
      emit(LaporanAdminFailure(resModel: res));
    }
  }
}
