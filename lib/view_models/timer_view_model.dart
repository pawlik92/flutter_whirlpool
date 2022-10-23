import 'package:flutter/foundation.dart';
import 'package:quiver/async.dart';

class TimerViewModel with ChangeNotifier {
  Duration? get remaining {
    if (_pausedRemaining != null) {
      return _pausedRemaining;
    }

    return _countdownTimer?.isRunning == true
        ? _countdownTimer?.remaining
        : Duration.zero;
  }

  String get remainigString {
    int totalSeconds = remaining!.inSeconds;
    int minutes = (totalSeconds / 60).floor();
    int seconds = totalSeconds % 60;

    String minutesString = minutes > 9 ? minutes.toString() : '0$minutes';
    String secondsString = seconds > 9 ? seconds.toString() : '0$seconds';

    return '$minutesString:$secondsString';
  }

  CountdownTimer? _countdownTimer;
  Duration? _pausedRemaining;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  start(Duration? duration) {
    if (duration == null) {
      return;
    }
    reset(callNotifyListeners: true);

    _countdownTimer = CountdownTimer(duration, const Duration(seconds: 1));
    _countdownTimer!.listen((timer) => notifyListeners());
  }

  resume() {
    start(_pausedRemaining);
  }

  reset({bool? callNotifyListeners}) {
    _pausedRemaining = null;
    _countdownTimer?.cancel();

    if (callNotifyListeners == true) {
      notifyListeners();
    }
  }

  pause() {
    _pausedRemaining = remaining;
    _countdownTimer?.cancel();
    notifyListeners();
  }
}
