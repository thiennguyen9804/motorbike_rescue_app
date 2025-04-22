import 'dart:async';

import 'package:flutter/material.dart';

class TimerHelper {
  late int _remainingTime;
  late Timer _timer;
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();

  late VoidCallback onTimerDone;

  Stream<int> get timerStream => _timerController.stream;

  Timer getTimer() {
    return _timer;
  }

  void startTimer(int duration) {
    _remainingTime = duration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        _timerController.add(_remainingTime);
      } else {
        _timer.cancel();
        _timerController.add(0);
        onTimerDone();
      }
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timerController.close();
    print('timer cancel');
  }

  void resetTimer(int duration) {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _remainingTime = duration;
    _timerController.add(_remainingTime); // cập nhật ngay thời gian mới
    startTimer(duration);
  }
}
