import 'dart:convert';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/library/Globals.dart';
import 'package:mafatih/ui/detailSec.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/utils/sharedFunc.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../data/uistate.dart';
import 'detailSec4.dart';
import 'detailSec5.dart';
import 'drawer.dart';
import 'home_about.dart';
import 'listpage/listFasl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'notesSearch.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// Used for Bottom Navigation
  int indexTabHome = 0;
  String newVersionBuildNumber;
  double currentBuildNumber;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String gif1Url="";
  String gif2Url="";
  String gif3Url="";

  _getGif1Url() async {
    try {
      http.Response response =
      await http.get(Uri.parse('https://videoir.com/apps_versions/gif1url.php')).whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        gif1Url = Results;
        print("/////////////////////////////////////******************************************************** gif1url   $gif1Url");
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  _getGif2Url() async {
    try {
      http.Response response =
      await http.get(Uri.parse('https://videoir.com/apps_versions/gif2url.php')).whenComplete(() {});
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
      http.Response response =
      await http.get(Uri.parse('https://videoir.com/apps_versions/gif3url.php')).whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        gif3Url = Results;
        print("/////////////////////////////////////******************************************************** gif3Url   $gif3Url");
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }


  _getAudioList() async {
    print("******************************************_getAudioList  STARTED****************************************");

    try {
      http.Response response =
      await http.get(Constants.audiosListUrl+'/audiosList.php').whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        print("**********************************************************************************_getAudioList    $Results");
      } else {
        throw Exception('------------------------------------------------------------------------------------------------------Failed to load');
      }
    } catch (e) {
      print("----------------------------------------------------------------------------------------------------------------Exception Caught: $e");
    }
  }


  _getBuildNumber() async {
    try {
      http.Response response =
          await http.get(Constants.newVersionUrl).whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        newVersionBuildNumber = Results;
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
      currentBuildNumber = currentBuildNumber > 1000
          ? currentBuildNumber - 1000
          : currentBuildNumber;
    });
    try {
      if (double.parse(newVersionBuildNumber) > currentBuildNumber) {
        if (!prefs.containsKey(globals.LaterDialog)) {
          await _upgrader();
        }
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

//  MyGlobals myGlobals = MyGlobals();

//  _showVersionDialog(context) async {
//    await showDialog<String>(
//      context: myGlobals.scaffoldKey.currentContext,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        String title = "New Update Available";
//        String message =
//            "There is a newer version of app available please update it now.";
//        String btnLabel = "Update Now";
//        String btnLabelCancel = "Later";
//        return new AlertDialog(
//          title: Text(title),
//          content: Text(message),
//          actions: <Widget>[
//            FlatButton(
//              child: Text(btnLabel),
//              onPressed: () => _launchURL(PLAY_STORE_URL),
//            ),
//            FlatButton(
//              child: Text(btnLabelCancel),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ],
//        );
//      },
//    );
//  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Navigation event handler

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

  /// Declare SharedPreferences
  SharedPreferences prefs;

  /// get bookmarkPage from sharedPreferences
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

  /// get bookmarkPage from sharedPreferences
  getBookmark() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code)) {
      List<String> titleBookMarked =
          prefs.getStringList(globals.BOOKMARKED_PAGE_title);

      List<String> savedStrList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_index);
      List<int> indexBookMarked =
          savedStrList.map((i) => int.parse(i)).toList();

      List<String> savedStrFaslList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
      List<int> indexFaslBookMarked =
          savedStrFaslList.map((i) => int.parse(i)).toList();

      List<String> savedStrCodeList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_Code);
      List<int> codeBookMarked =
          savedStrCodeList.map((i) => int.parse(i)).toList();

      setState(() {
        globals.titleBookMarked = titleBookMarked;
        globals.indexBookMarked = indexBookMarked;
        globals.indexFaslBookMarked = indexFaslBookMarked;
        globals.codeBookMarked = codeBookMarked;
      });

      /// if not found return default value
    } else {
      setState(() {
        globals.titleBookMarked = [];
        globals.indexBookMarked = [];
        globals.indexFaslBookMarked = [];
        globals.codeBookMarked = [];
      });
    }
  }

  /// get bookmarkPage from sharedPreferences
  getFontsize() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.FontArabic_LEVEL)) {
      double _fontarabiclevel = prefs.getDouble(globals.FontArabic_LEVEL);

      double _fonttarjlevel = prefs.getDouble(globals.FontTarj_LEVEL);

      double _fonttozihlevel = prefs.getDouble(globals.FontTozih_LEVEL);

      String _fontarabic = prefs.getString(globals.FontArabic);

      setState(() {
        globals.fontArabicLevel = _fontarabiclevel;
        globals.fontArabic = _fontarabic;
        globals.fontTarjLevel = _fonttarjlevel;
        globals.fontTozihLevel = _fonttozihlevel;
      });

      /// if not found return default value
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

    // _getAudioList();
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }

    getBookmark();
    getLastViewedPage();
//    Timer(Duration(seconds: 3),
//        () => Navigator.pushReplacementNamed(context, "index"));

    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);

    getFontsLevel();
    getOtherSettings();
    getScreenBrightness();
    getBrightnessLevel();
    // Screen.setBrightness(globals.brightnessActive == true
    //     ? globals.brightnessLevel
    //     : globals.brightnessLevelDefault);

    print("************************************************************************** globals.jsonCodesHavingAudio ${globals.jsonCodesHavingAudio} ");
    // if (prefs.containsKey(globals.JsonCodesHavingAudio)) {
    //   var _jsonCodesHavingAudio = prefs.getStringList(globals.JsonCodesHavingAudio);
    //   setState(() {
    //     globals.jsonCodesHavingAudio = _jsonCodesHavingAudio;
    //   });
    // }
    // if (globals.jsonCodesHavingAudio!=[]) {
    //   print("************************************************************************** jsonCodesHavingAudio.Does Not contain ");
    //   checkUrlExist();
    // } else {
    //   print("*************************************************************globals.jsonCodesHavingAudio   ${globals.jsonCodesHavingAudio} ");
    //
    //
    // }

    checkUrlExist();

  }

  setAudioExist(List<String> jsonCode) async {
    // (globals.jsonCodesHavingAudio).add(jsonCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.jsonCodesHavingAudio=jsonCode;
    await prefs.setStringList('JsonCodesHavingAudio', globals.jsonCodesHavingAudio);

    print("*********************************************setAudioExist***************************** globals.jsonCodesHavingAudio ${globals.jsonCodesHavingAudio} ");

  }
  checkUrlExist() async {
    print("************************************************************************** checkUrlExist ");

    try {
      http.Response response =
      await http.get(Constants.audiosListUrl +'/audiosList.php').whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        print("************************************************************************** response.statusCode == 200  $Results");
        setAudioExist(json.decode(Results).cast<String>().toList());
      } else {
        print("************************************************************************** Failed to load ");
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
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
      globals.audioExist=false;
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
      var _jsonCodesHavingAudio = prefs.getStringList(globals.JsonCodesHavingAudio);
      setState(() {
        globals.jsonCodesHavingAudio = _jsonCodesHavingAudio;
      });
    }

    if (globals.darkMode == null) {
      globals.darkMode = false;
    }

//    Provider.of<ThemeNotifier>(context).curretThemeData2;
    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.tozihActive}          globals.tozihActive');


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
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("آیا قصد خروج از برنامه را دارید؟"),
              actions: <Widget>[
                FlatButton(
                  child: Text("بله"),
                  onPressed: () => exit(0),
//                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  child: Text(
                    "خیر",
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }

  // int backPressCounter = 1;
  // int backPressTotal = 2;
  // Future<bool> onWillPop() {
  //   if (backPressCounter < 2) {
  //     Fluttertoast.showToast(
  //         // "برای خروج ${backPressTotal - backPressCounter} مرتبه برگشت بزنید");
  //         msg: "برای خروج دو مرتبه برگشت بزنید",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 18.0);
  //
  //     // msg:
  //     // "";
  //     backPressCounter++;
  //     Future.delayed(Duration(seconds: 1, milliseconds: 0), () {
  //       backPressCounter--;
  //     });
  //     return Future.value(false);
  //   } else {
  //     return Future.value(true);
  //   }
  // }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "برای خروج دو مرتبه برگشت بزنید",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  setLaterDialog() async {
    bool level = false;
    globals.laterDialog = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.LaterDialog, level);
  }

  Future<bool> _upgrader() {
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
                FlatButton(
                  child: Text("بروزرسانی",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'IRANSans',
                        fontSize: 16,
                      )),
                  onPressed: () => _launchURL(Constants.PLAY_STORE_URL),
//                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  child: Text(
                    "بعدا",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    return Scrollbar(
      child: WillPopScope(
        // onWillPop: _onBackPressed,
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: Container(
              child: Drawer(child: Drawers(
                  gif1Url: gif1Url,
                  gif2Url: gif2Url,
                  gif3Url: gif3Url,
                  newVersionBuildNumber: newVersionBuildNumber,
                  currentBuildNumber: currentBuildNumber),),
//        width: 700.0 / MediaQuery.of(context).devicePixelRatio,
              width: 200),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
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
//                  IconButton(
//                    icon: Icon(Icons.search),
//                    onPressed: () {
//                      showSearch(
//                          context: context, delegate: DataSearch(cities));
//                    },
//                  ),

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
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/bitmap.png"),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  // controller: _tabController,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 120.0, vertical: 0),
                      child: Card(
                          semanticContainer: true,
                          margin: EdgeInsets.fromLTRB(0,0,0,0),

                          color: Colors.lightGreen[50],
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                  width: 0.5, color: Colors.green)),
                          child: Container(
                            child: ListTile(
                              title: Center(
                                child: Text('نمایش آخرین صفحه',                                            style: TextStyle(
                                           fontWeight: FontWeight.bold,
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      height: 1.7,
//                                            color:
//                                                Theme.of(context).buttonColor),
//                       color: Color(0xf6c40c0c)

                                ),
                  ),
                              ),
                              onTap: () async {
                                globals.edameFaraz=true;
                                ui.edameFarazSet = true;
                                {
                                  if (globals.indexFasllastViewedPage !=
                                      4) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                DetailSec(
                                                  detail: globals.titlelastViewedPage,
                                                  index: globals.indexlastViewedPage,
                                                  indent: globals.indentlastViewedPage,
                                                  indexFasl: globals.indexFasllastViewedPage,
                                                  code: globals.indexFasllastViewedPage * 1000 + globals.indexlastViewedPage,
                                                )));
                                  } else if (globals.indexFasllastViewedPage ==
                                      4 &&
                                      !ui.terjemahan) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                DetailSec5(
                                                  detail: globals.titlelastViewedPage,
                                                  index: globals.indexlastViewedPage,
                                                  indent: globals.indentlastViewedPage,
                                                  indexFasl: 5,
                                                  code: globals.indexFasllastViewedPage * 1000 + globals.indexlastViewedPage,
                                                )));
                                  } else if (globals.indexFasllastViewedPage ==
                                      4 &&
                                      ui.terjemahan) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                DetailSec4(
                                                  detail: globals.titlelastViewedPage,
                                                  index: globals.indexlastViewedPage,
                                                  indent: globals.indentlastViewedPage,
                                                  indexFasl: globals.indexFasllastViewedPage,
                                                  code: globals.indexFasllastViewedPage * 1000 + globals.indexlastViewedPage,
                                                )));
                                  }
                                }
                              },
                            ),)),
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
          bottomNavigationBar: AdmobBanner(
            adUnitId: 'ca-app-pub-5524959616213219/7557264464',
            adSize: AdmobBannerSize.BANNER,
            // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
            //   if (event == AdmobAdEvent.clicked) {}
            // },
          ),
        ),
      ),
    );
//      ),
//    ]);
  }
}

