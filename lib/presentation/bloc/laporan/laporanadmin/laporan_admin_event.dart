part of 'laporan_admin_bloc.dart';

sealed class LaporanAdminEvent extends Equatable {
  const LaporanAdminEvent();

  @override
  List<Object?> get props => [];
}

class LaporanAdminRequested extends LaporanAdminEvent {}

class LaporanAdminFiltered extends LaporanAdminEvent {
  final GetFilterReqModel filter;

  const LaporanAdminFiltered({required this.filter});

  @override
  List<Object?> get props => [filter];
}
