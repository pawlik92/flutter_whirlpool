import 'package:flutter/material.dart';

class LanguageViewModel extends ChangeNotifier {
  Locale get appLocal => _appLocale ?? Locale("en");
  bool get isRTL =>
      (_appLocale?.languageCode?.compareTo("fa") ?? -1) == 0 ? true : false;

  set appLocal(Locale type) {
    if (type == Locale("en")) {
      _appLocale = Locale("fa");
    } else {
      _appLocale = Locale("en");
    }
    notifyListeners();
  }

  Locale _appLocale = Locale('en');
}
