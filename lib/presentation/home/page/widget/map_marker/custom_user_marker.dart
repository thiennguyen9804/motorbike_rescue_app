import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class CustomUserMarker extends StatelessWidget {
  const CustomUserMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.bgPos,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 6,
        ),
      ),
    );
  }
}
