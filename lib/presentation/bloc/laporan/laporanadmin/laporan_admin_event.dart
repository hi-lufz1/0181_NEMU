part of 'laporan_admin_bloc.dart';

sealed class LaporanAdminEvent extends Equatable {
  const LaporanAdminEvent();

  @override
  List<Object?> get props => [];
}

class LaporanAdminRequested extends LaporanAdminEvent {}

class LaporanAdminFiltered extends LaporanAdminEvent {
  final GetFilterReqModel reqModel;

  const LaporanAdminFiltered({required this.reqModel});

  @override
  List<Object?> get props => [reqModel];
}
