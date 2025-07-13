part of 'foto_laporan_bloc.dart';

abstract class FotoLaporanEvent {}

class PickFromGallery extends FotoLaporanEvent {}

class TakeFromCamera extends FotoLaporanEvent {}

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

class SetFromBase64 extends FotoLaporanEvent {
  final String base64;
  SetFromBase64({required this.base64});
}
