part of 'draf_bloc.dart';

sealed class DrafEvent extends Equatable {
  const DrafEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllDrafEvent extends DrafEvent {}

class AddDrafEvent extends DrafEvent {
  final LaporanDrafModel laporan;
  const AddDrafEvent(this.laporan);

  @override
  List<Object?> get props => [laporan];
}

class GetDrafByIdEvent extends DrafEvent {
  final String id;
  const GetDrafByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteDrafEvent extends DrafEvent {
  final String id;
  const DeleteDrafEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteAllDrafEvent extends DrafEvent {}