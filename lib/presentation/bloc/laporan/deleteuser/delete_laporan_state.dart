part of 'delete_laporan_bloc.dart';

sealed class DeleteLaporanState extends Equatable {
  const DeleteLaporanState();

  @override
  List<Object?> get props => [];
}

class DeleteLaporanInitial extends DeleteLaporanState {}

class DeleteLaporanLoading extends DeleteLaporanState {}

class DeleteLaporanSuccess extends DeleteLaporanState {
  final DeleteResModel resModel;

  const DeleteLaporanSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class DeleteLaporanFailure extends DeleteLaporanState {
  final DeleteResModel resModel;

  const DeleteLaporanFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
