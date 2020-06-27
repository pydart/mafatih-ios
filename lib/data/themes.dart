import 'package:flutter/material.dart';
import 'file:///G:/Flutter/Qurani2_Babs_SplitText/lib/library/Globals.dart'
    as globals;

enum MyTheme { light, dark }

class ThemeNotifier with ChangeNotifier {
  static bool _darkmode = false;
  static List<ThemeData> themes = [
    ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0xf6f6f6f6)),
//        scaffoldBackgroundColor: Colors.transparent),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      canvasColor: Colors.black,
    ),
  ];

  MyTheme _current = MyTheme.light;
//  ThemeData _currentTheme2 = globals.darkMode ? themes[1] : themes[0];
  ThemeData _currentTheme = themes[0];

  void switchTheme() {
    if (globals.darkMode == null) {
      globals.darkMode = false;
    }
    darkmode = globals.darkMode;
    currentTheme == MyTheme.light
//    currentTheme == darkmode
        ? currentTheme = MyTheme.dark
        : currentTheme = MyTheme.light;
  }

  set currentTheme(theme) {
    if (theme != null) {
      _current = theme;
      _currentTheme = _current == MyTheme.light ? themes[0] : themes[1];
      notifyListeners();
    }
  }

  set darkmode(newvValue) {
    _darkmode = newvValue;
    notifyListeners();
  }

  get currentTheme => _current;
  get curretThemeData => _currentTheme;
//  get curretThemeData2 => _currentTheme2;

  get darkmode => _darkmode;
}
