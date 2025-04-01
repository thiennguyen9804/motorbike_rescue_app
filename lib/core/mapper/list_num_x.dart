import 'package:latlong2/latlong.dart';

extension ListNumX on List<num> {
  LatLng toLatLng() => LatLng(this.first.toDouble(), this.last.toDouble());
}
