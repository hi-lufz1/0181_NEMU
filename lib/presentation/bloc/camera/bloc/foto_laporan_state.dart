part of 'foto_laporan_bloc.dart';

abstract class FotoLaporanState {
  final File? file;
  final String? message;

  FotoLaporanState({this.file, this.message});
}

class FotoLaporanInitial extends FotoLaporanState {}

class FotoLaporanPicked extends FotoLaporanState {
  FotoLaporanPicked({required File file, String? message})
      : super(file: file, message: message);
}

class FotoLaporanDeleted extends FotoLaporanState {
  FotoLaporanDeleted({String? message}) : super(message: message);
}
