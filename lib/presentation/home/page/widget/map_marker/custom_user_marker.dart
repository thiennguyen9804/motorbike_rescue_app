import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/map_marker/curved_triangle.dart';

class CustomUserMarker extends StatelessWidget {
  const CustomUserMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: Container(
        // decoration: BoxDecoration(color: Colors.amber),
        height: 400,
        width: 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Vòng tròn làm nền
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.bgPos,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
              ),
            ),

            // Tam giác chỉ hướng
            Positioned(
              top: 230, // Dịch lên trên một chút
              child: CustomPaint(
                size: const Size(80, 80), // Kích thước tam giác
                painter: CurvedTriangle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
