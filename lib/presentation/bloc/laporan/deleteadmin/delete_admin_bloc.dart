import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/request/admin/delete_admin_req_model.dart';
import 'package:nemu_app/data/model/response/umum/delete_res_model.dart';
import 'package:nemu_app/data/repository/laporan/laporan_admin_repository.dart';

part 'delete_admin_event.dart';
part 'delete_admin_state.dart';

class DeleteAdminBloc extends Bloc<DeleteAdminEvent, DeleteAdminState> {
  final LaporanAdminRepository repository;

  DeleteAdminBloc({required this.repository}) : super(DeleteAdminInitial()) {
    on<DeleteAdminSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    DeleteAdminSubmitted event,
    Emitter<DeleteAdminState> emit,
  ) async {
    emit(DeleteAdminLoading());

    final res = await repository.deleteLaporanByAdmin(
      id: event.id,
      deleteReq: event.reqModel,
    );

    if (res.status == 200) {
      emit(DeleteAdminSuccess(resModel: res));
    } else {
      emit(DeleteAdminFailure(resModel: res));
    }
  }
}
