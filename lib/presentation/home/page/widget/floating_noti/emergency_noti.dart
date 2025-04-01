import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';

class EmergencyNoti extends StatefulWidget {
  final VoidCallback onTap;
  const EmergencyNoti({
    super.key,
    required this.onTap,
  });
  @override
  _EmergencyNotiState createState() => _EmergencyNotiState();
}

class _EmergencyNotiState extends State<EmergencyNoti> {
  late StreamSubscription<int> _timerSubscription;
  int _remainingTime = 30;

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.icDanger,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppTheme.onDanger,
                      size: 50,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '69m',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.onDanger,
                          ),
                        ),
                        Text(
                          'Tai nạn tại Đường XYZ',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.onDanger,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
