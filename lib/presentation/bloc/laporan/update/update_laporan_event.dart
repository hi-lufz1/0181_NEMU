part of 'update_laporan_bloc.dart';

sealed class UpdateLaporanEvent extends Equatable {
  const UpdateLaporanEvent();

  @override
  List<Object> get props => [];
}

class UpdateLaporanSubmitted extends UpdateLaporanEvent {
  final String id;
  final UpdateReqModel reqModel;

  const UpdateLaporanSubmitted({required this.id, required this.reqModel});

  @override
  List<Object> get props => [id, reqModel];
}
