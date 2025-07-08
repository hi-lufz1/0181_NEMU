import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';

part 'laporan_user_event.dart';
part 'laporan_user_state.dart';

class LaporanUserBloc extends Bloc<LaporanUserEvent, LaporanUserState> {
  LaporanUserBloc() : super(LaporanUserInitial()) {
    on<LaporanUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
