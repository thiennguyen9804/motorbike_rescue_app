import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';

class NeedConfirmNoti extends StatefulWidget {
  final int duration;
  final TimerHelper sharedTimer;
  final VoidCallback onTap;
  const NeedConfirmNoti({
    super.key,
    required this.duration,
    required this.sharedTimer,
    required this.onTap,
  });
  @override
  _NeedConfirmNotiState createState() => _NeedConfirmNotiState();
}

class _NeedConfirmNotiState extends State<NeedConfirmNoti> {
  late StreamSubscription<int> _timerSubscription;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _timerSubscription = widget.sharedTimer.timerStream.listen((remainingTime) {
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
              color: AppTheme.bgWarning,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: AppTheme.txtOnWarning,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_remainingTime',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppTheme.txtOnWarning,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Hãy xác nhận bạn\nvẫn đang an toàn',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.txtOnWarning,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
