// import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/theming/theme/custom_theme_mode.dart';
import 'package:mafatih/theming/theme/locale_keys.g.dart';
import 'package:mafatih/theming/theme/select_button.dart';
import 'package:mafatih/ui/widget/cardsetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:easy_localization/easy_localization.dart';

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

  List ThemeList = [
    'اتوماتیک',
    'روشن',
    'تاریک',
  ];

  bool tempTarjKhati = globals.tarjKhati;
  bool tempTarjActive = globals.tarjActive;
  bool tempTozihActive = globals.tozihActive;
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

  setTarjKhati(bool level) async {
    globals.tarjKhati = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.TarjKhati, level);
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

  void getScreenBrightness() async {
    double _brightnessLevel3;
    double _brightnessLevel4;
    _brightnessLevel3 = await ScreenBrightness().current;
    _brightnessLevel4 =
        _brightnessLevel3 > 1 ? (_brightnessLevel3) / 10 : (_brightnessLevel3);
    globals.brightnessLevel =
        double.parse(_brightnessLevel4.toStringAsFixed(2));
    ScreenBrightness().setScreenBrightness(globals.brightnessLevel);
  }

  void selectLightMode() => Provider.of<CustomThemeMode>(context, listen: false)
      .setThemeMode(ThemeMode.light);
  void selectDarkMode() => Provider.of<CustomThemeMode>(context, listen: false)
      .setThemeMode(ThemeMode.dark);
  void selectSystemThemeMode() =>
      Provider.of<CustomThemeMode>(context, listen: false)
          .setThemeMode(ThemeMode.system);

  Widget get _buildThemeButton {
    ThemeMode currentTheme = Provider.of<CustomThemeMode>(context).getThemeMode;
    Map<String, bool> theme = {
      LocaleKeys.lightMode.tr(): currentTheme == ThemeMode.light ? true : false,
      LocaleKeys.darkMode.tr(): currentTheme == ThemeMode.dark ? true : false,
      LocaleKeys.systemMode.tr():
          currentTheme == ThemeMode.system ? true : false
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .082,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: theme.length,
              itemBuilder: (BuildContext context, int index) {
                return SelectButton(
                  title: theme.keys.toList()[index],
                  onOff: theme.values.toList()[index],
                  onPressed: () => setState(() {
                    theme.forEach((key, value) {
                      theme[key] =
                          key == theme.keys.toList()[index] ? true : false;
                      (theme.values.toList()[0] == true)
                          ? selectLightMode()
                          : (theme.values.toList()[1] == true)
                              ? selectDarkMode()
                              : selectSystemThemeMode();
                    });
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode currentTheme = Provider.of<CustomThemeMode>(context).getThemeMode;
    Map<String, bool> themeMap = {
      LocaleKeys.lightMode.tr(): currentTheme == ThemeMode.light ? true : false,
      LocaleKeys.darkMode.tr(): currentTheme == ThemeMode.dark ? true : false,
      LocaleKeys.systemMode.tr():
          currentTheme == ThemeMode.system ? true : false
    };

    List theme = [
      currentTheme == ThemeMode.system ? true : false,
      currentTheme == ThemeMode.light ? true : false,
      currentTheme == ThemeMode.dark ? true : false,
    ];

    var ui = Provider.of<UiState>(context);
    // var dark = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('تنظیمات'),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          CardSetting(
            title: 'پوسته برنامه',
            leading: DropdownButton(
                value: theme.indexWhere((value) => value == true),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      ThemeList[0],
                      style: TextStyle(
                        color: theme.indexWhere((value) => value == true) == 0
                            ? Colors.green
                            : null,
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      ThemeList[1],
                      style: TextStyle(
                        color: theme.indexWhere((value) => value == true) == 1
                            ? Colors.green
                            : null,
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                      child: Text(
                        ThemeList[2],
                        style: TextStyle(
                          color: theme.indexWhere((value) => value == true) == 2
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 2),
                ],
                onChanged: (value) {
                  setState(() {
                    value == 0
                        ? selectSystemThemeMode()
                        : value == 1
                            ? selectLightMode()
                            : selectDarkMode();
                  });
                }),
          ),
          CardSetting(
            title: 'ترجمه',
            leading: Switch(
              activeColor: Color(0xf6c40c0c),
              value: tempTarjActive,
              onChanged: (newValue) {
                setState(() {
                  ui.terjemahan = newValue;
                  tempTarjActive = newValue;
                  setTarjActive(newValue);

                  tempTarjKhati = (newValue & globals.tarjKhati) ? true : false;
                  print("***********************************************************************" + tempTarjKhati.toString());
                  //
                  ui.tarjKhatiSet = globals.tarjKhati;
                  globals.tarjKhati = tempTarjKhati;
                  setTarjKhati(globals.tarjKhati);
                });
              },
            ),
          ),
          tempTarjActive
              ? CardSetting(
            title: ' ترجمه خطی(تعدادی محدود)',
            leading: Switch(
              activeColor: Color(0xf6c40c0c),
              value: tempTarjKhati,
              onChanged: (newValue) {
                setState(() {
                  tempTarjKhati = newValue;
                  globals.tarjKhati = tempTarjKhati;
                  ui.tarjKhatiSet = tempTarjKhati;
                  setTarjKhati(globals.tarjKhati);
                });
              },
            ),
          )
              : Container(),
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
                    child: Text(
                      FontArabicList[0],
                      style: TextStyle(
                        color: tempFontArabic == FontArabicList[0]
                            ? Colors.green
                            : null,
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      FontArabicList[1],
                      style: TextStyle(
                        color: tempFontArabic == FontArabicList[1]
                            ? Colors.green
                            : null,
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                      child: Text(
                        FontArabicList[2],
                        style: TextStyle(
                          color: tempFontArabic == FontArabicList[2]
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 2),
                  DropdownMenuItem(
                      child: Text(
                        FontArabicList[3],
                        style: TextStyle(
                          color: tempFontArabic == FontArabicList[3]
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 3),
                  DropdownMenuItem(
                      child: Text(
                        FontArabicList[4],
                        style: TextStyle(
                          color: tempFontArabic == FontArabicList[4]
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 4)
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
                      ? ScreenBrightness().setScreenBrightness(tempBrightnessLevel)
                      : ScreenBrightness().setScreenBrightness(
                      globals.brightnessLevelDefault);

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
                      ScreenBrightness().setScreenBrightness(tempBrightnessLevel);
//                  ui.lightlevel = newValue;
                      setBrightnessLevel(tempBrightnessLevel);
                    },
                  ),
                  trailing: (tempBrightnessLevel * 100).toInt().toString(),
                )
              : Container(),
          CardSetting(
            title: 'بازگشت به تنظیمات اولیه',
            leading: ElevatedButton(
              // elevation: 0,
              // color: Colors.green,
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
              ),

              onPressed: () {
                setState(() {
                  ScreenBrightness().resetScreenBrightness();
                  tempFontArabicLevel = 25;
                  tempFontTarjLevel = 21;
                  tempFontTozihLevel = 25;
                  tempTarjActive = true;
                  themeType = false;
                  brightnessActive = false;
                  tempFontArabic = 'نیریزی دو';
                });
                if (globals.themeType) {
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
                globals.brightnessActive = false;
                setBrightnessActive(false);
                selectSystemThemeMode();
              },
            ),
          ),
          // SizedBox(
          //   height: 50,
          // )
          AdmobBanner(
            adUnitId: 'ca-app-pub-5524959616213219/3936589352',
            adSize: AdmobBannerSize.BANNER,
            // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
            //   if (event == AdmobAdEvent.clicked) {}
            // },
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
