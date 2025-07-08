import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/shared/update_req_model.dart';
import 'package:nemu_app/data/model/response/shared/update_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';

part 'update_laporan_event.dart';
part 'update_laporan_state.dart';

class UpdateLaporanBloc extends Bloc<UpdateLaporanEvent, UpdateLaporanState> {
  final LaporanRepository laporanRepository;

  UpdateLaporanBloc({required this.laporanRepository}) : super(UpdateLaporanInitial()) {
    on<UpdateLaporanSubmitted>(_onUpdateLaporanSubmitted);
  }

  Future<void> _onUpdateLaporanSubmitted(
    UpdateLaporanSubmitted event,
    Emitter<UpdateLaporanState> emit,
  ) async {
    emit(UpdateLaporanLoading());

    final res = await laporanRepository.updateLaporan(event.id, event.reqModel);

    if (res.status == 200) {
      emit(UpdateLaporanSuccess(resModel: res));
    } else {
      emit(UpdateLaporanFailure(resModel: res));
    }
  }
}
