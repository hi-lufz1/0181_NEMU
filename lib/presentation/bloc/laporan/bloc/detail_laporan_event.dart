part of 'detail_laporan_bloc.dart';

sealed class DetailLaporanEvent extends Equatable {
  const DetailLaporanEvent();

  @override
  List<Object?> get props => [];
}

class DetailLaporanRequested extends DetailLaporanEvent {
  final String id;

  const DetailLaporanRequested({required this.id});

  @override
  List<Object?> get props => [id];
}
