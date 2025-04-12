import 'package:latlong2/latlong.dart';

class InstructionUi {
  final String text;
  final double distance;
  final LatLng position;

  InstructionUi({
    required this.text,
    required this.distance,
    required this.position,
  });

  InstructionUi copyWith({
    String? text,
    double? distance,
    LatLng? position,
  }) {
    return InstructionUi(
      text: text ?? this.text,
      distance: distance ?? this.distance,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'InstructionUi(text: $text, distance: $distance, position: ${position.latitude}, ${position.longitude})';
  }
}
