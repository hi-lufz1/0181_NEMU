part of 'foto_laporan_bloc.dart';

abstract class FotoLaporanEvent {}

class PickFromGallery extends FotoLaporanEvent {}

class TakeFromCamera extends FotoLaporanEvent {
}

class DeleteFoto extends FotoLaporanEvent {}

class SetSelectedFoto extends FotoLaporanEvent {
  final File file;
  SetSelectedFoto(this.file);
}

class ClearSelectedFoto extends FotoLaporanEvent {}

class LoadFotoFromPath extends FotoLaporanEvent {
  final String path;
  LoadFotoFromPath(this.path);
}