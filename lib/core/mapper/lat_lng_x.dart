import 'package:latlong2/latlong.dart';

extension LatLngX on LatLng {
  List<num> toArr() => <num>[latitude, longitude];
}
