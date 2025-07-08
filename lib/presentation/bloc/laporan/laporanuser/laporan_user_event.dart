part of 'laporan_user_bloc.dart';

sealed class LaporanUserEvent extends Equatable {
  const LaporanUserEvent();

  @override
  List<Object?> get props => [];
}

class GetAllAktifLaporan extends LaporanUserEvent {}

class GetLaporanSaya extends LaporanUserEvent {}

class FilterLaporanUser extends LaporanUserEvent {
  final GetFilterReqModel reqModel;

  const FilterLaporanUser({required this.reqModel});

  @override
  List<Object?> get props => [reqModel];
}
