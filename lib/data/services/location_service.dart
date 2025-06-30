import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/core/mapper/position_x.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';

import '../../sl.dart';

abstract class LocationService {
  Future<void> scan();
}

class LocationServiceImpl implements LocationService {
  Timer? _timer;
  Future<void> _scan(LatLng coor) async {
    await sl<DioClient>().get(ServerNetworkConstant.DEVICES_SCAN,
        queryParameters: {
          'latitude': coor.latitude,
          'longitude': coor.longitude
        });
  }

  @override
  Future<void> scan() async {
    _timer = Timer.periodic(Duration(seconds: 5), (_) async {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final coor = position.toLatLng();

      await _scan(coor);
    });
  }
}
