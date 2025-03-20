import 'dart:async';

class TimerInstance {
  TimerInstance._privateConstructor();

  static final TimerInstance _instance = TimerInstance._privateConstructor();

  factory TimerInstance() {
    return _instance;
  }

  late int _remainingTime;
  late Timer _timer;
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();

  Stream<int> get timerStream => _timerController.stream;

  void startTimer(int duration) {
    _remainingTime = duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        _timerController.add(_remainingTime);
      } else {
        _timer.cancel();
        _timerController.add(0);
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    _timerController.close();
  }
}
