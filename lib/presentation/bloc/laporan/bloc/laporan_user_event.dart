part of 'laporan_user_bloc.dart';

sealed class LaporanUserEvent extends Equatable {
  const LaporanUserEvent();

  @override
  List<Object?> get props => [];
}

class GetAllLaporanAktif extends LaporanUserEvent {}

class GetLaporanSaya extends LaporanUserEvent {}

class FilterLaporanAktif extends LaporanUserEvent {
  final GetFilterReqModel filter;

  const FilterLaporanAktif(this.filter);

  @override
  List<Object?> get props => [filter];
}
