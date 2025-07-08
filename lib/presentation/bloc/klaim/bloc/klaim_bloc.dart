import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/umum/klaim_req_model.dart';
import 'package:nemu_app/data/model/response/umum/klaim_res_model.dart';
import 'package:nemu_app/data/repository/klaim/klaim_repository.dart';

part 'klaim_event.dart';
part 'klaim_state.dart';

class KlaimBloc extends Bloc<KlaimEvent, KlaimState> {
  final KlaimRepository klaimRepository;

  KlaimBloc({required this.klaimRepository}) : super(KlaimInitial()) {
    on<KlaimSubmitted>(_onKlaimSubmitted);
  }

  Future<void> _onKlaimSubmitted(
    KlaimSubmitted event,
    Emitter<KlaimState> emit,
  ) async {
    emit(KlaimLoading());

    final res = await klaimRepository.buatKlaim(event.laporanId, event.reqModel);

    if (res.status == 200) {
      emit(KlaimSuccess(resModel: res));
    } else {
      emit(KlaimFailure(resModel: res));
    }
  }
}
