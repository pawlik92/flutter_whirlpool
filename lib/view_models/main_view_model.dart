import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_whirlpool/models/mode_item_model.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
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
      name: 'Standard',
      minutes: 32,
      color: Color.fromRGBO(61, 111, 252, 1),
    ),
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
    var washingMachineController =
        ServiceLocator.get<WashingMachineController>();

    if (modeStatus == ModeStatus.running) {
      _modeStatus = ModeStatus.paused;
      timerVM.pause();
      washingMachineController.setAngularVelocity(0, seconds: 1);
    } else if (modeStatus == ModeStatus.paused) {
      _modeStatus = ModeStatus.running;
      washingMachineController.setAngularVelocity(-15, seconds: 7);
      timerVM.resume();
    } else if (modeStatus == ModeStatus.notStarted) {
      _modeStatus = ModeStatus.running;

      if (!washingMachineController.hasBalls()) {
        washingMachineController.initializeBalls();
      }

      timerVM.start(Duration(minutes: selectedMode.minutes));

      Timer.periodic(
          Duration(seconds: !washingMachineController.hasBalls() ? 2 : 0),
          (timer) {
        timer.cancel();
        if (modeStatus != ModeStatus.running) {
          return;
        }

        washingMachineController.setAngularVelocity(-15, seconds: 7);
      });
    }

    notifyListeners();
  }

  stop() {
    var washingMachineController =
        ServiceLocator.get<WashingMachineController>();
    var timerVM = ServiceLocator.get<TimerViewModel>();

    washingMachineController.setAngularVelocity(0, seconds: 3);
    _modeStatus = ModeStatus.notStarted;
    timerVM.reset(callNotifyListeners: true);

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

    int sign = Random().nextBool() ? 1 : -1;
    ServiceLocator.get<WashingMachineController>()
        .setAngularVelocity(9.0 * sign, stopAtEnd: true, seconds: 0.6);
  }
}
