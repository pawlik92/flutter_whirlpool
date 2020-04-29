import 'package:flutter/foundation.dart';

class MainViewModel with ChangeNotifier {
  double get waterValue => _waterValue;
  set waterValue(value) {
    _waterValue = value;
    notifyListeners();
  }

  double _waterValue = 600.0;

  // void increment() {
  //   _count++;
  //   notifyListeners();
  // }
}
