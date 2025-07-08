part of 'add_laporan_bloc.dart';

sealed class AddLaporanState extends Equatable {
  const AddLaporanState();

  @override
  List<Object> get props => [];
}

class AddLaporanInitial extends AddLaporanState {}

class AddLaporanLoading extends AddLaporanState {}

class AddLaporanSuccess extends AddLaporanState {
  final String message;

  const AddLaporanSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AddLaporanFailure extends AddLaporanState {
  final String message;

  const AddLaporanFailure({required this.message});

  @override
  List<Object> get props => [message];
  
  @override
  String toString() => 'AddLaporanFailure { message: $message }';
}
