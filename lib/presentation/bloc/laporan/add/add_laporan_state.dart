part of 'add_laporan_bloc.dart';

sealed class AddLaporanState extends Equatable {
  const AddLaporanState();

  @override
  List<Object?> get props => [];
}

class AddLaporanInitial extends AddLaporanState {}

class AddLaporanLoading extends AddLaporanState {}

class AddLaporanSuccess extends AddLaporanState {
  final AddLaporanResModel resModel;

  const AddLaporanSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class AddLaporanFailure extends AddLaporanState {
  final AddLaporanResModel resModel;

  const AddLaporanFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
