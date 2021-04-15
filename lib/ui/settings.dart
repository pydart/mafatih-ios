import 'package:flutter_screen/flutter_screen.dart';
// import 'package:screen/screen.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/ui/widget/cardsetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import 'package:shared_preferences/shared_preferences.dart';

import 'home2.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double tempBrightnessLevel = globals.brightnessLevel == null
      ? globals.brightnessLevelDefault
      : globals.brightnessLevel;
  double tempFontArabicLevel = globals.fontArabicLevel;
  double tempFontTarjLevel = globals.fontTarjLevel;
  double tempFontTozihLevel = globals.fontTozihLevel;
  String tempFontArabic = globals.fontArabic;
  // List FontArabicList = ['نیریزی'];
  double briValue;
  List FontArabicList = [
    'نیریزی یک',
    'نیریزی دو',
    'عربی ساده',
    'زر',
    'القلم',
  ];

  bool tempTarjActive = globals.tarjActive;
  bool tempTozihActive = globals.tozihActive;
  // bool tempDarkMode = globals.darkMode;
  bool themeType = globals.themeType;
  bool brightnessActive = globals.brightnessActive;

  SharedPreferences prefs;
  setBrightnessLevel(double level) async {
    globals.brightnessLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.BRIGHTNESS_LEVEL, level);
  }

  setBrightnessActive(bool level) async {
    globals.brightnessActive = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.BrightnessActive, level);
  }

  setFontArabicLevel(double level) async {
    globals.fontArabicLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.FontArabic_LEVEL, level);
  }

  setFontArabic(String level) async {
    globals.fontArabic = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setString(globals.FontArabic, level);
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

  setThemeType(bool level) async {
    globals.themeType = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.ThemeType, globals.themeType);
  }

  setTozihActive(bool level) async {
    globals.tozihActive = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.TozihActive, level);
  }

  // setDarkModeActive(bool level) async {
  //   globals.darkMode = level;
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(globals.DarkMode, level);
  // }

  void getScreenBrightness() async {
    double _brightnessLevel3;
    double _brightnessLevel4;
    _brightnessLevel3 = await FlutterScreen.brightness;
    _brightnessLevel4 =
        _brightnessLevel3 > 1 ? (_brightnessLevel3) / 10 : (_brightnessLevel3);
    globals.brightnessLevel =
        double.parse(_brightnessLevel4.toStringAsFixed(2));
    FlutterScreen.setBrightness(globals.brightnessLevel);
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

              value: themeType,
//              value: tempDarkMode,
              onChanged: (newValue) {
                setState(() {
                  themeType = newValue;
//                    ui.fontSizeTozih = newValue;
//                   setDarkModeActive(newValue);
                  globals.darkMode = newValue;
                  dark.switchTheme();
                  setThemeType(newValue);
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
          CardSetting(
            title: 'تغییر فونت عربی مفاتیح',
            leading: DropdownButton(
                value: FontArabicList.indexOf(tempFontArabic),
                items: [
                  DropdownMenuItem(
                    child: Text(FontArabicList[0]),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(FontArabicList[1]),
                    value: 1,
                  ),
                  DropdownMenuItem(child: Text(FontArabicList[2]), value: 2),
                  DropdownMenuItem(child: Text(FontArabicList[3]), value: 3),
                  DropdownMenuItem(child: Text(FontArabicList[4]), value: 4)
                ],
                onChanged: (value) {
                  setState(() {
                    tempFontArabic = FontArabicList[value];
                    ui.fontFormat = tempFontArabic;
                    setFontArabic(FontArabicList[value]);
                  });
                }),
          ),
          CardSetting(
            title: 'فعالسازی تنظیم نور صفحه',
            leading: Switch(
              activeColor: Colors.green,

              value: brightnessActive,
//              value: tempDarkMode,
              onChanged: (newValue) {
                setState(() {
                  brightnessActive = newValue;
                  globals.brightnessActive = newValue;
                  setBrightnessActive(newValue);
                  brightnessActive
                      ? FlutterScreen.setBrightness(tempBrightnessLevel)
                      : FlutterScreen.resetBrightness();

                  // : Screen.setBrightness(globals.brightnessLevelDefault);
                });
              },
            ),
          ),
          brightnessActive
              ? CardSlider(
                  title: 'نور صفحه',
                  slider: Slider(
                    min: 0,
                    max: 100,
                    divisions: 101,
                    value: tempBrightnessLevel * 100,
                    onChanged: (newValue) {
                      setState(() {
                        briValue = newValue / 100;
                        tempBrightnessLevel =
                            double.parse(briValue.toStringAsFixed(2));
                      });
                      FlutterScreen.setBrightness(tempBrightnessLevel);
//                  ui.lightlevel = newValue;
                      setBrightnessLevel(tempBrightnessLevel);
                    },
                  ),
                  trailing: (tempBrightnessLevel * 100).toInt().toString(),
                )
              : Container(),
          CardSetting(
            title: 'بازگشت به تنظیمات اولیه',
            leading: RaisedButton(
              elevation: 0,
              color: Colors.green,
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
              ),

              onPressed: () {
                setState(() {
                  FlutterScreen.resetBrightness();
                  tempFontArabicLevel = 25;
                  tempFontTarjLevel = 21;
                  tempFontTozihLevel = 25;
                  tempTarjActive = true;
                  themeType = false;
                  brightnessActive = false;
                  tempFontArabic = 'نیریزی دو';
                });
                if (globals.themeType) {
                  dark.switchTheme();
                  // setDarkModeActive(themeType);
                  globals.themeType = themeType;
                  setThemeType(themeType);
                }
                ui.terjemahan = tempTarjActive;
                setTarjActive(tempTarjActive);
                ui.fontSizeTozih = tempFontTozihLevel;
                setFontTozihLevel(tempFontTozihLevel);
                ui.fontSizetext = tempFontTarjLevel;
                setFontTarjLevel(tempFontTarjLevel);
                ui.fontSize = tempFontArabicLevel;
                setFontArabicLevel(tempFontArabicLevel);
                ui.fontFormat = tempFontArabic;
                setFontArabic(tempFontArabic);
              },
//              child: Container(
//                decoration: const BoxDecoration(
//                  gradient: LinearGradient(
//                    colors: <Color>[
//                      Color(0xFF0D47A1),
//                      Color(0xFF1976D2),
//                      Color(0xFF42A5F5),
//                    ],
//                  ),
//                ),
//              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
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
