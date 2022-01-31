import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/settings_view_model.dart';
import 'package:flutter_whirlpool/view_models/theme_view_model.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<SettingsViewModel>(SettingsViewModel());
    getIt.registerSingleton<ThemeViewModel>(ThemeViewModel());
    getIt.registerSingleton<WashingMachineController>(
        WashingMachineController(ballsCount: 16));
    getIt.registerSingleton<TimerViewModel>(TimerViewModel());
    getIt.registerSingleton<MainViewModel>(MainViewModel());
  }

  static T get<T extends Object>() {
    return getIt.get<T>();
  }
}
