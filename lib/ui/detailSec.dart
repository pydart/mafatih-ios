import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/models/DailyDoa.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///G:/Flutter/Qurani2_Babs_SplitText/lib/library/Globals.dart'
    as globals;
import '../data/utils/style.dart';

class DetailSec extends StatefulWidget {
  final detail, index, indent, indexFasl;
  DetailSec({
    Key key,
    @required this.detail,
    this.index,
    this.indent,
    this.indexFasl,
  }) : super(key: key);

  @override
  _DetailSecState createState() => _DetailSecState();
}

class _DetailSecState extends State<DetailSec> {
  /// Used for Bottom Navigation
  int _selectedIndex = 0;
//  Home indexTabHomeDetailSec = Home();
//  indexTabHomeDetailSec.indexTabHome=0;
  /// Declare SharedPreferences
  SharedPreferences prefs;
  bool isBookmarked;
  static Color iconBookmarkcolor;

  Widget _bookmarkWidget = Container();

  String titleCurrentPage;
  int indexCurrentPage;
  int indexFaslCurrentPage;

  /// Navigation event handler
  _onItemTapped(int indexTab) {
    setState(() {
      _selectedIndex = indexTab;

      /// Go to Bookmarked page
      if (indexTab == 2) {
        isBookmarked
            ? setState(() {
                iconBookmarkcolor = Colors.white;
                globals.titleBookMarked.remove(globals.titleCurrentPage);
                globals.indexBookMarked.remove(globals.indexCurrentPage);
                globals.indexFaslBookMarked
                    .remove(globals.indexFaslCurrentPage);
                globals.titleBookMarked = globals.titleBookMarked;
                globals.indexBookMarked = globals.indexBookMarked;
                globals.indexFaslBookMarked = globals.indexFaslBookMarked;
                print(
                    "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
              })
            : setState(() {
                iconBookmarkcolor = Colors.red;
                globals.titleBookMarked.add(globals.titleCurrentPage);
                globals.indexBookMarked.add(globals.indexCurrentPage);
                globals.indexFaslBookMarked.add(globals.indexFaslCurrentPage);

                print(
                    "toSave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
              });
        if (globals.indexBookMarked != null) {
          setBookmark(globals.titleBookMarked, globals.indexBookMarked,
              globals.indexFaslBookMarked);
        }
      } else if (indexTab == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (indexTab == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings()));
      }
    });
  }

  PageController _pageControllerBuilder() {
    return new PageController(
        initialPage: widget.detail, viewportFraction: 1.1, keepPage: true);
  }

  /// set bookmarkPage in sharedPreferences
  void setBookmark(
      List<String> _title, List<int> _index, List<int> _indexFasl) async {
    prefs = await SharedPreferences.getInstance();
//    if (_index[0] != null && !_index[0].isNaN) {
    await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);

    List<String> _strindex = _index.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

    List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

//    }
  }

  /// set lastViewedPage in sharedPreferences
  void setLastViewedPage(String _titleCurrentPage, int _indexCurrentPage,
      int _indexFaslCurrentPage) async {
    prefs = await SharedPreferences.getInstance();
    if (_indexCurrentPage != null && !_indexCurrentPage.isNaN) {
      prefs.setString(globals.LAST_VIEWED_PAGE_title, _titleCurrentPage);
      globals.titlelastViewedPage =
          prefs.getString(globals.LAST_VIEWED_PAGE_title);

      prefs.setInt(globals.LAST_VIEWED_PAGE_index, _indexCurrentPage);
      globals.indexlastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_index);

      prefs.setInt(globals.LAST_VIEWED_PAGE_indexFasl, _indexFaslCurrentPage);
      globals.indexFasllastViewedPage =
          prefs.getInt(globals.LAST_VIEWED_PAGE_indexFasl);
    }
  }

  closePage(page) async {
    await page.close();
  }

  /// Init Page Controller
  PageController pageController;

  @override
  void initState() {
    setState(() {
      if (globals.titleBookMarked.contains(widget.detail)) {
        print(
            "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.titleBookMarked.contains(widget.detail)");
        isBookmarked = true;
        iconBookmarkcolor = Colors.red;
      } else {
        isBookmarked = false;
        iconBookmarkcolor = Colors.white;
      }
    });

    /// Update lastViewedPage
    setLastViewedPage(widget.detail, widget.index, widget.indexFasl);
    if (globals.titleBookMarked == null) {
      isBookmarked = false;
      print("globals.titleBookMarked== null ????????????????????????????");
      globals.titleBookMarked = [];
      globals.indexBookMarked = [];
      globals.indexFaslBookMarked = [];
    }

    /// Prevent screen from going into sleep mode:
    Screen.keepOn(true);
    super.initState();
  }

//  Future<bool> _onBackPressed() {
//    if (globals.indexBookMarked != null) {
//      setBookmark(globals.titleBookMarked, globals.indexBookMarked,
//          globals.indexFaslBookMarked);
//
//      print(
//          " _onBackPressed   ######################################################   _onBackPressed");
//    }
////    () async => true;
//    Navigator.pop(context, true);
//  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    return
//      WillPopScope(
//      onWillPop: _onBackPressed,
//      onWillPop: () async => true,

        Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.bookmark,
            color: iconBookmarkcolor,
          ),
          onPressed: () {
            _onItemTapped(2);
          },
        ),
        title: Center(
          child: Text(
            widget.detail,
            style: AppStyle.titleupdetailsec,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settings()))),
        ],
      ),
      body: FutureBuilder<DailyDoa>(
        future: ServiceData().loadSec(widget.indexFasl, widget.index),
        builder: (c, snapshot) {
          if (snapshot.hasData) {
            titleCurrentPage = snapshot.data.title;
            globals.titleCurrentPage = titleCurrentPage;
            indexCurrentPage = snapshot.data.number;
            globals.indexCurrentPage = indexCurrentPage;
            indexFaslCurrentPage = snapshot.data.bab;
            globals.indexFaslCurrentPage = indexFaslCurrentPage;
          }

          return snapshot.hasData
              ? Scrollbar(
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data.arabic.length,
                    itemBuilder: (BuildContext c, int i) {
                      String key = snapshot.data.arabic.keys.elementAt(i);
                      // return Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15.0, vertical: 5.0),
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                children: <Widget>[
                                  if (ui.tafsir &&
                                      snapshot.data.tozih[key] != null)
                                    ListTile(
                                      title: Text(
                                        '${snapshot.data.tozih[key]}',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'AdobeArabic-Regular',
//                                          fontSize: ui.fontSizeTozih,
                                          fontSize: globals.fontTozihLevel,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ListTile(
                                    // leading: Text(
                                    //   snapshot.data.arabic.keys.elementAt(i),
                                    //   style: AppStyle.number,
                                    // ),
                                    title: Text(
                                      '${snapshot.data.arabic[key]}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'AdobeArabic-Regular',
//                                        fontSize: ui.fontSize,
                                        fontSize: globals.fontArabicLevel,

//                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  AppStyle.spaceH10,
                                  if (ui.terjemahan)
//                                Text(
//                                  'ترجمه',
//                                  style: AppStyle.end2subtitle,
//                                ),
                                    ListTile(
                                      title: Text(
                                        '${snapshot.data.farsi[key]}',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'AdobeArabic-Regular',
//                                          fontSize: ui.fontSizetext,
                                          fontSize: globals.fontTarjLevel,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ]);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
