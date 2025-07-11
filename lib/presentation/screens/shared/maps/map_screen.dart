import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/presentation/bloc/auth/maps/bloc/map_bloc.dart';
import 'package:nemu_app/presentation/screens/shared/maps/components/confirm_location_dialog.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(InitializeMap());
  }

  void _onMapTap(LatLng latLng) {
    context.read<MapBloc>().add(PickLocation(latLng));
  }

  void _confirmSelection(String pickedAddress) {
    showDialog(
      context: context,
      builder:
          (_) => ConfirmLocationDialog(
            address: pickedAddress,
            onConfirm: () {
              Navigator.pop(context); // Tutup dialo
              Navigator.pop(context, pickedAddress); // kirim ke form
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Lokasi')),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading || state.initialCamera == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: state.initialCamera!,
                onMapCreated: (controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers:
                    state.pickedMarker != null ? {state.pickedMarker!} : {},
                onTap: _onMapTap,
              ),

              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<MapBloc>().add(SearchLocation(value));
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Cari lokasi...",
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),

              if (state.currentAddress != null)
                Positioned(
                  top: 75,
                  left: 16,
                  right: 16,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        state.currentAddress!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),

              if (state.pickedAddress != null)
                Positioned(
                  bottom: 120,
                  left: 16,
                  right: 16,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.pickedAddress!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),

      floatingActionButton: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state.pickedAddress == null) return const SizedBox();

          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'confirm',
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.check, color: Colors.white),
                onPressed: () => _confirmSelection(state.pickedAddress!),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'clear',
                backgroundColor: AppColors.secondary,
                child: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  context.read<MapBloc>().add(ClearPickedLocation());
                  _searchController.clear();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
