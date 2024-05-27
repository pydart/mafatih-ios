import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mafatih/ui/listpage/detailSec.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../consent_manager.dart';
import '../../data/uistate.dart';
import '../../utils/constants.dart';
import '../RateUsDialog.dart';
import 'detailSec4.dart';
import 'detailSec5.dart';
import '../widget/drawer.dart';
import 'listFasl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'notesSearch.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int indexTabHome = 0;
  late String newVersionBuildNumber;
  double? currentBuildNumber;

  String gif1Url = "";
  String gif2Url = "";
  String gif3Url = "";

  _getGif1Url() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://videoir.com/apps_versions/gif1url.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        gif1Url = Results;
        print(
            "/////////////////////////////////////******************************************************** gif1url   $gif1Url");
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  _getGif2Url() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://videoir.com/apps_versions/gif2url.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        gif2Url = Results;
        print("///////////////////////////////////// gif2Url   $gif2Url");
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  _getGif3Url() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://videoir.com/apps_versions/gif3url.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        gif3Url = Results;
        print(
            "/////////////////////////////////////******************************************************** gif3Url   $gif3Url");
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  void _showRateUsDialog() {
    showDialog(
      context: context,
      builder: (context) => RateUsDialog(appPackageName: 'pydart.mafatih'),
    );
  }


  _getBuildNumber() async {
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.newVersionUrl))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        setState(() {
          newVersionBuildNumber = Results;
          print(
              "/////////////////////////////////////******************************************************** newVersionBuildNumber   $newVersionBuildNumber");
          double currentBuildNumberdouble = double.parse(newVersionBuildNumber);
          globals.newVersionBuildNumber=currentBuildNumberdouble;
        });

      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    currentBuildNumber = double.parse(info.buildNumber);

    await _getBuildNumber();
    setState(() {
      // currentBuildNumber = currentBuildNumber > 1000
      //     ? currentBuildNumber - 1000
      //     : currentBuildNumber;
      globals.currentBuildNumber=currentBuildNumber;
    });
    try {
      print(
          "/////////////////////////////////////******************************************************** newVersionBuildNumber   ${double.parse(newVersionBuildNumber)}");
      print(
          "/////////////////////////////////////******************************************************** currentBuildNumber   $currentBuildNumber");
      if (double.parse(newVersionBuildNumber) > currentBuildNumber!) {
        print(
            "/////////////////////////////////////******************************************************** double.parse(newVersionBuildNumber) > currentBuildNumber)");
        if (!prefs.containsKey(globals.LaterDialog)) {
          await _upgrader();

        }
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void redirectToLastVisitedSurahView() {
    print("redirectTo:${globals.indexlastViewedPage}");
    if (globals.indexlastViewedPage != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailSec(
                    detail: globals.titlelastViewedPage,
                    index: globals.indexlastViewedPage,
                    indexFasl: globals.indexFasllastViewedPage,
                  )));
    }
  }

  late SharedPreferences prefs;
  getLastViewedPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.LAST_VIEWED_PAGE_index)) {
      var _lastViewedPageTitle =
          prefs.getString(globals.LAST_VIEWED_PAGE_title);
      var _lastViewedPageIndex = prefs.getInt(globals.LAST_VIEWED_PAGE_index);
      var _lastViewedPageIndexFasl =
          prefs.getInt(globals.LAST_VIEWED_PAGE_indexFasl);
      setState(() {
        globals.titlelastViewedPage = _lastViewedPageTitle;
        globals.indexlastViewedPage = _lastViewedPageIndex;
        globals.indexFasllastViewedPage = _lastViewedPageIndexFasl;
      });
    }
  }

  getBookmark() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code)) {
      List<String> titleBookMarked =
          prefs.getStringList(globals.BOOKMARKED_PAGE_title)!;

      List<String> savedStrList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_index)!;
      List<int> indexBookMarked =
          savedStrList.map((i) => int.parse(i)).toList();

      List<String> savedStrFaslList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl)!;
      List<int> indexFaslBookMarked =
          savedStrFaslList.map((i) => int.parse(i)).toList();

      List<String> savedStrCodeList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_Code)!;
      List<int> codeBookMarked =
          savedStrCodeList.map((i) => int.parse(i)).toList();

      setState(() {
        globals.titleBookMarked = titleBookMarked;
        globals.indexBookMarked = indexBookMarked;
        globals.indexFaslBookMarked = indexFaslBookMarked;
        globals.codeBookMarked = codeBookMarked;
      });
    } else {
      setState(() {
        globals.titleBookMarked = [];
        globals.indexBookMarked = [];
        globals.indexFaslBookMarked = [];
        globals.codeBookMarked = [];
      });
    }
  }

  getFontsize() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.FontArabic_LEVEL)) {
      double? _fontarabiclevel = prefs.getDouble(globals.FontArabic_LEVEL);
      double? _fonttarjlevel = prefs.getDouble(globals.FontTarj_LEVEL);
      double? _fonttozihlevel = prefs.getDouble(globals.FontTozih_LEVEL);
      String? _fontarabic = prefs.getString(globals.FontArabic);
      setState(() {
        globals.fontArabicLevel = _fontarabiclevel;
        globals.fontArabic = _fontarabic;
        globals.fontTarjLevel = _fonttarjlevel;
        globals.fontTozihLevel = _fonttozihlevel;
      });
    } else {
      setState(() {
        globals.fontArabic = 'نیریزی دو';
        globals.fontArabicLevel = 25;
        globals.fontTarjLevel = 21;
        globals.fontTozihLevel = 25;
      });
    }
  }


  @override
  void initState() {
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    getBookmark();
    getLastViewedPage();
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
    getFontsLevel();
    getOtherSettings();
    getScreenBrightness();
    getBrightnessLevel();
    checkUrlExist();
    checkCatList();
    checkAdUrlExist();
    KeepScreenOn.turnOn();
  }

  setAdUrl(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.jsonGifAdUrl = json;
    await prefs.setString('JsonGifAdUrl', json);
    print(
        "*********************************************setAdUrl***************************** globals.jsonGifAdUrl ${globals.jsonGifAdUrl} ");
  }

  checkAdUrlExist() async {
    print(
        "************************************************************************** checkAdUrlExist ");
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.mafatihads + '/gifAdUrlDic.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        print(
            "************************************************************************** response.statusCode == 200  $Results");
        setAdUrl(Results);
      } else {
        print(
            "************************************************************************** Failed to load ");
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  setAudioExist(List<String> jsonCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.jsonCodesHavingAudio = jsonCode;
    await prefs.setStringList(
        'JsonCodesHavingAudio', globals.jsonCodesHavingAudio!);
  }

  setCatExist(List<String> jsonCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.jsonCodesHavingCat= jsonCode;
    await prefs.setStringList(
        'JsonCodesHavingCat', globals.jsonCodesHavingCat!);
    print("*********************************************setAudioExist***************************** globals.jsonCodesHavingCat ${globals.jsonCodesHavingCat} ");
  }

  checkUrlExist() async {
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.audiosListUrl + '/audiosList.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        // print("************************************************************************** response.statusCode == 200  $Results");
        setAudioExist(json.decode(Results).cast<String>().toList());
      } else {
        // print("************************************************************************** Failed to load ");
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }


  checkCatList() async {
    // print("************************************************************************** checkUrlExist ");
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.catListUrl + '/catBlockList.php'))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        // print("************************************************************************** response.statusCode == 200  $Results");
        setCatExist(json.decode(Results).cast<String>().toList());
      } else {
        // print("************************************************************************** Failed to load ");
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

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
        ScreenBrightness().setScreenBrightness(globals.brightnessLevel!);
      });
    } else {
      // getScreenBrightness();
    }
  }

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
      globals.audioExist = false;
      globals.tarjKhati = false;
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
    if (prefs.containsKey(globals.TarjKhati)) {
      var _tarjKhati = prefs.getBool(globals.TarjKhati);
      setState(() {
        globals.tarjKhati = _tarjKhati;
        // ui.tarjKhatiSet=_tarjKhati;
      });
    }
    if (prefs.containsKey(globals.DarkMode)) {
      _darkMode = prefs.getBool(globals.DarkMode);
      setState(() {
        globals.darkMode = false;
      });
    }

    if (prefs.containsKey(globals.JsonCodesHavingAudio)) {
      var _jsonCodesHavingAudio =
          prefs.getStringList(globals.JsonCodesHavingAudio);
      setState(() {
        globals.jsonCodesHavingAudio = _jsonCodesHavingAudio!;
      });
    }

    if (prefs.containsKey(globals.JsonCodesHavingCat)) {
      var _jsonCodesHavingCat =
      prefs.getStringList(globals.JsonCodesHavingCat);
      setState(() {
        globals.jsonCodesHavingCat = _jsonCodesHavingCat!;
      });
    }

    if (prefs.containsKey(globals.JsonGifAdUrl)) {
      var _jsonGifAdUrl = prefs.getString(globals.JsonGifAdUrl);
      setState(() {
        globals.jsonGifAdUrl = _jsonGifAdUrl;
        globals.jsonGifAdUrlMap = json.decode(_jsonGifAdUrl!);
      });
      print(
          "***************************************************************globals.jsonGifAdUrlMap  ${globals.jsonGifAdUrlMap!["urlgiffirstpage1"]}");
    }

    if (globals.darkMode == null) {
      globals.darkMode = false;
    }

    if (prefs.containsKey(globals.LAST_SCROLLED_PIXEL)) {
      var _lastScrolledPixel = prefs.getDouble(globals.LAST_SCROLLED_PIXEL);
      setState(() {
        globals.lastScrolledPixel = _lastScrolledPixel;
      });
    }

    if (prefs.containsKey(globals.LAST_VIEWED_PAGE_title)) {
      setState(() {
        globals.titlelastViewedPage =
            prefs.getString(globals.LAST_VIEWED_PAGE_title);
        globals.indexlastViewedPage =
            prefs.getInt(globals.LAST_VIEWED_PAGE_index);
        globals.indexFasllastViewedPage =
            prefs.getInt(globals.LAST_VIEWED_PAGE_indexFasl);
        globals.indentlastViewedPage =
            prefs.getString(globals.LAST_VIEWED_PAGE_indent);
      });
    }

    if (prefs.containsKey(globals.OneTimeRateUs)) {
      var _oneTimeRateUs = prefs.getBool(globals.OneTimeRateUs);
      setState(() {
        globals.oneTimeRateUs = _oneTimeRateUs;
      });
    }


  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool?> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("آیا قصد خروج از برنامه را دارید؟"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("بله"),
                  onPressed: () => exit(0),
//                  onPressed: () => Navigator.pop(context, true),
                ),
                ElevatedButton(
                  child: Text(
                    "خیر",
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "برای خروج دو مرتبه برگشت بزنید",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);

      // globals.oneTimeRateUs!=true ? showDialog(
      //   context: context,
      //   builder: (context) => RateUsDialog(appPackageName: 'pydart.mafatih'),
      // ):null;
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      SystemNavigator.pop();
      return Future.value(false);
    }
  }

  setLaterDialog() async {
    bool level = false;
    globals.laterDialog = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.LaterDialog, level);
  }



  Future<bool?> _upgrader() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("نسخه جدیدی از برنامه برای بروزرسانی موجود می باشد.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IRANSans',
                    fontSize: 16,
                  )),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("بروزرسانی",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'IRANSans',
                        fontSize: 16,
                      )),
                  onPressed: () => _launchURL(Constants.PLAY_STORE_URL),
//                  onPressed: () => Navigator.pop(context, true),
                ),
                ElevatedButton(
                  child: Text(
                    "بعدا",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'IRANSans',
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    setLaterDialog();
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }
  // static void _onAdLoaded(Ad ad) {
  //   print("/////////////////////////////////////////////////////////////////////////////////////////////////////////////banner loaded");
  // }
  //
  // static void _onAdClicked(Ad ad) {
  //   print("banner clicked");
  // }
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    return Scrollbar(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: Container(
              child: Drawer(
                child: Drawers(
                    newVersionBuildNumber: globals.newVersionBuildNumber,
                    currentBuildNumber: globals.currentBuildNumber),
              ),
              width: 200),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor:Theme.of(context).brightness == Brightness.light
                      ? Colors.green
                      : Colors.black,
                  pinned: true,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/font_mafatih.png',
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.green,
                          height: 150,
                          width: 152,
                        ),
                      ]),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: NotesSearch());
                      },
                    ),
                  ],
                )
              ];
            },
            body: Container(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  // controller: _tabController,
                  children: <Widget>[
                    if (ui.edameFarazSet == false ||
                        globals.indexFasllastViewedPage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120.0, vertical: 0),
                        child: Card(
                            semanticContainer: true,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.lightGreen[50]
                                    : Colors.green,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    width: 0.5, color: Colors.green)),
                            child: Container(
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    ' نمایش آخرین صفحه',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'IRANSans',
                                      fontSize: 12,
                                      height: 1.7,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  globals.edameFaraz = true;
                                  ui.edameFarazSet = true;
                                  {
                                    if (globals.indexFasllastViewedPage == 4 &&
                                        !ui.terjemahan! || globals
                                        .indexFasllastViewedPage ==
                                        5) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailSec4(
                                                    detail: globals
                                                        .titlelastViewedPage,
                                                    index: globals
                                                        .indexlastViewedPage,
                                                    indent: globals
                                                        .indentlastViewedPage,
                                                    indexFasl: 5,
                                                    code: globals
                                                                .indexFasllastViewedPage! *
                                                            1000 +
                                                        globals
                                                            .indexlastViewedPage!,
                                                  )));
                                    } else if ((globals
                                        .indexFasllastViewedPage ==
                                        4 &&
                                        ui.terjemahan!) ) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailSec4(
                                                    detail: globals
                                                        .titlelastViewedPage,
                                                    index: globals
                                                        .indexlastViewedPage,
                                                    indent: globals
                                                        .indentlastViewedPage,
                                                    indexFasl: globals
                                                        .indexFasllastViewedPage,
                                                    code: globals
                                                                .indexFasllastViewedPage! *
                                                            1000 +
                                                        globals
                                                            .indexlastViewedPage!,
                                                  )));
                                    } else if (globals
                                            .indexFasllastViewedPage !=
                                        4) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailSec(
                                                    detail: globals
                                                        .titlelastViewedPage,
                                                    index: globals
                                                        .indexlastViewedPage,
                                                    indent: globals
                                                        .indentlastViewedPage,
                                                    indexFasl: globals
                                                        .indexFasllastViewedPage,
                                                    code: globals
                                                                .indexFasllastViewedPage! *
                                                            1000 +
                                                        globals
                                                            .indexlastViewedPage!,
                                                  )));
                                    }
                                  }
                                },
                              ),
                            )),
                      ),
                    ListFasl(),
                    // Text(
                    //   'برای حمایت از ما روی تبلیغ ذیل کلیک فرماییدِ',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontFamily: 'عربی ساده',
                    //     fontSize: 12,
                    //     height: 1.5,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          // bottomNavigationBar: AdmobBanner(
          //   adUnitId: 'ca-app-pub-5524959616213219/5790610979',
          //   adSize: AdmobBannerSize.BANNER,
          //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //   //   if (event == AdmobAdEvent.clicked) {}
          //   // },
          // ),
          // bottomNavigationBar:
          // OrientationBuilder(
          //   builder: (context, orientation) {
          //     if (_currentOrientation != orientation) {
          //       _isLoaded = false;
          //       _loadAd();
          //       _currentOrientation = orientation;
          //     }
          //     return Stack(
          //       children: [
          //         if (_bannerAd != null && _isLoaded)
          //           Align(
          //             alignment: Alignment.bottomCenter,
          //             child: SafeArea(
          //               child: SizedBox(
          //                 width: _bannerAd!.size.width.toDouble(),
          //                 height: _bannerAd!.size.height.toDouble(),
          //                 child: AdWidget(ad: _bannerAd!),
          //               ),
          //             ),
          //           )
          //       ],
          //     );
          //   },
          // )



        ),
      ),
    );
//      ),
//    ]);
  }
}
