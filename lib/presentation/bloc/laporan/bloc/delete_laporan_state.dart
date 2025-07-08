part of 'delete_laporan_bloc.dart';

sealed class DeleteLaporanState extends Equatable {
  const DeleteLaporanState();

  @override
  List<Object> get props => [];
}

class DeleteLaporanInitial extends DeleteLaporanState {}

class DeleteLaporanLoading extends DeleteLaporanState {}

class DeleteLaporanSuccess extends DeleteLaporanState {
  final String message;

  const DeleteLaporanSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteLaporanFailure extends DeleteLaporanState {
  final String message;

  const DeleteLaporanFailure({required this.message});

  @override
  List<Object> get props => [message];
}
