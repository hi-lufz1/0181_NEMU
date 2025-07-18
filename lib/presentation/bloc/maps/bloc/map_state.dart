part of 'map_bloc.dart';

class MapState extends Equatable {
  final CameraPosition? initialCamera;
  final Marker? pickedMarker;
  final String? pickedAddress;
  final String? currentAddress;
  final bool isLoading;
  final String? error;
  final LatLng? pickedLatLng;

  const MapState({
    this.initialCamera,
    this.pickedMarker,
    this.pickedAddress,
    this.currentAddress,
    this.pickedLatLng, // ⬅️ Tambah ini
    this.isLoading = false,
    this.error,
  });

MapState copyWith({
  CameraPosition? initialCamera,
  Marker? pickedMarker,
  String? pickedAddress,
  String? currentAddress,
  LatLng? pickedLatLng,
  bool? isLoading,
  String? error,
}) {
  return MapState(
    initialCamera: initialCamera ?? this.initialCamera,
    pickedMarker: pickedMarker,
    pickedAddress: pickedAddress,
    currentAddress: currentAddress ?? this.currentAddress,
    pickedLatLng: pickedLatLng,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}


  @override
  List<Object?> get props => [
    initialCamera,
    pickedMarker,
    pickedAddress,
    currentAddress,
    pickedLatLng,
    isLoading,
    error,
  ];
}
