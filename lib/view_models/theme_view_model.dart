import 'package:flutter/widgets.dart';

class ThemeViewModel with ChangeNotifier {
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    if (_darkMode == value) {
      return;
    }

    _darkMode = value;
    notifyListeners();
  }

  bool _darkMode = false;
}
