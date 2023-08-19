import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:mafatih/videos/layout/Global/navbar.dart';
import 'package:mafatih/videos/layout/home/layout_home.dart';
import 'package:mafatih/videos/layout/home/layout_profile.dart';
import 'package:mafatih/videos/layout/home/layout_setting.dart';
import 'package:mafatih/videos/layout/home/layout_theme.dart';

import '../../data/utils/style.dart';
import '../../ui/listpage/home2.dart';
import '../../ui/listpage/notesSearch.dart';
import '../../ui/widget/drawer.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class Activity_Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Activity_Main_State();
}

class Activity_Main_State extends State<Activity_Main> {
  //Global Variables
  var MenuIndex = 0;
  var MenuItem = [];
  var BackPress = false;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    KeepScreenOn.turnOn();

    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  //Main functio start
  @override
  Widget build(BuildContext context) {
    MenuItem.add(layout_home());
    // MenuItem.add(layout_setting());
    //MenuItem.add(layout_theme());
    // MenuItem.add(layout_profile());

    return WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: Scaffold(
              drawer: Container(
                  child: Drawer(
                    child: Drawers(
                        newVersionBuildNumber: globals.newVersionBuildNumber, currentBuildNumber: globals.currentBuildNumber),
                  ),
                  width: 200),

              key: _scaffoldKey,
              // bottomNavigationBar: BottomMenu(context),
              // endDrawer: Container(
              //   width: 250,
              //   child: navbar(),
              // ),

              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,

                      leading:                       IconButton(
                        icon: Icon(
                          Icons.keyboard_backspace,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      title: Text(
                        "ویدیوها",
                        style: AppStyle.titleup,
                      ),

                      // title: Text(
                      //   "ویدیوها",
                      //   style: AppStyle.titleup,
                      // ),


                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         "اربعین TV",
                      //         style: AppStyle.titleup,
                      //       ),
                      //       // Image.asset(
                      //       //   'assets/font_mafatih.png',
                      //       //   color: Theme.of(context).brightness ==
                      //       //           Brightness.light
                      //       //       ? Colors.white
                      //       //       : Colors.green,
                      //       //   height: 150,
                      //       //   width: 152,
                      //       // ),
                      //     ]),
                      // actions: <Widget>[
                      //   // IconButton(
                      //   //   icon: Icon(Icons.search),
                      //   //   onPressed: () {
                      //   //     showSearch(
                      //   //         context: context, delegate: NotesSearch());
                      //   //   },
                      //   // ),
                      // ],
                    )
                  ];
                },

                body: Column(
                  children: [
                    // Container(
                    //   height: 60,
                    //   child: TopAppBar(context),
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height - 60 - 60,
                      child: MenuItem[MenuIndex],
                    )
                  ],
                ),

                // onWillPop: ()async{
                //   if(!BackPress)
                //   {
                //     BackPress=true;
                //     Timer.periodic(Duration(seconds: 1), (timer) {
                //       BackPress=false;
                //     });
                //
                //     Fluttertoast.showToast(
                //         msg: "برای خروج دوبار روی گزینه برگشت بزنید",
                //         gravity: ToastGravity.CENTER,
                //         webPosition: "center",
                //         toastLength: Toast.LENGTH_SHORT,
                //         textColor: Colors.white,
                //         fontSize: 16.0
                //     );
                //
                //     return false;
                //   }
                //   else
                //   {
                //     return true;
                //   }
                // }
              )),
        ));
  }
  //Main functio end

  //top appbar start
  Widget TopAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              child: InkWell(
                  onTap: () {
                    debugPrint("Open");
                    setState(() {
                      _scaffoldKey.currentState?.openEndDrawer();
                    });
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 24,
                  )),
            ),
            Image.asset(
              "assets/textlogo.png",
              height: 50,
            )
          ],
        ),
      ),
    );
  }
  //top appbar end

  //bottom menu start
  Widget BottomMenu(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
            onTap: ((value) {
              setState(() {
                MenuIndex = value;
              });
            }),
            selectedFontSize: 11,
            unselectedFontSize: 11,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            currentIndex: MenuIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: "خانه"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "تنظیمات"),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.theater_comedy),
              //   label: "قالب اختصاصی"
              // ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: "پروفایل"),
            ]));
  }
  //bottom menu end

}
