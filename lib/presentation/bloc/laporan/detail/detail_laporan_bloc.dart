import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/core/utils/token_service.dart';
import 'package:nemu_app/data/model/response/shared/getdetail_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_repository.dart';

part 'detail_laporan_event.dart';
part 'detail_laporan_state.dart';

class DetailLaporanBloc extends Bloc<DetailLaporanEvent, DetailLaporanState> {
  final LaporanRepository laporanRepository;

  DetailLaporanBloc({required this.laporanRepository})
    : super(DetailLaporanInitial()) {
    on<DetailLaporanRequested>(_onDetailRequested);
  }

  Future<void> _onDetailRequested(
  DetailLaporanRequested event,
  Emitter<DetailLaporanState> emit,
) async {
  emit(DetailLaporanLoading());

  final res = await laporanRepository.getById(event.id);

  if (res.status == 200 && res.data != null) {
    final currentUserId = await TokenService.getCurrentUserId();
    final role = await TokenService.getCurrentUserRole();

    final isMine = res.data!.userId == currentUserId;
    final isAdmin = role == "admin";

    emit(DetailLaporanSuccess(
      resModel: res,
      isLaporanSaya: isMine,
      isAdmin: isAdmin,
    ));
  } else {
    emit(DetailLaporanFailure(resModel: res));
  }
}

}
