import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/circle_timer.dart';

class UserEmergencyInstance {
  UserEmergencyInstance._privateConstructor();

  static final UserEmergencyInstance _instance =
      UserEmergencyInstance._privateConstructor();

  factory UserEmergencyInstance() {
    return _instance;
  }

  // Method to show the emergency bottom sheet
  void showEmergencyBottomSheet(BuildContext context, int duration) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return SafeConfirmBottomSheet(duration: duration);
      },
    );
  }
}

class SafeConfirmBottomSheet extends StatefulWidget {
  final int duration;

  const SafeConfirmBottomSheet({super.key, required this.duration});

  @override
  _SafeConfirmBottomSheetState createState() => _SafeConfirmBottomSheetState();
}

class _SafeConfirmBottomSheetState extends State<SafeConfirmBottomSheet> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        // Add your action here when the timer completes
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Bạn có đang gặp nguy hiểm không?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff323232),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Chúng tôi phát hiện có dấu hiệu bất thường. Bạn có cần trợ giúp không?',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff323232),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleTimer(
                duration: widget.duration,
                onTimerComplete: () {
                  // Add your action here when the timer completes
                },
              ),
              const SizedBox(width: 10),
              Text(
                '$_remainingTime giây nữa sẽ phát tín hiệu cầu cứu',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff323232),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.bgPos,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Add your action here
            },
            child: const Text(
              'Tôi an toàn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.bgDanger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Add your action here
            },
            child: const Text(
              'Tôi cần giúp đỡ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
