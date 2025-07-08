import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/shared/add_laporan_req_model.dart';
import 'package:nemu_app/data/model/response/shared/add_laporan_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';

part 'add_laporan_event.dart';
part 'add_laporan_state.dart';

class AddLaporanBloc extends Bloc<AddLaporanEvent, AddLaporanState> {
  final LaporanRepository laporanRepository;

  AddLaporanBloc({required this.laporanRepository})
    : super(AddLaporanInitial()) {
    on<AddLaporanSubmitted>(_onAddLaporanSubmitted);
  }

  Future<void> _onAddLaporanSubmitted(
    AddLaporanSubmitted event,
    Emitter<AddLaporanState> emit,
  ) async {
    emit(AddLaporanLoading());

    final res = await laporanRepository.createLaporan(event.reqModel);

    if (res.status == 200 || res.status == 201) {
      emit(AddLaporanSuccess(resModel: res));
    } else {
      emit(AddLaporanFailure(resModel: res));
    }
  }
}
