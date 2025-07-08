part of 'delete_laporan_bloc.dart';

sealed class DeleteLaporanEvent extends Equatable {
  const DeleteLaporanEvent();

  @override
  List<Object> get props => [];
}

class DeleteLaporanSubmitted extends DeleteLaporanEvent {
  final String id;

  const DeleteLaporanSubmitted({required this.id});

  @override
  List<Object> get props => [id];
}
