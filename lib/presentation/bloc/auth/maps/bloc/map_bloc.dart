import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(isLoading: true)) {
    on<InitializeMap>(_onInitializeMap);
    on<PickLocation>(_onPickLocation);
    on<ClearPickedLocation>(_onClearPickedLocation);
  }

  Future<void> _onInitializeMap(
    InitializeMap event,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final position = await _getPermissionAndPosition();
      final placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final cam = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 10,
      );
      final addr =
          '${placemark[0].name}, ${placemark[0].locality}, ${placemark[0].country}';
      emit(
        state.copyWith(
          initialCamera: cam,
          currentAddress: addr,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          initialCamera: const CameraPosition(target: LatLng(0, 0), zoom: 2),
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPickLocation(
    PickLocation event,
    Emitter<MapState> emit,
  ) async {
    final latlng = event.latLng;

    Marker marker = Marker(
      markerId: const MarkerId('picked'),
      position: latlng,
      infoWindow: const InfoWindow(title: 'Lokasi dipilih', snippet: ''),
    );

    String address = 'Alamat tidak ditemukan';

    try {
      final placemarks = await placemarkFromCoordinates(
        latlng.latitude,
        latlng.longitude,
      ).timeout(const Duration(seconds: 3)); // ⏰ Tambahkan timeout

      final p = placemarks.first;
      marker = Marker(
        markerId: const MarkerId('picked'),
        position: latlng,
        infoWindow: InfoWindow(
          title: p.name?.isNotEmpty == true ? p.name : 'Lokasi dipilih',
          snippet: '${p.street}, ${p.locality}',
        ),
      );
      address =
          '${p.name}, ${p.street}, ${p.locality}, ${p.country}, ${p.postalCode}';
    } catch (e) {
      address = 'Alamat tidak ditemukan';
      emit(
        state.copyWith(
          error: 'Gagal mengambil alamat. Silakan coba lokasi lain.',
        ),
      );
    }

    emit(
      state.copyWith(pickedMarker: marker, pickedAddress: address, error: null),
    );
  }

  void _onClearPickedLocation(
    ClearPickedLocation event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(pickedMarker: null, pickedAddress: null));
  }

  Future<Position> _getPermissionAndPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Location services belum aktif.';
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) {
        throw 'Izin lokasi ditolak.';
      }
    }
    if (perm == LocationPermission.deniedForever) {
      throw 'Izin lokasi ditolak permanen.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
