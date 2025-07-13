part of 'detail_laporan_bloc.dart';

sealed class DetailLaporanState extends Equatable {
  const DetailLaporanState();

  @override
  List<Object?> get props => [];
}

class DetailLaporanInitial extends DetailLaporanState {}

class DetailLaporanLoading extends DetailLaporanState {}

class DetailLaporanSuccess extends DetailLaporanState {
  final GetdetailResModel resModel;
  final bool isLaporanSaya;
  final bool isAdmin;

  const DetailLaporanSuccess({
    required this.resModel,
    required this.isLaporanSaya,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [resModel, isLaporanSaya, isAdmin];
}

class DetailLaporanFailure extends DetailLaporanState {
  final GetdetailResModel resModel;

  const DetailLaporanFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
