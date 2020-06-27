import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/themes.dart';
import 'file:///G:/Flutter/Qurani2_Babs_SplitText/lib/library/Globals.dart'
    as globals;
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Declare SharedPreferences
  SharedPreferences prefs;

  @override
  void initState() {
//    Screen.keepOn(true);
    super.initState();

    /// get Saved preferences
//    getBookmark();
    getBrightnessLevel();
//    getLastViewedPage();
    Timer(Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, 'home'));

//    //   setState(() {
    Screen.setBrightness(globals.brightnessLevel);
////   });
    getFontsLevel();
    getOtherSettings();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// get bookmarkPage from sharedPreferences
//  getLastViewedPage() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    if (prefs.containsKey(globals.LAST_VIEWED_PAGE)) {
//      var _lastViewedPage = prefs.getInt(globals.LAST_VIEWED_PAGE);
//      setState(() {
//        globals.lastViewedPage = _lastViewedPage;
//      });
//    }
//  }

  /// Get saved Brightness or the default value if Brightness level is not defined
  getBrightnessLevel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BRIGHTNESS_LEVEL)) {
      double _brightnessLevel = prefs.getDouble(globals.BRIGHTNESS_LEVEL);
      double _brightnessLevel2;
      setState(() {
        _brightnessLevel2 =
            _brightnessLevel > 1 ? (_brightnessLevel) / 10 : _brightnessLevel;
        globals.brightnessLevel =
            double.parse(_brightnessLevel2.toStringAsFixed(1));
      });
    } else {
      getScreenBrightness();
    }
  }

  /// Get Screen Brightness
  void getScreenBrightness() async {
    double _brightnessLevel3;
    double _brightnessLevel4;

    print(globals.brightnessLevel);
    _brightnessLevel3 = await Screen.brightness;

    _brightnessLevel4 =
        _brightnessLevel3 > 1 ? (_brightnessLevel3) / 10 : (_brightnessLevel3);
    globals.brightnessLevel =
        double.parse(_brightnessLevel4.toStringAsFixed(1));
    print(
        "?????????????????????????         ${globals.brightnessLevel} ?????????????????? Main getScreenBrightness  integer ?????????????");

    print(
        "?????????????????????????         ${_brightnessLevel3} ?????????????????? Main Screen.brightness ?????????????");
  }

  /// Get saved Brightness or the default value if Brightness level is not defined
  getFontsLevel() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.fontArabicLevel = 30;
      globals.fontTarjLevel = 28;
      globals.fontTozihLevel = 30;
    });

    if (prefs.containsKey(globals.FontArabic_LEVEL)) {
      var _fontArabicLevel = prefs.getDouble(globals.FontArabic_LEVEL);
      setState(() {
        globals.fontArabicLevel = _fontArabicLevel;
      });
    }
    if (prefs.containsKey(globals.FontTarj_LEVEL)) {
      var _fontTarjLevel = prefs.getDouble(globals.FontTarj_LEVEL);
      setState(() {
        globals.fontTarjLevel = _fontTarjLevel;
      });
    }
    if (prefs.containsKey(globals.FontTozih_LEVEL)) {
      var _fontTozihLevel = prefs.getDouble(globals.FontTozih_LEVEL);
      setState(() {
        globals.fontTozihLevel = _fontTozihLevel;
      });
    }

    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.fontArabicLevel}             globals.fontArabicLevel');
  }

  getOtherSettings() async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.tarjActive = false;
      globals.tozihActive = false;
      globals.darkMode = false;
    });

    if (prefs.containsKey(globals.TozihActive)) {
      var _tozihActive = prefs.getBool(globals.TozihActive);
      setState(() {
        globals.tozihActive = _tozihActive;
      });
    }
    if (prefs.containsKey(globals.TarjActive)) {
      var _tarjActive = prefs.getBool(globals.TarjActive);
      setState(() {
        globals.tarjActive = _tarjActive;
      });
    }
    if (prefs.containsKey(globals.DarkMode)) {
      var _darkMode = prefs.getBool(globals.DarkMode);
      setState(() {
        globals.darkMode = _darkMode;
//        dark.switchTheme();
      });
    }

    if (globals.darkMode == null) {
      globals.darkMode = false;
    }

//    Provider.of<ThemeNotifier>(context).curretThemeData2;
    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.tozihActive}          globals.tozihActive');
  }

  /// get bookmarkPage from sharedPreferences
//  getBookmark() async {
//    prefs = await SharedPreferences.getInstance();
//    if (prefs.containsKey(globals.BOOKMARKED_PAGE)) {
//      var bookmarkedPage = prefs.getInt(globals.BOOKMARKED_PAGE);
//      setState(() {
//        globals.bookmarkedPage = bookmarkedPage;
//      });
//
//      /// if not found return default value
//    } else {
//      globals.bookmarkedPage = globals.DEFAULT_BOOKMARKED_PAGE;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/startUp.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
