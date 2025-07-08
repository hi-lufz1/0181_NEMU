import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nemu_app/data/model/laporan_draf_model.dart';
import 'package:nemu_app/data/repository/draf/laporan_draf_repository.dart';

part 'draf_event.dart';
part 'draf_state.dart';

class DrafBloc extends Bloc<DrafEvent, DrafState> {
  final LaporanDrafRepository repository;

  DrafBloc({required this.repository}) : super(DrafInitial()) {
    on<LoadAllDrafEvent>(_onLoadAll);
    on<AddDrafEvent>(_onAdd);
    on<DeleteDrafEvent>(_onDelete);
    on<DeleteAllDrafEvent>(_onDeleteAll);
    on<GetDrafByIdEvent>(_onGetById);
  }

  Future<void> _onLoadAll(
    LoadAllDrafEvent event,
    Emitter<DrafState> emit,
  ) async {
    emit(DrafLoading());
    try {
      final list = await repository.ambilSemuaDraf();
      emit(DrafLoaded(list));
    } catch (e) {
      emit(DrafError("Gagal memuat draf"));
    }
  }

  Future<void> _onGetById(
    GetDrafByIdEvent event,
    Emitter<DrafState> emit,
  ) async {
    emit(DrafLoading());
    try {
      final draf = await repository.ambilDrafById(event.id);
      if (draf != null) {
        emit(DrafDetailLoaded(draf));
      } else {
        emit(DrafError("Draf tidak ditemukan"));
      }
    } catch (e) {
      emit(DrafError("Gagal memuat draf"));
    }
  }

  Future<void> _onAdd(AddDrafEvent event, Emitter<DrafState> emit) async {
    try {
      await repository.simpanDraf(event.laporan);
      add(LoadAllDrafEvent());
    } catch (e) {
      emit(DrafError("Gagal menyimpan draf"));
    }
  }

  Future<void> _onDelete(DeleteDrafEvent event, Emitter<DrafState> emit) async {
    try {
      await repository.hapusDraf(event.id);
      add(LoadAllDrafEvent());
    } catch (e) {
      emit(DrafError("Gagal menghapus draf"));
    }
  }

  Future<void> _onDeleteAll(
    DeleteAllDrafEvent event,
    Emitter<DrafState> emit,
  ) async {
    try {
      await repository.hapusSemuaDraf();
      add(LoadAllDrafEvent());
    } catch (e) {
      emit(DrafError("Gagal menghapus semua draf"));
    }
  }
}
