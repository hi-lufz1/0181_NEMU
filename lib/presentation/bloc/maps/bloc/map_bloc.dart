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
    on<SearchLocation>(_onSearchLocation);
    on<SetPickedLatLng>(_onSetPickedLatLng);
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
    try {
      final latlng = event.latLng;

      // Default marker (jika reverse geocoding gagal)
      Marker marker = Marker(
        markerId: const MarkerId('picked'),
        position: latlng,
        infoWindow: const InfoWindow(title: 'Lokasi dipilih'),
      );

      String? address;

      try {
        final placemarks = await placemarkFromCoordinates(
          latlng.latitude,
          latlng.longitude,
        );
        final p = placemarks.first;

        marker = Marker(
          markerId: const MarkerId('picked'),
          position: latlng,
          infoWindow: InfoWindow(
            title: p.name?.isNotEmpty == true ? p.name : 'Lokasi dipilih',
            snippet: '${p.street ?? ''}, ${p.locality ?? ''}',
          ),
        );

        address = _formatAddress(p);
      } catch (e) {
        emit(
          state.copyWith(
            error: "Gagal mendapatkan alamat dari lokasi tersebut.",
          ),
        );
      }

      emit(
        state.copyWith(
          pickedLatLng: latlng,
          pickedMarker: marker,
          pickedAddress: address,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onClearPickedLocation(
    ClearPickedLocation event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        pickedMarker: null,
        pickedAddress: null,
        pickedLatLng: null,
      ),
    );
  }

  Future<void> _onSearchLocation(
    SearchLocation event,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final results = await locationFromAddress(event.query);
      if (results.isNotEmpty) {
        final location = results.first;
        final latLng = LatLng(location.latitude, location.longitude);

        final addressList = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        final address = _formatAddress(addressList.first);

        final marker = Marker(
          markerId: const MarkerId('picked'),
          position: latLng,
        );

        final camera = CameraPosition(target: latLng, zoom: 16);
        emit(
          state.copyWith(
            pickedLatLng: latLng,
            pickedAddress: address,
            pickedMarker: marker,
            initialCamera: camera,
            isLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Gagal mencari lokasi"));
    }
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

  Future<void> _onSetPickedLatLng(
    SetPickedLatLng event,
    Emitter<MapState> emit,
  ) async {
    try {
      final latLng = LatLng(event.latitude, event.longitude);
      print("📌 SetPickedLatLng diterima: $latLng");
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final marker = Marker(
        markerId: const MarkerId('picked'),
        position: latLng,
        infoWindow: InfoWindow(
          title: placemarks.first.name ?? 'Lokasi dipilih',
          snippet:
              '${placemarks.first.locality ?? ''}, ${placemarks.first.country ?? ''}',
        ),
      );

      emit(
        state.copyWith(
          pickedLatLng: latLng,
          pickedAddress: _formatAddress(placemarks.first),
          pickedMarker: marker,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Gagal menyetel lokasi dari draf.'));
    }
  }
}

String _formatAddress(Placemark p) {
  final parts =
      [
        p.name,
        p.street,
        p.subAdministrativeArea,
        p.administrativeArea,
      ].where((e) => e != null && e.trim().isNotEmpty).toList();

  return parts.join(', ');
}
