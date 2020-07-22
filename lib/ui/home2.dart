import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/detailSec.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_about.dart';
import 'listpage/listFasl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:screen/screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import 'notesSearch.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// Used for Bottom Navigation
  int indexTabHome = 0;

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

      setState(() {
        globals.fontArabicLevel = _fontarabiclevel;
        globals.fontTarjLevel = _fonttarjlevel;
        globals.fontTozihLevel = _fonttozihlevel;
      });

      /// if not found return default value
    } else {
      setState(() {
        globals.fontArabicLevel = 23;
        globals.fontTarjLevel = 21;
        globals.fontTozihLevel = 25;
      });
    }
  }

  @override
  void initState() {
    /// get Saved preferences
    Screen.setBrightness(globals.brightnessLevel);

    getBookmark();
    getLastViewedPage();
//    Timer(Duration(seconds: 3),
//        () => Navigator.pushReplacementNamed(context, "index"));

    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: Container(
            child: Drawer(child: Drawers()),
//        width: 700.0 / MediaQuery.of(context).devicePixelRatio,
            width: 200),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/font_mafatih.png',
                    color: Theme.of(context).brightness == Brightness.light
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bitmap.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                // controller: _tabController,
                children: <Widget>[
                  ListFasl(),
                ],
              ),
            ),
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
    return Container(
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

                    child: SvgPicture.asset(
                      "assets/MafatihDrawer.svg",
//                      fit: BoxFit.cover,
//                      semanticsLabel: 'Feed button',
//                      placeholderBuilder: (context) => Icon(Icons.error),
                    ),

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
            '  مرتبط ها',
            style: AppStyle.settingRelated,
          ),
          Container(
            height: 1,
            color: Colors.green[500],
          ),
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
                      child: new SvgPicture.asset("assets/Asma.svg"),
//                        color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),

                  Text(
                    'اسما',
                    style: AppStyle.setting,
                  ),
                ],
              ),
//              trailing: Icon(Icons.keyboard_arrow_left),
              onTap: () async {
                String url = "https://cafebazaar.ir/app/msh.mehrdad.asma";
                if (await canLaunch(url))
                  await launch(url);
                else
                  throw 'Could not launch $url';
              }),
        ],
      ),
    );
  }
}
