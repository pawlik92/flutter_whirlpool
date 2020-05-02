import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_whirlpool/models/mode_item_model.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';

enum ModeStatus {
  notStarted,
  running,
  paused,
}

class MainViewModel with ChangeNotifier {
  MainViewModel() {
    selectMode(nodes.first);
  }

  List<ModeItemModel> nodes = const [
    ModeItemModel(
        name: 'Standard', minutes: 32, color: Color.fromRGBO(61, 111, 252, 1)),
    ModeItemModel(
      name: 'Gentle',
      minutes: 24,
      color: Color.fromRGBO(50, 197, 253, 1),
    ),
    ModeItemModel(
      name: 'Fast',
      minutes: 12,
      color: Color.fromRGBO(253, 133, 53, 1),
    ),
  ];

  double get waterValue => _waterValue;
  set waterValue(double value) {
    _waterValue = value;
    notifyListeners();
  }

  ModeItemModel get selectedMode => _selectedMode;
  ModeStatus get modeStatus => _modeStatus;

  double _waterValue = 600.0;
  ModeItemModel _selectedMode;
  ModeStatus _modeStatus = ModeStatus.notStarted;

  runOrPause() {
    if (selectedMode == null) {
      return;
    }

    var timerVM = ServiceLocator.get<TimerViewModel>();

    if (modeStatus == ModeStatus.running) {
      _modeStatus = ModeStatus.paused;
      timerVM.pause();
    } else if (modeStatus == ModeStatus.paused) {
      _modeStatus = ModeStatus.running;
      timerVM.resume();
    } else if (modeStatus == ModeStatus.notStarted) {
      _modeStatus = ModeStatus.running;
      timerVM.start(Duration(minutes: selectedMode.minutes));
    }

    notifyListeners();
  }

  selectMode(ModeItemModel mode) {
    if (mode == _selectedMode) {
      return;
    }
    if (_modeStatus == ModeStatus.running) {
      return;
    }
    _selectedMode = mode;
    _modeStatus = ModeStatus.notStarted;

    var timerVM = ServiceLocator.get<TimerViewModel>();
    timerVM.reset(callNotifyListeners: true);
    notifyListeners();
  }
}
