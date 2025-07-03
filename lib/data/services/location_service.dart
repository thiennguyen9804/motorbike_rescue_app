import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/constant/network_constant.dart';
import 'package:motorbike_rescue_app/core/network/dio_client.dart';
import 'package:motorbike_rescue_app/data/services/auth_local_service.dart';

import '../../sl.dart';

abstract class LocationService {
  Future<void> scan();
}

class LocationServiceImpl implements LocationService {
  Future<void> _scan(LatLng coor) async {
    final tokens = sl<AuthLocalService>().getTokens();
    // debugPrint('send lat: ${coor.latitude}, long: ${coor.longitude}');
    await sl<DioClient>().patch(
      ServerNetworkConstant.UPDATE_POS,
      options: Options(
        headers: {'Authorization': 'Bearer ${tokens.token}'},
      ),
      data: {
        "longitude": coor.longitude,
        "latitude": coor.latitude,
      },
    );
  }

  // @override
  // Future<void> scan() async {
  //   final coor = LatLng(10.870591, 106.748216);
  //   await _scan(coor);
  // }

  @override
  Future<void> scan() async {
    Timer.periodic(
      Duration(seconds: 5),
      (_) async {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        // final coor = position.toLatLng();
        final coor = LatLng(10.870591, 106.748216);
        await _scan(coor);
      },
    );
  }
}
