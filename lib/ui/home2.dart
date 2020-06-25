import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/detailSec.dart';
import 'package:flutter/material.dart';
import 'home_about.dart';
import 'listpage/listFasl.dart';
import 'package:mafatih/ui/notesSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///G:/Flutter/Qurani2 -Babs/lib/library/Globals.dart' as globals;
import 'package:screen/screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final String dogFoodUrl = 'https://www.svgrepo.com/show/3682/dog-food.svg';

  /// Used for Bottom Navigation
//  int _selectedIndex = 0;
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

  /// Get saved Brightness or the default value if Brightness level is not defined
  getBrightnessLevel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BRIGHTNESS_LEVEL)) {
      var _brightnessLevel = prefs.getDouble(globals.BRIGHTNESS_LEVEL);
      setState(() {
        globals.brightnessLevel =
            _brightnessLevel > 1 ? _brightnessLevel / 10 : _brightnessLevel;
      });
    } else {
      getScreenBrightness();
      // globals.brightnessLevel = globals.DEFAULT_BRIGHTNESS_LEVEL;
    }
  }

  /// Get Screen Brightness
  void getScreenBrightness() async {
    print(globals.brightnessLevel);
    globals.brightnessLevel = await Screen.brightness;
    globals.brightnessLevel = globals.brightnessLevel > 1
        ? globals.brightnessLevel / 10
        : globals.brightnessLevel;
    print(
        "?????????????????????????         ${globals.brightnessLevel} ??????????????????getScreenBrightness?????????????");
  }

  /// get bookmarkPage from sharedPreferences
  getBookmark() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BOOKMARKED_PAGE_index)) {
      var titleBookMarked = prefs.getStringList(globals.BOOKMARKED_PAGE_title);

      var savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index);
      List<int> indexBookMarked =
          savedStrList.map((i) => int.parse(i)).toList();

      var savedStrFaslList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
      List<int> indexFaslBookMarked =
          savedStrFaslList.map((i) => int.parse(i)).toList();

      setState(() {
        globals.titleBookMarked = titleBookMarked;
        globals.indexBookMarked = indexBookMarked;
        globals.indexFaslBookMarked = indexFaslBookMarked;
      });

      /// if not found return default value
    } else {
      // globals.titleBookMarked.add(globals.DEFAULT_BOOKMARKED_PAGE_title);
      // globals.indexBookMarked.add(globals.DEFAULT_BOOKMARKED_PAGE_index);
      // globals.indexFaslBookMarked.add(globals.DEFAULT_BOOKMARKED_PAGE_indexFasl);
    }
  }

  @override
  void initState() {
    // Screen.setBrightness(globals.brightnessLevel);
    Screen.keepOn(true);

    /// get Saved preferences
    getBookmark();
    getBrightnessLevel();
    getLastViewedPage();
//    Timer(Duration(seconds: 3),
//        () => Navigator.pushReplacementNamed(context, "index"));

//    Screen.setBrightness(globals.brightnessLevel);

    setState(() {
      Screen.setBrightness(globals.brightnessLevel);
    });

    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.white,
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
