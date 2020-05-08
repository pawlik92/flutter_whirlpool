import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/view_models/dev_view_model.dart';
import 'package:flutter_whirlpool/view_models/language_view_model.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<DevViewModel>(DevViewModel());
    getIt.registerSingleton<WashingMachineController>(
        WashingMachineController(ballsCount: 16));
    getIt.registerSingleton<TimerViewModel>(TimerViewModel());
    getIt.registerSingleton<MainViewModel>(MainViewModel());
    getIt.registerSingleton<LanguageViewModel>(LanguageViewModel());
  }

  static T get<T>() {
    return getIt.get<T>();
  }
}
