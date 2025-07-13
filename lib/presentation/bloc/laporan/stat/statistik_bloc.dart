import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/response/admin/stat_res_model.dart';
import 'package:nemu_app/data/repository/laporan/statistik_repository.dart';


part 'statistik_event.dart';
part 'statistik_state.dart';

class StatistikBloc extends Bloc<StatistikEvent, StatistikState> {
  final StatistikRepository repository;

  StatistikBloc({required this.repository}) : super(StatistikInitial()) {
    on<StatistikRequested>(_onRequested);
  }

  Future<void> _onRequested(
    StatistikRequested event,
    Emitter<StatistikState> emit,
  ) async {
    emit(StatistikLoading());

    final res = await repository.getStatistikAdmin();

    if (res.status == 200) {
      emit(StatistikSuccess(resModel: res));
    } else {
      emit(StatistikFailure(resModel: res));
    }
  }
}
