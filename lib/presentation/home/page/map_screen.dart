import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/emergency_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/custom_direction_arrow_marker.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/custom_user_marker.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final mapController = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  CircleOSM? userCircle;

  final userMarker = UserLocationMaker(
    personMarker: MarkerIcon(
      iconWidget: const CustomUserMarker(),
    ),
    directionArrowMarker: MarkerIcon(
      iconWidget: const CustomUserMarker(),
    ),
  );

  // Future<void> _initUserTracking() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: mapController,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 17,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: userMarker,
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
        ),
      ),
    );
  }
}
