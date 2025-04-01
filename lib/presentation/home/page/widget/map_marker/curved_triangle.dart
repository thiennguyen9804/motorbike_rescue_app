import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class CurvedTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppTheme.bgPos,
          AppTheme.bgPos.withAlpha(100)
        ], // Gradient từ xanh sang tím
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill; // Đổ màu vào hình

    final path = Path();

    // Điểm đỉnh tam giác
    final top = Offset(size.width / 2, -size.height * 0.4);

    // Điểm trái và phải của đáy cong
    final left = Offset(0, size.height);
    final right = Offset(size.width, size.height);

    // Bắt đầu từ đỉnh
    path.moveTo(top.dx, top.dy);

    // Kẻ cạnh trái
    path.lineTo(left.dx, left.dy);

    // Vẽ cung tròn làm đáy
    path.arcToPoint(
      right,
      radius: Radius.circular(size.width * 0.7), // Độ cong lớn hơn
      clockwise: false,
    );

    // Kẻ cạnh phải
    path.lineTo(top.dx, top.dy);

    // Vẽ đường path lên canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvedTriangle oldDelegate) => true;
}
