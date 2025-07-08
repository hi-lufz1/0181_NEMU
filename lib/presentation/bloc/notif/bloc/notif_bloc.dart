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
}
