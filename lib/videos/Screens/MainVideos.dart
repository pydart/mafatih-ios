import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mafatih/videos/layout/home/layout_home.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:package_info/package_info.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../consent_manager.dart';
import '../../data/utils/style.dart';
import '../../ui/widget/drawer.dart';
import '../../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Activity_Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Activity_Main_State();
}

class Activity_Main_State extends State<Activity_Main> {
  //Global Variables
  var MenuIndex = 0;
  var MenuItem = [];
  var BackPress = false;
  late String newVersionBuildNumber;
  late double currentBuildNumber;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late DateTime lastToastTime;

  get prefs => null;
  _getBuildNumber() async {
    try {
      http.Response response = await http
          .get(Uri.parse(Constants.newVersionUrl))
          .whenComplete(() {});
      if (response.statusCode == 200) {
        var Results = response.body;
        setState(() {
          newVersionBuildNumber = Results;
          double currentBuildNumberdouble = double.parse(newVersionBuildNumber);
          globals.newVersionBuildNumber = currentBuildNumberdouble;
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  // Future<void> _InternetConnectionChecker() async {
  //   final InternetConnectionChecker customInstance =
  //       InternetConnectionChecker.createInstance(
  //     checkTimeout: const Duration(seconds: 1),
  //     checkInterval: const Duration(seconds: 1),
  //   );
  //   await execute(customInstance);
  // }
  //
  // Future<void> execute(
  //   InternetConnectionChecker internetConnectionChecker,
  // ) async {
  //   print('''The statement 'this machine is connected to the Internet' is: ''');
  //   final bool isConnected = await InternetConnectionChecker().hasConnection;
  //   print(
  //     isConnected.toString(),
  //   );
  //
  //   print(
  //     'Current status: ${await InternetConnectionChecker().connectionStatus}',
  //   );
  //   final StreamSubscription<InternetConnectionStatus> listener =
  //       InternetConnectionChecker().onStatusChange.listen(
  //     (InternetConnectionStatus status) {
  //       switch (status) {
  //         case InternetConnectionStatus.connected:
  //           print(
  //               '''//////////////////////////////////////////////////////    lastToastTime:   $lastToastTime''');
  //
  //           DateTime now = DateTime.now();
  //           if (now.difference(lastToastTime) > Duration(seconds: 2)) {
  //             lastToastTime = now;
  //             Fluttertoast.showToast(
  //                 msg: "اینترنت متصل شد",
  //                 toastLength: Toast.LENGTH_SHORT,
  //                 gravity: ToastGravity.BOTTOM,
  //                 backgroundColor: Colors.green,
  //                 textColor: Colors.white,
  //                 fontSize: 18.0);
  //           }
  //
  //           break;
  //         case InternetConnectionStatus.disconnected:
  //           // ignore: avoid_print
  //           //   print('You are disconnected from the internet joojoo.');
  //           showDialog(
  //               context: context,
  //               builder: (context) => AlertDialog(
  //                     title: Text(
  //                         "لطفا از اتصال دستگاه خود به اینترنت مطمئن شوید. ",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'IRANSans',
  //                           fontSize: 16,
  //                         )),
  //                     actions: <Widget>[
  //                       ElevatedButton(
  //                         child: Text(
  //                           "باشه",
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             // color: Colors.white,
  //                             fontFamily: 'IRANSans',
  //                             fontSize: 12,
  //                           ),
  //                           textAlign: TextAlign.right,
  //                         ),
  //                         onPressed: () {
  //                           setLaterDialog();
  //                           Navigator.pop(context, false);
  //                         },
  //                       ),
  //                     ],
  //                   ));
  //           break;
  //       }
  //     },
  //   );
  // }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> _upgrader() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor:Theme.of(context).brightness ==
              Brightness.light
              ? Colors.white
              : Colors.grey,
          title: Text("نسخه جدیدی از برنامه برای بروزرسانی موجود می باشد.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'IRANSans',
                fontSize: 16,
                color:  Theme.of(context).brightness ==
                    Brightness.light
                    ? Colors.black
                    : Colors.white,
              )),
          actions: <Widget>[
            ElevatedButton(
              child: Text("بروزرسانی",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(245, 178, 3, 1.0),
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
                  color: Color.fromRGBO(245, 178, 3, 1.0),
                  fontFamily: 'IRANSans',
                  fontSize: 12,
                ),
                textAlign: TextAlign.right,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        ));
  }

  setLaterDialog() async {
    bool level = false;
    globals.laterDialog = level;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.LaterDialog, level);
  }

  versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    currentBuildNumber = double.parse(info.buildNumber);

    await _getBuildNumber();
    setState(() {
      globals.currentBuildNumber = currentBuildNumber;
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

  @override
  void initState() {
    currentBackPressTime=DateTime.now();
    lastToastTime = DateTime.now();
    KeepScreenOn.turnOn();
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
    KeepScreenOn.turnOn();
    _initializeMobileAdsSDK();
    _loadAd();

  }
  late DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "برای خروج دو مرتبه برگشت بزنید",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromRGBO(245, 178, 3, 1.0),
          textColor: Colors.white,
          fontSize: 18.0);
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      SystemNavigator.pop();
      return Future.value(false);
    }
  }

  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  final String _adUnitId = Platform.isAndroid
      ? Constants.adUnitId
      : Constants.adUnitId;

  void _loadAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }
    if (!mounted) {
      return;
    }

    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());
    if (size == null) {
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  void _initializeMobileAdsSDK() async {
    MobileAds.instance.initialize();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    MenuItem.add(layout_home());
    return SafeArea(
      child: Scaffold(
          // drawer: Container(
          //
          //     child: Drawer(
          //       backgroundColor:Theme.of(context).brightness ==
          //           Brightness.light
          //           ? Colors.white
          //           : Colors.black,
          //       child: Drawers(
          //           newVersionBuildNumber: globals.newVersionBuildNumber,
          //           currentBuildNumber: globals.currentBuildNumber),
          //     ),
          //     width: 200),
          key: _scaffoldKey,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor:                              Theme.of(context).brightness == Brightness.light
                      ? Colors.green
                      : Colors.black,
                  pinned: true,
                  // title: Text(
                  //   theme_data.title,
                  // style: AppStyle.titleup,
                  // ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    "ویدیوها",
                    style: AppStyle.titleup,
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height ,
                    child: MenuItem[MenuIndex],
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar:(_bannerAd != null && _isLoaded)?
          SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ):null
      ),
    );
  }
}
