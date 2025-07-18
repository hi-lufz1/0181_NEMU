import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/response/umum/notif_res_model.dart';
import 'package:nemu_app/data/repository/notif/notif_repository.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final NotifRepository notifRepository;

  NotifBloc({required this.notifRepository}) : super(NotifInitial()) {
    on<LoadNotifikasi>(_onLoadNotifikasi);
    on<TandaiNotifSudahDibaca>(_onTandaiNotifSudahDibaca);
  }

  Future<void> _onLoadNotifikasi(
    LoadNotifikasi event,
    Emitter<NotifState> emit,
  ) async {
    emit(NotifLoading());

    final res = await notifRepository.getNotifikasiUser();

    if (res.status == 200) {
      emit(NotifSuccess(resModel: res));
    } else {
      emit(NotifFailure(resModel: res));
    }
  }

  Future<void> _onTandaiNotifSudahDibaca(
    TandaiNotifSudahDibaca event,
    Emitter<NotifState> emit,
  ) async {
    final markRes = await notifRepository.tandaiSudahDibaca(event.id);

    if (markRes.status != 200) {
      emit(NotifFailure(resModel: markRes));
      return;
    }

    final updated = await notifRepository.getNotifikasiUser();
    if (updated.status == 200) {
      emit(NotifSuccess(resModel: updated));
    } else {
      emit(NotifFailure(resModel: updated));
    }
  }
}
