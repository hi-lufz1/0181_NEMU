import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/response/umum/delete_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';

part 'delete_laporan_event.dart';
part 'delete_laporan_state.dart';

class DeleteLaporanBloc extends Bloc<DeleteLaporanEvent, DeleteLaporanState> {
  final LaporanRepository laporanRepository;

  DeleteLaporanBloc({required this.laporanRepository}) : super(DeleteLaporanInitial()) {
    on<DeleteLaporanSubmitted>(_onDeleteLaporanSubmitted);
  }

  Future<void> _onDeleteLaporanSubmitted(
    DeleteLaporanSubmitted event,
    Emitter<DeleteLaporanState> emit,
  ) async {
    emit(DeleteLaporanLoading());

    final res = await laporanRepository.deleteLaporanByUser(event.id);

    if (res.status == 200) {
      emit(DeleteLaporanSuccess(resModel: res));
    } else {
      emit(DeleteLaporanFailure(resModel: res));
    }
  }
}
