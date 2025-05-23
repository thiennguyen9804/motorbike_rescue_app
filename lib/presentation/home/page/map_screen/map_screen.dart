import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/mock/mock_emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/page/pick_time_screen.dart';

import 'tile_providers.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController(); // Điều khiển bản đồ
  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void moveToPickTimeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickTimeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: moveToCurrentLocation, // Di chuyển về vị trí hiện tại
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: moveToPickTimeScreen,
            child: const Icon(Icons.history),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController, // Gán controller cho bản đồ
            options: const MapOptions(
              initialCenter: LatLng(10.885230, 106.782022),
              initialZoom: 17,
              maxZoom: 20,
            ),
            children: [
              openStreetMapTileLayer,
              CurrentLocationLayer(),
              BlocBuilder<EmergencyCubit, EmergencyState>(
                builder: (context, state) {
                  switch (state) {
                    case EmergencyInitial():
                      return Container();
                    case EmergencyHappened():
                      return Container();
                    case RouteFetched(:final List<LatLng> polylinePoints):
                      return PolylineLayer(
                        polylines: [
                          Polyline(
                            points: polylinePoints,
                            color: AppTheme.bgDanger,
                            strokeWidth: 2,
                          ),
                        ],
                      );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> moveToCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      _mapController.move(LatLng(position.latitude, position.longitude), 17);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Không thể lấy vị trí: $e")),
      );
    }
  }

  /// 🛑 Yêu cầu quyền truy cập vị trí
  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }
  }
}
