import 'package:fluttertoast/fluttertoast.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/models/DailyDoa.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import 'notesSearch.dart';

class DetailSec extends StatefulWidget {
  final detail, index, indent, indexFasl, code, query;
  DetailSec({
    Key key,
    @required this.detail,
    this.index,
    this.indent,
    this.indexFasl,
    this.code,
    this.query,
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
  int codeCurrentPage;
  var themeNotifier = ThemeNotifier();

  ScrollController _controller;
  final itemSize = globals.fontTozihLevel * 1.7;
  final queryOffset = 100;
  double _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _controller.position.pixels;
    });
  }

  _moveUp() {
    //_controller.jumpTo(_controller.offset - itemSize);
    _controller.animateTo(_scrollPosition - 100,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveDown() {
    //_controller.jumpTo(_controller.offset + itemSize);
    _controller.animateTo(_scrollPosition,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                globals.codeBookMarked.remove(globals.codeCurrentPage);
                isBookmarked = false;
                print(
                    "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
              })
            : setState(() {
                iconBookmarkcolor = Colors.red;
                globals.titleBookMarked.add(globals.titleCurrentPage);
                globals.indexBookMarked.add(globals.indexCurrentPage);
                globals.indexFaslBookMarked.add(globals.indexFaslCurrentPage);
                globals.codeBookMarked.add(globals.codeCurrentPage);
                isBookmarked = true;

                print(
                    "toSave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
              });

        if (globals.indexBookMarked != null) {
          setBookmark(globals.titleBookMarked, globals.indexBookMarked,
              globals.indexFaslBookMarked, globals.codeBookMarked);
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
  void setBookmark(List<String> _title, List<int> _index, List<int> _indexFasl,
      List<int> _code) async {
    prefs = await SharedPreferences.getInstance();
//    if (_index[0] != null && !_index[0].isNaN) {
    await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);

    List<String> _strindex = _index.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

    List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

    List<String> _strcode = _code.map((i) => i.toString()).toList();
    await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
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
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    setState(() {
      if (globals.codeBookMarked.contains(widget.code)) {
        print(
            "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.titleBookMarked.contains(${widget.detail})");
        isBookmarked = true;
        iconBookmarkcolor = Colors.red;
      } else {
        print(
            "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.titleBookMarked does NOT contain (${widget.detail})");

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

//  _scrollListener() {
//    if (_controller.offset >= _controller.position.maxScrollExtent &&
//        !_controller.position.outOfRange) {
//      setState(() {
//        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   reach the bottom");
//      });
//    }
//    if (_controller.offset <= _controller.position.minScrollExtent &&
//        !_controller.position.outOfRange) {
//      setState(() {
//        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   reach the top");
//      });
//    }
//  }

  List<TextSpan> highlightOccurrencesDetailSec(
      String source, String query, double _fontSize) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
//          style: TextStyle(
//              fontFamily: 'IRANSans', fontSize: 20, color: Colors.grey[900])
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
            color: Colors.green
            // color: Colors.black,
            ),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
//        _scrollPosition = _controller.offset;
//        print(
//            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> _scrollPosition $_scrollPosition");
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

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
            String smsSaved = "با موفقیت به منتخب ها افزوده شد";
            String smsRemoved = "با موفقیت از منتخب ها حذف شد";
            Fluttertoast.showToast(
                msg: isBookmarked ? smsRemoved : smsSaved,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0);
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
            codeCurrentPage = indexFaslCurrentPage * 1000 + indexCurrentPage;
            globals.codeCurrentPage = codeCurrentPage;
          }

          return snapshot.hasData
              ? Column(children: <Widget>[
//                  Container(
//                    height: 50.0,
//                    color: Colors.green,
//                    child: Center(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          RaisedButton(
//                            child: Text("up"),
//                            onPressed: _moveUp,
//                          ),
//                          RaisedButton(
//                            child: Text("down"),
//                            onPressed: _moveDown,
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        controller: _controller,
//                        itemExtent: 1000,
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
                                      if (snapshot.data.tozih[key] != "" &&
                                          snapshot.data.tozih[key] !=
                                              null) //ui.tafsir &&
                                        ListTile(
//                                      title:  Text(
//                                        '${snapshot.data.tozih[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'AdobeArabic-Regular',
////                                          fontSize: ui.fontSizeTozih,
//                                          fontSize: globals.fontTozihLevel,
//                                          height: 1.5,
//                                        ),
//                                      ),

                                            title: RichText(
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            children:
                                                highlightOccurrencesDetailSec(
                                                    snapshot.data.tozih[key],
                                                    widget.query,
                                                    globals.fontTozihLevel + 4),
                                            style: TextStyle(
//                                            fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    'AdobeArabic-Regular',
                                                fontSize:
                                                    globals.fontTozihLevel,
                                                height: 1.5,
//                                            color:
//                                                Theme.of(context).buttonColor),
                                                color: snapshot.data.arabic["1"]
                                                        .isEmpty
                                                    ? Theme.of(context)
                                                        .accentColor
                                                    : Theme.of(context)
                                                        .buttonColor),
                                          ),
                                        )),

                                      if (snapshot.data.arabic[key] != "" &&
                                          snapshot.data.arabic[key] != null)
                                        ListTile(
                                          // leading: Text(
                                          //   snapshot.data.arabic.keys.elementAt(i),
                                          //   style: AppStyle.number,
                                          // ),
//                                      title: Text(
//                                        '${snapshot.data.arabic[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'Neirizi',
////                                        fontSize: ui.fontSize,
//                                          fontSize: globals.fontArabicLevel,
//
////                                        fontWeight: FontWeight.w600,
//                                          height: 2.5,
//                                        ),
//                                      ),

                                          title: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children:
                                                  highlightOccurrencesDetailSec(
                                                      snapshot.data.arabic[key],
                                                      widget.query,
                                                      globals.fontArabicLevel +
                                                          4),
                                              style: TextStyle(
                                                fontFamily: 'Neirizi',
                                                fontSize:
                                                    globals.fontArabicLevel,
                                                height: 2.5,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                        ),
//                                  AppStyle.spaceH10,

                                      if (ui.terjemahan &&
                                          snapshot.data.farsi[key] != null &&
                                          snapshot.data.farsi[key] != "")
//                                Text(
//                                  'ترجمه',
//                                  style: AppStyle.end2subtitle,
//                                ),
                                        ListTile(
//                                      title: Text(
//                                        '${snapshot.data.farsi[key]}',
//                                        textAlign: TextAlign.justify,
//                                        style: TextStyle(
//                                          fontFamily: 'AdobeArabic-Regular',
////                                          fontSize: ui.fontSizetext,
//                                          fontSize: globals.fontTarjLevel,
//                                          height: 1.5,
//                                        ),
//                                      ),

                                          title: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children:
                                                  highlightOccurrencesDetailSec(
                                                      snapshot.data.farsi[key],
                                                      widget.query,
                                                      globals.fontTarjLevel +
                                                          4),
                                              style: TextStyle(
                                                fontFamily:
                                                    'AdobeArabic-Regular',
                                                fontSize: globals.fontTarjLevel,
                                                height: 1.5,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              ]);
                        },
                      ),
                    ),
                  )
                ])
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
