import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_cubit.dart';
import 'package:flower/features/address/presentation/add_address/cubit/add_address_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddressMapPicker extends StatefulWidget {
  final double height;
  const AddressMapPicker({super.key, this.height = 180});

  @override
  State<AddressMapPicker> createState() => _AddressMapPickerState();
}

class _AddressMapPickerState extends State<AddressMapPicker> {
  static const LatLng _cairo = LatLng(30.0444, 31.2357);
  final _mapController = MapController();
  bool _centredOnGps = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  LatLng _stateLatLng(AddAddressState state) {
    final lat = double.tryParse(state.lat);
    final long = double.tryParse(state.long);
    if (lat == null || long == null) return _cairo;
    return LatLng(lat, long);
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveEnd) {
      final c = _mapController.camera.center;
      context.read<AddAddressCubit>().doIntent(
        LocationPickedIntent(
          lat: c.latitude.toString(),
          long: c.longitude.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAddressCubit, AddAddressState>(
      listenWhen: (prev, curr) =>
          prev.lat != curr.lat || prev.long != curr.long,
      listener: (context, state) {
        if (!_centredOnGps && state.lat.isNotEmpty && state.long.isNotEmpty) {
          _centredOnGps = true;
          _mapController.move(_stateLatLng(state), 15);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: widget.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _cairo,
                  initialZoom: 12,
                  onMapEvent: _onMapEvent,
                  interactionOptions: const InteractionOptions(
                    flags:
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.drag |
                        InteractiveFlag.doubleTapZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.flower.ecommerce',
                  ),
                ],
              ),
              const IgnorePointer(
                child: Icon(
                  Icons.location_pin,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              BlocBuilder<AddAddressCubit, AddAddressState>(
                buildWhen: (prev, curr) =>
                    prev.lat != curr.lat || prev.long != curr.long,
                builder: (context, state) {
                  if (_centredOnGps ||
                      (state.lat.isNotEmpty && state.long.isNotEmpty)) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    color: Colors.white.withValues(alpha: 0.6),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
