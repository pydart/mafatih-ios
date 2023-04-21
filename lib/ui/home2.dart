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
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
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
    return Scrollbar(
      child: WillPopScope(
        // onWillPop: _onBackPressed,
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: Container(
              child: Drawer(child: Drawers()),
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

class Drawers extends StatelessWidget {
  const Drawers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isInstalled;

    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: ListView(
//      padding: EdgeInsets.only(left: 80),
          shrinkWrap: true,

          children: <Widget>[
            Container(
              height: 130,
//            color: Colors.green[500],
              child: DrawerHeader(
                margin: EdgeInsets.only(bottom: 0.0),
                padding: EdgeInsets.only(right: 0, bottom: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: double.infinity,

//                      child: SvgPicture.asset(
//                        "assets/MafatihDrawer.svg",
////                      fit: BoxFit.cover,
////                      semanticsLabel: 'Feed button',
////                      placeholderBuilder: (context) => Icon(Icons.error),
//                      ),
                      child: Image.asset("assets/MafatihDrawer.png"),

//                    ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.green[500],
            ),
            ListTile(
              leading: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Icon(Icons.info), // icon-1
                  Text(
                    'درباره برنامه',
                    style: AppStyle.setting,
                  ),
                ],
              ),
//            trailing: Icon(Icons.keyboard_arrow_left),
              onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new HomeAbout()),
              ),
//            onTap: () => Navigator.popAndPushNamed(context, '/ayatkursi'),
            ),
            ListTile(
//              title: Text(
//                'تنظیمات',
////                textAlign: TextAlign.right,
//              ),
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    Icon(Icons.settings), // icon-1
                    Text(
                      'تنظیمات',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
//              trailing: Icon(Icons.keyboard_arrow_left),
                onTap: () => Navigator.popAndPushNamed(context, '/settings')),
            Text(
              '   دیگر برنامه ها',
              style: AppStyle.settingRelated,
            ),
            Container(
              height: 1,
              color: Color(0xf6c40c0c),
            ),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    new IconTheme(
                      data: new IconThemeData(
                        color: null,
                      ), //IconThemeData

                      child: Container(
                        child: new Image.asset("assets/ashoura.png"),
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Text(
                      'زیارت عاشورا',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () async {
                  isInstalled =
                      await DeviceApps.isAppInstalled('pydart.ashoura');
                  if (isInstalled) {
                    DeviceApps.openApp('pydart.ashoura');
                  } else {
                    String url = Constants.storeUrlAshoura;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  }
                }),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    new IconTheme(
                      data: new IconThemeData(
                        color: null,
                      ), //IconThemeData

                      child: Container(
                        child: new Image.asset("assets/komeil.png"),
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Text(
                      'دعای کمیل',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () async {
                  isInstalled =
                      await DeviceApps.isAppInstalled('pydart.komeil');
                  if (isInstalled) {
                    DeviceApps.openApp('pydart.komeil');
                  } else {
                    String url = Constants.storeUrlKomeil;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  }
                }),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    new IconTheme(
                      data: new IconThemeData(
                        color: null,
                      ), //IconThemeData

                      child: Container(
                        child: new Image.asset("assets/aahd.png"),
//                        color: Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Text(
                      'دعای عهد',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () async {
                  isInstalled = await DeviceApps.isAppInstalled('pydart.aahd');
                  if (isInstalled) {
                    DeviceApps.openApp('pydart.aahd');
                  } else {
                    String url = Constants.storeUrlAahd;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  }
                }),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    new IconTheme(
                      data: new IconThemeData(
                        color: null,
                      ), //IconThemeData

                      child: Container(
                        child: new Image.asset("assets/nodbe.png"),
//                        color: Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Text(
                      'دعای ندبه',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () async {
                  isInstalled = await DeviceApps.isAppInstalled('pydart.nodbe');
                  if (isInstalled) {
                    DeviceApps.openApp('pydart.nodbe');
                  } else {
                    String url = Constants.storeUrlNodbe;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  }
                }),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
//                  Icon( icon: new Image.asset("assets / asmaIcon.png")), // icon-1
//                  new Image.asset("assets/asmaIcon.png"),
                    new IconTheme(
                      data: new IconThemeData(
                        color: null,
                      ), //IconThemeData

                      child: Container(
                        child: new Image.asset("assets/kasa.png"),
//                        color: Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),

                    Text(
                      'حدیث کسا',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () async {
                  isInstalled = await DeviceApps.isAppInstalled('pydart.kasa');
                  if (isInstalled) {
                    DeviceApps.openApp('pydart.kasa');
                  } else {
                    String url = Constants.storeUrlKasa;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  }
                }),
          ],
        ),
      ),
      bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-5524959616213219/7557264464',
        adSize: AdmobBannerSize.BANNER,
        // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        //   if (event == AdmobAdEvent.clicked) {}
        // },
      ),
    );
  }
}
