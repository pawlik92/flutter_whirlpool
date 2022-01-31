import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:flutter_whirlpool/view_models/theme_view_model.dart';

class CustomColors {
  static bool get isDarkMode => ServiceLocator.get<ThemeViewModel>().darkMode;

  static Color get primaryColor =>
      isDarkMode ? _primaryColorDark : _primaryColorLight;
  static Color get container => isDarkMode ? _containerDark : _containerLight;
  static Color get containerPressed =>
      isDarkMode ? _containerPressedDark : _containerPressedLight;
  static Color get containerShadowTop =>
      isDarkMode ? _containerShadowTopDark : _containerShadowTopLight;
  static Color get containerShadowBottom =>
      isDarkMode ? _containerShadowBottomDark : _containerShadowBottomLight;
  static Color get containerInnerShadowTop =>
      isDarkMode ? _containerInnerShadowTopDark : _containerInnerShadowTopLight;
  static Color get containerInnerShadowBottom => isDarkMode
      ? _containerInnerShadowBottomDark
      : _containerInnerShadowBottomLight;
  static Color get primaryTextColor =>
      isDarkMode ? _primaryTextColorDark : _primaryTextColorLight;
  static Color get secondaryTextColor =>
      isDarkMode ? _secondaryTextColorDark : _secondaryTextColorLight;
  static Color get icon => isDarkMode ? _iconDark : _iconLight;
  static Color get indicatorBackground =>
      isDarkMode ? _indicatorBackgroundDark : _indicatorBackgroundLight;
  static Color get timerPanelBorder =>
      isDarkMode ? _timerPanelBorderDark : _timerPanelBorderLight;

  static Color get drumBorder =>
      isDarkMode ? _drumBorderDark : _drumBorderLight;
  static Color get drumBackground =>
      isDarkMode ? _drumBackgroundDark : _drumBackgroundLight;
  static Color get drumRibBackground =>
      isDarkMode ? _drumRibBackgroundDark : _drumRibBackgroundLight;
  static Color get drumRibForeground =>
      isDarkMode ? _drumRibForegroundDark : _drumRibForegroundLight;
  static List<Color> get drumInnerShadowColors =>
      isDarkMode ? _drumInnerShadowColorsDark : _drumInnerShadowColorsLight;
  static List<Color> get drumRing1Colors =>
      isDarkMode ? _drumRing1ColorsDark : _drumRing1ColorsLight;
  static List<Color> get drumRing2Colors =>
      isDarkMode ? _drumRing2ColorsDark : _drumRing2ColorsLight;
  static List<Color> get drumRing3Colors =>
      isDarkMode ? _drumRing3ColorsDark : _drumRing3ColorsLight;

  static Color _primaryColorLight = Color.fromRGBO(235, 240, 243, 1);
  static Color _primaryColorDark = Color.fromRGBO(32, 35, 41, 1);

  static Color _containerLight = Color.fromRGBO(241, 245, 248, 1);
  static Color _containerDark = Color.fromRGBO(40, 50, 54, 1);

  static Color _containerPressedLight = Color.fromRGBO(232, 235, 241, 1);
  static Color _containerPressedDark = Color.fromRGBO(45, 50, 54, 1);

  static Color _containerShadowTopLight = Color.fromARGB(220, 255, 255, 255);
  static Color _containerShadowTopDark = Color.fromRGBO(255, 255, 255, 0.1);

  static Color _containerShadowBottomLight = Color.fromARGB(18, 0, 0, 0);
  static Color _containerShadowBottomDark = Color.fromRGBO(0, 0, 0, .3);

  static Color _containerInnerShadowTopLight = Color.fromRGBO(204, 206, 212, 1);
  static Color _containerInnerShadowTopDark = Color.fromRGBO(0, 0, 0, .9);

  static Color _containerInnerShadowBottomLight =
      Color.fromRGBO(255, 255, 255, 1);
  static Color _containerInnerShadowBottomDark = Color.fromRGBO(49, 54, 60, 1);

  static Color _primaryTextColorLight = Color.fromRGBO(53, 54, 59, 1);
  static Color _primaryTextColorDark = Color.fromRGBO(255, 255, 255, 1);

  static Color _secondaryTextColorLight = Color.fromRGBO(144, 149, 166, 1);
  static Color _secondaryTextColorDark = Color.fromRGBO(139, 144, 160, 1);

  static Color _iconLight = Color.fromRGBO(144, 149, 166, 1);
  static Color _iconDark = Color.fromRGBO(137, 142, 158, 1);

  static Color _indicatorBackgroundLight = Color.fromRGBO(255, 255, 255, 1);
  static Color _indicatorBackgroundDark = _containerDark;

  static Color _timerPanelBorderLight = Color.fromRGBO(255, 255, 255, 1);
  static Color _timerPanelBorderDark = Color.fromRGBO(255, 255, 255, .35);

  static Color _drumBorderLight = Color.fromRGBO(223, 229, 232, 1);
  static Color _drumBorderDark = Color.fromRGBO(32, 35, 40, 1);

  static Color _drumBackgroundLight = Color.fromARGB(255, 233, 244, 249);
  static Color _drumBackgroundDark = Color.fromRGBO(32, 35, 41, 1);

  static Color _drumRibBackgroundLight = Color.fromARGB(255, 228, 238, 247);
  static Color _drumRibBackgroundDark = Color.fromRGBO(32, 33, 39, 1);

  static Color _drumRibForegroundLight = Color.fromARGB(255, 236, 244, 250);
  static Color _drumRibForegroundDark = Color.fromRGBO(46, 49, 56, 1);

  static List<Color> _drumInnerShadowColorsLight = [
    Color.fromARGB(20, 255, 255, 255),
    Color.fromARGB(140, 202, 213, 225),
  ];
  static List<Color> _drumInnerShadowColorsDark = [
    Color.fromARGB(10, 0, 0, 0),
    Color.fromARGB(60, 0, 0, 0),
  ];

  static List<Color> _drumRing1ColorsLight = [
    Color.fromRGBO(248, 250, 251, 1),
    Color.fromRGBO(243, 246, 248, 1),
    Color.fromRGBO(221, 228, 236, 1),
  ];
  static List<Color> _drumRing1ColorsDark = [
    Color.fromRGBO(45, 50, 57, 1),
    Color.fromRGBO(46, 51, 57, 1),
    Color.fromRGBO(28, 30, 35, 1),
  ];

  static List<Color> _drumRing2ColorsLight = [
    container,
    container,
    container,
  ];
  static List<Color> _drumRing2ColorsDark = [
    Color.fromRGBO(55, 61, 68, 1),
    Color.fromRGBO(45, 50, 57, 1),
    Color.fromRGBO(32, 35, 41, 1),
  ];

  static List<Color> _drumRing3ColorsLight = [
    Color.fromRGBO(205, 216, 227, 1),
    Color.fromRGBO(207, 218, 228, 1),
    Color.fromRGBO(243, 245, 247, 1),
  ];
  static List<Color> _drumRing3ColorsDark = [
    Color.fromRGBO(27, 29, 34, 1),
    Color.fromRGBO(34, 38, 43, 1),
    Color.fromRGBO(51, 57, 64, 1),
  ];
}
