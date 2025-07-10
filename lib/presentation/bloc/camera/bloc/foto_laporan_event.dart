part of 'foto_laporan_bloc.dart';

abstract class FotoLaporanEvent {}

class PickFromGallery extends FotoLaporanEvent {}

class TakeFromCamera extends FotoLaporanEvent {
  final BuildContext context;
  TakeFromCamera(this.context);
}

class DeleteFoto extends FotoLaporanEvent {}
