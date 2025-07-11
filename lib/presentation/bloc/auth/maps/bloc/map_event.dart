part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class InitializeMap extends MapEvent {}

class PickLocation extends MapEvent {
  final LatLng latLng;

  const PickLocation(this.latLng);

  @override
  List<Object> get props => [latLng];
}

class SearchLocation extends MapEvent {
  final String query;

  const SearchLocation(this.query);

  @override
  List<Object> get props => [query];
}


class ClearPickedLocation extends MapEvent {}
