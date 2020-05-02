import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<TimerViewModel>(TimerViewModel());
    getIt.registerSingleton<MainViewModel>(MainViewModel());
  }

  static T get<T>() {
    return getIt.get<T>();
  }
}
