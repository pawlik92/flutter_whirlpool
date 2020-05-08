import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_whirlpool/screens/main/main_screen.dart';
import 'package:flutter_whirlpool/view_models/dev_view_model.dart';
import 'package:flutter_whirlpool/view_models/language_view_model.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:provider/provider.dart';

import 'core/lang/app_localizations.dart';

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
              create: (_) => ServiceLocator.get<DevViewModel>()),
          ChangeNotifierProvider(
              create: (_) => ServiceLocator.get<MainViewModel>()),
          ChangeNotifierProvider(
              create: (_) => ServiceLocator.get<TimerViewModel>()),
          ChangeNotifierProvider(
              create: (_) => ServiceLocator.get<LanguageViewModel>()),
        ],
        child: Consumer<LanguageViewModel>(
          builder: (context, model, child) {
            return MaterialApp(
              locale: model.appLocal,
              title: 'Smart Washing Machine',
              // List all of the app's supported locales here
              supportedLocales: [
                Locale('en', 'US'),
                Locale('fa', 'IR'),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: model.isRTL ? "Vazir" : null),
              home: MainScreen(),
            );
          },
        ));
  }
}
