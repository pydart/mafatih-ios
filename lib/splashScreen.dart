import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Declare SharedPreferences
  SharedPreferences prefs;
  var dark;

  @override
  void initState() {
    super.initState();
    // _getAudioList();
    /// get Saved preferences
//    getBookmark();
//    getLastViewedPage();
    Timer(Duration(milliseconds: 0),
        () => Navigator.pushReplacementNamed(context, 'home'));

//    //   setState(() {
////   });
    getFontsLevel();
    getOtherSettings();
    getScreenBrightness();
    getBrightnessLevel();
  }
  // _getAudioList() async {
  //   print("******************************************_getAudioList  STARTED****************************************");
  //
  //   try {
  //     http.Response response =
  //     await http.get(Constants.audiosListUrl).whenComplete(() {});
  //     if (response.statusCode == 200) {
  //       var Results = response.body;
  //       print("**********************************************************************************_getAudioList    $Results");
  //     } else {
  //       throw Exception('Failed to load');
  //     }
  //   } catch (e) {
  //     print("Exception Caught: $e");
  //   }
  // }
  @override
  void dispose() {
    super.dispose();
  }

  /// Get saved Brightness or the default value if Brightness level is not defined
  getBrightnessLevel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BRIGHTNESS_LEVEL) &&
        globals.brightnessActive) {
      double _brightnessLevel = prefs.getDouble(globals.BRIGHTNESS_LEVEL);
      double _brightnessLevel2;
      setState(() {
        _brightnessLevel2 =
            _brightnessLevel > 1 ? (_brightnessLevel) / 10 : _brightnessLevel;
        globals.brightnessLevel =
            double.parse(_brightnessLevel2.toStringAsFixed(2));
      });

      FlutterScreen.setBrightness(globals.brightnessLevel);
    } else {
      // getScreenBrightness();
    }
  }

  /// Get Screen Brightness
  void getScreenBrightness() async {
    double _brightnessLevel3;
    double _brightnessLevel4;

    print(globals.brightnessLevel);
    _brightnessLevel3 = await FlutterScreen.brightness;

    _brightnessLevel4 =
        _brightnessLevel3 > 1 ? (_brightnessLevel3) / 10 : (_brightnessLevel3);
    globals.brightnessLevelDefault =
        double.parse(_brightnessLevel4.toStringAsFixed(2));
    // globals.brightnessLevelDefault = globals.brightnessLevel;
  }

  /// Get saved Brightness or the default value if Brightness level is not defined
  getFontsLevel() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.fontArabic = 'نیریزی دو';
      globals.fontArabicLevel = 25;
      globals.fontTarjLevel = 21;
      globals.fontTozihLevel = 25;
    });

    if (prefs.containsKey(globals.FontArabic_LEVEL)) {
      var _fontArabicLevel = prefs.getDouble(globals.FontArabic_LEVEL);
      setState(() {
        globals.fontArabicLevel = _fontArabicLevel;
      });
    }

    if (prefs.containsKey(globals.FontArabic)) {
      var _fontArabic = prefs.getString(globals.FontArabic);
      setState(() {
        globals.fontArabic = _fontArabic;
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

  bool _darkMode;
  getOtherSettings() async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.tarjActive = true;
      globals.tozihActive = false;
      globals.darkMode = false;
      globals.brightnessActive = false;
    });

    if (prefs.containsKey(globals.BrightnessActive)) {
      var _BrightnessActive = prefs.getBool(globals.BrightnessActive);
      setState(() {
        globals.brightnessActive = _BrightnessActive;
      });
    }

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
      _darkMode = prefs.getBool(globals.DarkMode);
      setState(() {
        globals.darkMode = false;
      });
    }

    if (globals.darkMode == null) {
      globals.darkMode = false;
    }

//    Provider.of<ThemeNotifier>(context).curretThemeData2;
    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.tozihActive}          globals.tozihActive');
  }

  @override
  Widget build(BuildContext context) {
//    dark = Provider.of<ThemeNotifier>(context);
//    _darkMode ?? dark.switchTheme();

    return Scaffold(
        body: new SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/startUp0.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ));
  }
}
