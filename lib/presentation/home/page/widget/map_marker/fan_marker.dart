import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class FanMarker extends StatelessWidget {
  final double rotation; // Góc quay của hình quạt

  const FanMarker({
    super.key,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: rotation * (math.pi / 180), // Chuyển từ độ sang radian
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: CustomPaint(
          size: size,
          painter: FanPainter(),
        ),
      ),
    );
  }
}

class FanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size.height);
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);
    final curveR = 120.0;
    paint.shader = ui.Gradient.radial(
      center,
      curveR,
      [AppTheme.bgPos, Colors.transparent],
    );
    paint.style = PaintingStyle.fill;
    // paint.color = AppTheme.bgPos;
    canvas.drawCircle(Offset(center.dx, center.dy), curveR, paint);
    // paint.color = Colors.white;
    // canvas.drawCircle(center, 28, paint);
    // paint.color = AppTheme.bgPos;
    // canvas.drawCircle(center, 24, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
