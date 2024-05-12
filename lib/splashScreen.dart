import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Declare SharedPreferences
  late SharedPreferences prefs;
  var dark;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 0),
        () => Navigator.pushReplacementNamed(context, 'home'));
    getFontsLevel();
    getOtherSettings();
    getScreenBrightness();
    getBrightnessLevel();
  }
  @override
  void dispose() {
    super.dispose();
  }

  /// Get saved Brightness or the default value if Brightness level is not defined
  getBrightnessLevel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BRIGHTNESS_LEVEL) &&
        globals.brightnessActive!) {
      double? _brightnessLevel = prefs.getDouble(globals.BRIGHTNESS_LEVEL);
      double? _brightnessLevel2;
      setState(() {
        _brightnessLevel2 =
            _brightnessLevel! > 1 ? (_brightnessLevel) / 10 : _brightnessLevel;
        globals.brightnessLevel =
            double.parse(_brightnessLevel2!.toStringAsFixed(2));
      });

      ScreenBrightness().setScreenBrightness(globals.brightnessLevel!);
    } else {
      // getScreenBrightness();
    }
  }

  /// Get Screen Brightness
  void getScreenBrightness() async {
    double _brightnessLevel3;
    double _brightnessLevel4;

    print(globals.brightnessLevel);
    _brightnessLevel3 = await ScreenBrightness().current;

    _brightnessLevel4 =
        _brightnessLevel3 > 1 ? (_brightnessLevel3) / 10 : (_brightnessLevel3);
    globals.brightnessLevelDefault =
        double.parse(_brightnessLevel4.toStringAsFixed(2));
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

  bool? _darkMode;
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

    // if (prefs.containsKey(globals.EdameFaraz)) {
    //   var _edameFaraz = prefs.getBool(globals.EdameFaraz);
    //   setState(() {
    //     globals.edameFaraz = _edameFaraz;
    //   });
    // }
   print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.tozihActive}          globals.tozihActive');
  }

  @override
  Widget build(BuildContext context) {
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
