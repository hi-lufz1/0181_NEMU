import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemu_app/core/utils/storage_helper.dart';

part 'foto_laporan_event.dart';
part 'foto_laporan_state.dart';

class FotoLaporanBloc extends Bloc<FotoLaporanEvent, FotoLaporanState> {
  final ImagePicker _picker = ImagePicker();

  FotoLaporanBloc() : super(FotoLaporanInitial()) {
    on<PickFromGallery>(_onPickFromGallery);
    on<TakeFromCamera>(_onTakeFromCamera);
    on<DeleteFoto>(_onDeleteFoto);
    on<SetSelectedFoto>(_onSetSelectedFoto);
    on<ClearSelectedFoto>(_onClearSelectedFoto);
    on<LoadFotoFromPath>(_onLoadFotoFromPath);
    on<SetFromBase64>(_onSetFromBase64);
  }

  Future<void> _onPickFromGallery(
    PickFromGallery event,
    Emitter<FotoLaporanState> emit,
  ) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final saved = await StorageHelper.saveImage(
        File(picked.path),
        'gallery_',
      );
      emit(
        FotoLaporanPicked(file: saved, message: 'Berhasil pilih dari galeri'),
      );
    }
  }

  Future<void> _onTakeFromCamera(
    TakeFromCamera event,
    Emitter<FotoLaporanState> emit,
  ) async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final saved = await StorageHelper.saveImage(File(picked.path), 'camera_');
      emit(
        FotoLaporanPicked(file: saved, message: 'Berhasil ambil dari kamera'),
      );
    }
  }

  Future<void> _onDeleteFoto(
    DeleteFoto event,
    Emitter<FotoLaporanState> emit,
  ) async {
    if (state.file != null) {
      try {
        await state.file!.delete();
        emit(FotoLaporanDeleted(message: 'Foto dihapus'));
      } catch (_) {
        emit(FotoLaporanDeleted(message: 'Gagal menghapus foto'));
      }
    } else {
      emit(FotoLaporanDeleted(message: 'Tidak ada foto untuk dihapus'));
    }
  }

  Future<void> _onSetSelectedFoto(
    SetSelectedFoto event,
    Emitter<FotoLaporanState> emit,
  ) async {
    emit(FotoLaporanPicked(file: event.file, message: 'Foto dipilih manual'));
  }

  Future<void> _onClearSelectedFoto(
    ClearSelectedFoto event,
    Emitter<FotoLaporanState> emit,
  ) async {
    emit(FotoLaporanInitial());
  }

  Future<void> _onLoadFotoFromPath(
    LoadFotoFromPath event,
    Emitter<FotoLaporanState> emit,
  ) async {
    final file = File(event.path);
    if (await file.exists()) {
      emit(FotoLaporanPicked(file: file, message: 'Foto dimuat dari draft'));
    } else {
      emit(FotoLaporanInitial()); // fallback kalau file-nya tidak ada
    }
  }

  Future<void> _onSetFromBase64(
    SetFromBase64 event,
    Emitter<FotoLaporanState> emit,
  ) async {
    final bytes = base64Decode(event.base64);
    final file = File('${Directory.systemTemp.path}/temp_image.png');
    await file.writeAsBytes(bytes);
    emit(FotoLaporanPicked(file: file, message: 'Foto di-set dari base64'));
  }
}
