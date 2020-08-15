import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:mafatih/ui/widget/favorites.dart';

enum MyTheme { light, dark }

class ThemeNotifier with ChangeNotifier {
  static bool _darkmode = false;
  static List<ThemeData> themes = [
    ThemeData(
      brightness: Brightness.light,
      buttonColor: Color.fromRGBO(155, 15, 15, 1),
      primarySwatch: Colors.green,
      accentColor: Colors.grey[900],
      scaffoldBackgroundColor: Color(0xf6f6f6f6),
      canvasColor: Color.fromRGBO(255, 255, 255, 1),
    ),

//        scaffoldBackgroundColor: Colors.transparent),
    ThemeData(
      brightness: Brightness.dark,
      buttonColor: Colors.green,
      primarySwatch: Colors.green,
      canvasColor: Colors.black87,
      accentColor: Colors.white70,
    ),
  ];

  MyTheme _current = MyTheme.light;
//  ThemeData _currentTheme2 = globals.darkMode ? themes[1] : themes[0];
//  ThemeData _currentTheme =
//      prefs.getBool(globals.DarkMode) == null ? themes[1] : themes[0];

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
