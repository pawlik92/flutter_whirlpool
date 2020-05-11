import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whirlpool/screens/main/main_screen.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:flutter_whirlpool/view_models/settings_view_model.dart';
import 'package:flutter_whirlpool/view_models/theme_view_model.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  ServiceLocator.init();

  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ServiceLocator.get<ThemeViewModel>()),
        ChangeNotifierProvider(
            create: (_) => ServiceLocator.get<SettingsViewModel>()),
        ChangeNotifierProvider(
            create: (_) => ServiceLocator.get<MainViewModel>()),
        ChangeNotifierProvider(
            create: (_) => ServiceLocator.get<TimerViewModel>()),
      ],
      child: MaterialApp(
        title: 'Smart Washing Machine',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
