part of 'update_laporan_bloc.dart';

sealed class UpdateLaporanState extends Equatable {
  const UpdateLaporanState();

  @override
  List<Object> get props => [];
}

class UpdateLaporanInitial extends UpdateLaporanState {}

class UpdateLaporanLoading extends UpdateLaporanState {}

class UpdateLaporanSuccess extends UpdateLaporanState {
  final String message;

  const UpdateLaporanSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateLaporanFailure extends UpdateLaporanState {
  final String message;

  const UpdateLaporanFailure({required this.message});

  @override
  List<Object> get props => [message];
}
