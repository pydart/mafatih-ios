// import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
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

import '../../consent_manager.dart';
import '../../utils/constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double? tempBrightnessLevel = globals.brightnessLevel == null
      ? globals.brightnessLevelDefault
      : globals.brightnessLevel;
  double? tempFontArabicLevel = globals.fontArabicLevel;
  double? tempFontTarjLevel = globals.fontTarjLevel;
  double? tempFontTozihLevel = globals.fontTozihLevel;
  String? tempFontArabic = globals.fontArabic;
  // List FontArabicList = ['نیریزی'];
  late double briValue;
  List FontArabicList = [
    'نیریزی یک',
    'عثمان طه ۱',
    'عثمان طه ۲',
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

  bool? tempTarjKhati = globals.tarjKhati;
  bool? tempTarjActive = globals.tarjActive;
  bool? tempTozihActive = globals.tozihActive;
  bool? themeType = globals.themeType;
  bool? brightnessActive = globals.brightnessActive;

  late SharedPreferences prefs;
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

  setThemeType(bool? level) async {
    globals.themeType = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.ThemeType, globals.themeType!);
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
    ScreenBrightness().setScreenBrightness(globals.brightnessLevel!);
  }

  void selectLightMode() => Provider.of<CustomThemeMode>(context, listen: false)
      .setThemeMode(ThemeMode.light);
  void selectDarkMode() => Provider.of<CustomThemeMode>(context, listen: false)
      .setThemeMode(ThemeMode.dark);
  void selectSystemThemeMode() =>
      Provider.of<CustomThemeMode>(context, listen: false)
          .setThemeMode(ThemeMode.system);

  Widget get _buildThemeButton {
    ThemeMode? currentTheme = Provider.of<CustomThemeMode>(context).getThemeMode;
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


  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  Orientation? _currentOrientation;

  final String _adUnitId = Platform.isAndroid
      ? Constants.adUnitId
      : Constants.adUnitId;


  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the width of the screen.
  void _loadAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    if (!mounted) {
      return;
    }

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }


  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }



  void _initializeMobileAdsSDK() async {
    MobileAds.instance.initialize();
    _loadAd();
  }


  @override
  void initState() {
    _initializeMobileAdsSDK();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode? currentTheme = Provider.of<CustomThemeMode>(context).getThemeMode;
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
        backgroundColor:Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : Colors.black,
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
          // Center(
          //   child: AdmobBanner(
          //     adUnitId: 'ca-app-pub-5524959616213219/3936589352',
          //     adSize: AdmobBannerSize.BANNER,
          //     // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //     //   if (event == AdmobAdEvent.clicked) {}
          //     // },
          //   ),
          // ),
          // Center(child: BannerAd("2028260f-a8b1-4890-8ef4-224c4de96e02",BannerAdSize.BANNER,)),
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
                onChanged: (dynamic value) {
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
              activeColor: Colors.green,
              inactiveThumbColor: Colors.green,

              value: tempTarjActive!,
              onChanged: (newValue) {
                setState(() {
                  ui.terjemahan = newValue;
                  tempTarjActive = newValue;
                  setTarjActive(newValue);

                  tempTarjKhati = (newValue & globals.tarjKhati!) ? true : false;
                  print("***********************************************************************" + tempTarjKhati.toString());
                  //
                  ui.tarjKhatiSet = globals.tarjKhati;
                  globals.tarjKhati = tempTarjKhati;
                  setTarjKhati(globals.tarjKhati!);
                });
              },
            ),
          ),
          tempTarjActive!
              ? CardSetting(
            title: ' ترجمه خطی(تعدادی محدود)',
            leading: Switch(
              activeColor: Colors.green,
              value: tempTarjKhati!,
              onChanged: (newValue) {
                setState(() {
                  tempTarjKhati = newValue;
                  globals.tarjKhati = tempTarjKhati;
                  ui.tarjKhatiSet = tempTarjKhati;
                  setTarjKhati(globals.tarjKhati!);
                });
              },
            ),
          )
              : Container(),
          CardSlider(
            title: 'سایز متن توضیحات ',
            slider: Slider(
                activeColor: Colors.green,

                min: 14,
                max: 1.5 * 30,
//                value: ui.sliderfontSizeTozih,
                value: tempFontTozihLevel!,
                onChanged: (newValue) {
                  setState(() {
                    tempFontTozihLevel = newValue;
                    ui.fontSizeTozih = newValue;
                    setFontTozihLevel(newValue);
                  });
                }),
//            trailing: ui.fontSizeTozih.toInt().toString(),
            trailing: tempFontTozihLevel!.toInt().toString(),
          ),
          CardSlider(
            title: 'سایز متن فارسی ',
            slider: Slider(
                activeColor: Colors.green,

                min: 14,
                max: 1.5 * 30,
                value: tempFontTarjLevel!,
                onChanged: (newValue) {
                  setState(() {
                    tempFontTarjLevel = newValue;
                    ui.fontSizetext = newValue;
                    setFontTarjLevel(newValue);
                  });
                }),
            trailing: tempFontTarjLevel!.toInt().toString(),
          ),
          CardSlider(
            title: 'سایز متن عربی',
            slider: Slider(
                activeColor: Colors.green,

                min: 14,
                max: 1.5 * 30,
                value: tempFontArabicLevel!,
                onChanged: (newValue) {
                  setState(() {
                    ui.fontSize = newValue;
                    tempFontArabicLevel = newValue;
                    setFontArabicLevel(newValue);
                  });
                }),
            trailing: tempFontArabicLevel!.toInt().toString(),
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
                      value: 4),
                  DropdownMenuItem(
                      child: Text(
                        FontArabicList[5],
                        style: TextStyle(
                          color: tempFontArabic == FontArabicList[5]
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 5),
                  DropdownMenuItem(
                      child: Text(
                        FontArabicList[6],
                        style: TextStyle(
                          color: tempFontArabic == FontArabicList[6]
                              ? Colors.green
                              : null,
                        ),
                      ),
                      value: 6)
                ],
                onChanged: (dynamic value) {
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

              value: brightnessActive!,
//              value: tempDarkMode,
              onChanged: (newValue) {
                setState(() {
                  brightnessActive = newValue;
                  globals.brightnessActive = newValue;
                  setBrightnessActive(newValue);
                  brightnessActive!
                      ? ScreenBrightness().setScreenBrightness(tempBrightnessLevel!)
                      : ScreenBrightness().setScreenBrightness(
                      globals.brightnessLevelDefault!);

                  // : Screen.setBrightness(globals.brightnessLevelDefault);
                });
              },
            ),
          ),
          brightnessActive!
              ? CardSlider(
                  title: 'نور صفحه',
                  slider: Slider(
                    activeColor: Colors.green,

                    min: 0,
                    max: 100,
                    divisions: 101,
                    value: tempBrightnessLevel! * 100,
                    onChanged: (newValue) {
                      setState(() {
                        briValue = newValue / 100;
                        tempBrightnessLevel =
                            double.parse(briValue.toStringAsFixed(2));
                      });
                      ScreenBrightness().setScreenBrightness(tempBrightnessLevel!);
//                  ui.lightlevel = newValue;
                      setBrightnessLevel(tempBrightnessLevel!);
                    },
                  ),
                  trailing: (tempBrightnessLevel! * 100).toInt().toString(),
                )
              : Container(),
          CardSetting(
            title: 'بازگشت به تنظیمات اولیه',
            leading: ElevatedButton(
              // elevation: 0,
              // color: Colors.green,
              child: const Icon(
                Icons.touch_app,
                color: Colors.green,
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
                if (globals.themeType!) {
                  globals.themeType = themeType;
                  setThemeType(themeType);
                }
                ui.terjemahan = tempTarjActive;
                setTarjActive(tempTarjActive!);
                ui.fontSizeTozih = tempFontTozihLevel;
                setFontTozihLevel(tempFontTozihLevel!);
                ui.fontSizetext = tempFontTarjLevel;
                setFontTarjLevel(tempFontTarjLevel!);
                ui.fontSize = tempFontArabicLevel;
                setFontArabicLevel(tempFontArabicLevel!);
                ui.fontFormat = tempFontArabic;
                setFontArabic(tempFontArabic!);
                globals.brightnessActive = false;
                setBrightnessActive(false);
                selectSystemThemeMode();
              },
            ),
          ),
          // SizedBox(
          //   height: 50,
          // )
          // Center(
          //   child: AdmobBanner(
          //     adUnitId: 'ca-app-pub-5524959616213219/3936589352',
          //     adSize: AdmobBannerSize.LARGE_BANNER,
          //     // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //     //   if (event == AdmobAdEvent.clicked) {}
          //     // },
          //   ),
          // ),

          Stack(
            children: [
              if (_bannerAd != null && _isLoaded)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
                )
            ],
          )
          // Center(child: BannerAd("2028260f-a8b1-4890-8ef4-224c4de96e02",BannerAdSize.LARGE_BANNER,)),
        ],
      ),
    );
  }
}

class CardSlider extends StatelessWidget {
  const CardSlider({
    Key? key,
    required this.title,
    required this.slider,
    required this.trailing,
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
