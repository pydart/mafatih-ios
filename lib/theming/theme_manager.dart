import 'package:flutter/material.dart';
import '../theming/storage_manager.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class ThemeNotifiermine with ChangeNotifier {
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    buttonColor: Colors.green,
    primarySwatch: Colors.green,
    canvasColor: Colors.black87,
    accentColor: Colors.white70,
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    buttonColor: Color.fromRGBO(155, 15, 15, 1),
    primarySwatch: Colors.green,
    accentColor: Colors.grey[900],
    scaffoldBackgroundColor: Color(0xf6f6f6f6),
    canvasColor: Color.fromRGBO(255, 255, 255, 1),
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        globals.themeType = false;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
        globals.themeType = true;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    globals.themeType = true;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    globals.themeType = false;
    notifyListeners();
  }
}
