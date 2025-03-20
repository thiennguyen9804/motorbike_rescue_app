import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/timer_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/circle_timer.dart';

class SafeConfirmBottomSheet extends StatefulWidget {
  final int duration;
  final TimerInstance timerInstance;
  final VoidCallback onSafe;
  final VoidCallback onDanger;

  const SafeConfirmBottomSheet({
    super.key,
    required this.duration,
    required this.timerInstance,
    required this.onSafe,
    required this.onDanger,
  });

  @override
  _SafeConfirmBottomSheetState createState() => _SafeConfirmBottomSheetState();
}

class _SafeConfirmBottomSheetState extends State<SafeConfirmBottomSheet> {
  late StreamSubscription<int> _timerSubscription;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _timerSubscription =
        widget.timerInstance.timerStream.listen((remainingTime) {
      setState(() {
        _remainingTime = remainingTime;
      });
    });
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
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
              Navigator.of(context).pop('safe');
              widget.onSafe();
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
              Navigator.of(context).pop('danger');
              widget.onDanger();
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
