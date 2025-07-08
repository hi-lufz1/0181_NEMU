part of 'update_laporan_bloc.dart';

sealed class UpdateLaporanState extends Equatable {
  const UpdateLaporanState();

  @override
  List<Object?> get props => [];
}

class UpdateLaporanInitial extends UpdateLaporanState {}

class UpdateLaporanLoading extends UpdateLaporanState {}

class UpdateLaporanSuccess extends UpdateLaporanState {
  final UpdateResModel resModel;

  const UpdateLaporanSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class UpdateLaporanFailure extends UpdateLaporanState {
  final UpdateResModel resModel;

  const UpdateLaporanFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
