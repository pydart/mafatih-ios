import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mafatih/videos/layout/home/layout_home.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:screen_brightness/screen_brightness.dart';
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

  Future<void> _InternetConnectionChecker() async {
    final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );
    await execute(customInstance);
  }

  Future<void> execute(
      InternetConnectionChecker internetConnectionChecker,
      ) async {
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    print(
      isConnected.toString(),
    );

    print(
      'Current status: ${await InternetConnectionChecker().connectionStatus}',
    );
    final StreamSubscription<InternetConnectionStatus> listener =
    InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('''//////////////////////////////////////////////////////    lastToastTime:   $lastToastTime''');

            DateTime now = DateTime.now();
            if (now.difference(lastToastTime) > Duration(seconds: 2)) {
              lastToastTime = now;
              Fluttertoast.showToast(
                  msg: "اینترنت متصل شد",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 18.0);}

            break;
          case InternetConnectionStatus.disconnected:
          // ignore: avoid_print
          //   print('You are disconnected from the internet joojoo.');
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text("اینترنت شما قطع می باشد. برای دسترسی به ویدیوها اینترنت خود را متصل فرمایید. ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IRANSans',
                            fontSize: 16,
                          )),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text(
                            "باشه",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
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
            break;
        }
      },
    );
  }





  @override
  void initState() {
    lastToastTime = DateTime.now();

    KeepScreenOn.turnOn();
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();


    super.initState();
    _InternetConnectionChecker();
    KeepScreenOn.turnOn();

  }



  @override
  Widget build(BuildContext context) {
    MenuItem.add(layout_home());
    return SafeArea(
      child: Scaffold(
          drawer: Container(
              child: Drawer(
                child: Drawers(
                    newVersionBuildNumber: globals.newVersionBuildNumber,
                    currentBuildNumber: globals.currentBuildNumber),
              ),
              width: 200),
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
          )),
    );
  }
}
