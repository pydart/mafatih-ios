import 'package:screen/screen.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/ui/widget/cardsetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double tempBrightnessLevel = globals.brightnessLevel;
  double tempFontArabicLevel = globals.fontArabicLevel;
  double tempFontTarjLevel = globals.fontTarjLevel;
  double tempFontTozihLevel = globals.fontTozihLevel;

//  double tempFontArabicLevel = 23;
//  double tempFontTarjLevel = 21;
//  double tempFontTozihLevel = 25;

  bool tempTarjActive = globals.tarjActive;
  bool tempTozihActive = globals.tozihActive;
  bool tempDarkMode = globals.darkMode;

  SharedPreferences prefs;
  setBrightnessLevel(double level) async {
    globals.brightnessLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.BRIGHTNESS_LEVEL, level);
  }

  setFontArabicLevel(double level) async {
    globals.fontArabicLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.FontArabic_LEVEL, level);
  }

  setFontTarjLevel(double level) async {
    globals.fontTarjLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.FontTarj_LEVEL, level);
  }

  setFontTozihLevel(double level) async {
    globals.fontTozihLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.FontTozih_LEVEL, level);
  }

  setTarjActive(bool level) async {
    globals.tarjActive = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.TarjActive, level);
  }

  setTozihActive(bool level) async {
    globals.tozihActive = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.TozihActive, level);
  }

  setDarkModeActive(bool level) async {
    globals.darkMode = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.DarkMode, level);
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    var dark = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('تنظیمات'),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          CardSetting(
            title: 'تم تاریک',
            leading: Switch(
              activeColor: Colors.green,

              value: tempDarkMode,
//              value: tempDarkMode,
              onChanged: (newValue) {
                setState(() {
                  tempDarkMode = newValue;
//                    ui.fontSizeTozih = newValue;
                  setDarkModeActive(newValue);
                  globals.darkMode = newValue;
                  dark.switchTheme();
                });
              },
            ),
          ),
          CardSetting(
            title: 'ترجمه',
            leading: Switch(
              activeColor: Colors.green,
              value: tempTarjActive,
              onChanged: (newValue) {
                setState(() {
                  ui.terjemahan = newValue;
                  tempTarjActive = newValue;
                  setTarjActive(newValue);
                });
              },
            ),
          ),
//          CardSetting(
//            title: 'توضیحات',
//            leading: Switch(
//              value: tempTozihActive,
//              onChanged: (newValue) {
//                setState(() {
//                  ui.tafsir = newValue;
//                  tempTozihActive = newValue;
//                  setTozihActive(newValue);
//                });
//              },
//            ),
//          ),
          CardSlider(
            title: 'سایز متن توضیحات ',
            slider: Slider(
                min: 14,
                max: 1.5 * 30,
//                value: ui.sliderfontSizeTozih,
                value: tempFontTozihLevel,
                onChanged: (newValue) {
                  setState(() {
                    tempFontTozihLevel = newValue;
                    ui.fontSizeTozih = newValue;
                    setFontTozihLevel(newValue);
                  });
                }),
//            trailing: ui.fontSizeTozih.toInt().toString(),
            trailing: tempFontTozihLevel.toInt().toString(),
          ),
          CardSlider(
            title: 'سایز متن فارسی ',
            slider: Slider(
                min: 14,
                max: 1.5 * 30,
                value: tempFontTarjLevel,
                onChanged: (newValue) {
                  setState(() {
                    tempFontTarjLevel = newValue;
                    ui.fontSizetext = newValue;
                    setFontTarjLevel(newValue);
                  });
                }),
            trailing: tempFontTarjLevel.toInt().toString(),
          ),
          CardSlider(
            title: 'سایز متن عربی',
            slider: Slider(
                min: 14,
                max: 1.5 * 30,
                value: tempFontArabicLevel,
                onChanged: (newValue) {
                  setState(() {
                    ui.fontSize = newValue;
                    tempFontArabicLevel = newValue;
                    setFontArabicLevel(newValue);
                  });
                }),
            trailing: tempFontArabicLevel.toInt().toString(),
          ),
          CardSlider(
            title: 'نور صفحه',
            slider: Slider(
              min: 0.1,
              max: 1,
              divisions: 10,
              value: tempBrightnessLevel,
              onChanged: (newValue) {
                setState(() {
                  tempBrightnessLevel =
                      double.parse(newValue.toStringAsFixed(1));
                });
                Screen.setBrightness(tempBrightnessLevel);
//                  ui.lightlevel = newValue;
                setBrightnessLevel(tempBrightnessLevel);
              },
            ),
            trailing: (tempBrightnessLevel * 10).toInt().toString(),
          ),
        ],
      ),
    );
  }
}

class CardSlider extends StatelessWidget {
  const CardSlider({
    Key key,
    @required this.title,
    @required this.slider,
    @required this.trailing,
  }) : super(key: key);

  final String title;
  final Widget slider;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 10, right: 30, left: 15),
          title: Text(title),
          subtitle: slider,
          trailing: Text(trailing,
              style: TextStyle(fontFamily: 'far_nazanin', fontSize: 22)),
        ),
      ),
    );
  }
}
