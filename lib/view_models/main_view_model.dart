import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_whirlpool/models/mode_item_model.dart';

class MainViewModel with ChangeNotifier {
  MainViewModel() {
    selectedMode = nodes.first;
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
  set selectedMode(ModeItemModel value) {
    _selectedMode = value;
    notifyListeners();
  }

  double _waterValue = 600.0;
  ModeItemModel _selectedMode;
}
