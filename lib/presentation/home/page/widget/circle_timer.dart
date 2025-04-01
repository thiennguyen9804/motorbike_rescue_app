import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';

class CircleTimer extends StatefulWidget {
  final int duration;
  final VoidCallback onTimerComplete;
  final TimerHelper timerInstance;

  const CircleTimer({
    super.key,
    required this.duration,
    required this.onTimerComplete,
    required this.timerInstance,
  });

  @override
  _CircleTimerState createState() => _CircleTimerState();
}

class _CircleTimerState extends State<CircleTimer> {
  late Timer _timer;
  late int _remainingTime;
  StreamSubscription<int>? _subscription;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    // _startTimer();
    _startListen();
  }

  void _startListen() {
    _subscription = widget.timerInstance.timerStream.listen((time) {
      setState(() {
        _remainingTime = time;
      });
      if (_remainingTime == 0) {
        widget.onTimerComplete();
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
    return CustomPaint(
      size: const Size(24, 24),
      painter: CircleTimerPainter(_remainingTime / widget.duration),
    );
  }
}

class CircleTimerPainter extends CustomPainter {
  final double progress;

  CircleTimerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the background circle
    canvas.drawCircle(center, radius, paint);

    // Draw the progress arc
    final progressPaint = Paint()
      ..color = Color(0xff323232) // Change the color to make it visible
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final sweepAngle = 2 * 3.141592653589793 * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
