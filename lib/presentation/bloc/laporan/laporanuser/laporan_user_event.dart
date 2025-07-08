part of 'laporan_user_bloc.dart';

sealed class LaporanUserEvent extends Equatable {
  const LaporanUserEvent();

  @override
  List<Object?> get props => [];
}

class GetAllAktifLaporan extends LaporanUserEvent {}

class GetLaporanSaya extends LaporanUserEvent {}

class FilterLaporanAktif extends LaporanUserEvent {
  final GetFilterReqModel filter;

  const FilterLaporanAktif({required this.filter});

  @override
  List<Object?> get props => [filter];
}
