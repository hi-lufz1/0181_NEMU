part of 'draf_bloc.dart';

sealed class DrafState extends Equatable {
  const DrafState();

  @override
  List<Object?> get props => [];
}

class DrafInitial extends DrafState {}

class DrafLoading extends DrafState {}

class DrafLoaded extends DrafState {
  final List<LaporanDrafModel> list;
  const DrafLoaded(this.list);

  @override
  List<Object?> get props => [list];
}

class DrafDetailLoaded extends DrafState {
  final LaporanDrafModel laporan;
  const DrafDetailLoaded(this.laporan);

  @override
  List<Object?> get props => [laporan];
}


class DrafError extends DrafState {
  final String message;
  const DrafError(this.message);

  @override
  List<Object?> get props => [message];
}