import 'package:latlong2/latlong.dart';

class InstructionUi {
  final String text;
  final double distance;
  final LatLng destination;

  InstructionUi({
    required this.text,
    required this.distance,
    required this.destination,
  });

  InstructionUi copyWith({
    String? text,
    double? distance,
    LatLng? position,
  }) {
    return InstructionUi(
      text: text ?? this.text,
      distance: distance ?? this.distance,
      destination: position ?? this.destination,
    );
  }

  @override
  String toString() {
    return 'InstructionUi(text: $text, distance: $distance, position: ${destination.latitude}, ${destination.longitude})';
  }
}

