part of 'map_bloc.dart';

class MapState extends Equatable {
  final CameraPosition? initialCamera;
  final Marker? pickedMarker;
  final String? pickedAddress;
  final String? currentAddress;
  final bool isLoading;
  final String? error;

  const MapState({
    this.initialCamera,
    this.pickedMarker,
    this.pickedAddress,
    this.currentAddress,
    this.isLoading = false,
    this.error,
  });

  MapState copyWith({
    CameraPosition? initialCamera,
    Marker? pickedMarker,
    String? pickedAddress,
    String? currentAddress,
    bool? isLoading,
    String? error,
  }) {
    return MapState(
      initialCamera: initialCamera ?? this.initialCamera,
      pickedMarker: pickedMarker ?? this.pickedMarker,
      pickedAddress: pickedAddress ?? this.pickedAddress,
      currentAddress: currentAddress ?? this.currentAddress,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        initialCamera,
        pickedMarker,
        pickedAddress,
        currentAddress,
        isLoading,
        error,
      ];
}
