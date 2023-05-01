import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_screen/flutter_screen.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/models/DailyDoa4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:mafatih/ui/detailSec55.dart';

class DetailSec44 extends StatefulWidget {
  final detail, index, indent, indexFasl, code, query;
  DetailSec44({
    Key key,
    @required this.detail,
    this.index,
    this.indent,
    this.indexFasl,
    this.code,
    this.query,
  }) : super(key: key);

  @override
  _DetailSec44State createState() => _DetailSec44State();
}

class _DetailSec44State extends State<DetailSec44> {
  int _selectedIndex = 0;
  SharedPreferences prefs;
  bool isBookmarked;
  static Color iconBookmarkcolor;


  String titleCurrentPage;
  int indexCurrentPage;
  int indexFaslCurrentPage;
  int codeCurrentPage;
  // var themeNotifier = ThemeNotifier();

  ScrollController _controller;
  final itemSize = globals.fontTozihLevel * 1.7;
  final queryOffset = 100;

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

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
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
  double _scrollPosition;
  ScrollController _scrollController;
  setLastScolledPixel(double level) async {
    globals.lastScrolledPixel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.LAST_SCROLLED_PIXEL, level);
    print('globals.lastScrolledPixel');
    print(globals.lastScrolledPixel);
  }
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      setLastScolledPixel(_scrollPosition);
    });
  }
  getLastScolledPixel() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.LAST_SCROLLED_PIXEL)) {
      double _lastScrolledPixel = prefs.getDouble(globals.LAST_SCROLLED_PIXEL);
      setState(() {
        globals.lastScrolledPixel = _lastScrolledPixel;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    print(
        "************************************************************************** widget.indexFasl " +
            widget.indexFasl.toString());
    print(
        "************************************************************************** widget.indexFasl " +
            widget.index.toString());

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

    // /// Update lastViewedPage
    // setLastViewedPage(widget.detail, widget.index, widget.indexFasl);

    if (globals.titleBookMarked == null) {
      isBookmarked = false;
      print("globals.titleBookMarked== null ????????????????????????????");
      globals.titleBookMarked = [];
      globals.indexBookMarked = [];
      globals.indexFaslBookMarked = [];
    }

    /// Prevent screen from going into sleep mode:
    FlutterScreen.keepOn(true);

    super.initState();
  }

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
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
            color: Colors.green
        ),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
  void _scrollToPixel() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(globals.lastScrolledPixel,
          duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToPixel());
    }

  }
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    ui.edameFarazSet==true?WidgetsBinding.instance.addPostFrameCallback((_) {_scrollToPixel();ui.edameFarazSet=false;} ):null;

    return
      Scaffold(
        body: (ui.terjemahan == true)
            ? FutureBuilder<DailyDoa4>(
          future: ServiceData().loadSec4(widget.indexFasl, globals.tarjKhati==true && globals.khatiedDoa.contains(1000 *widget.indexFasl + widget.index) ? (1000 *widget.indexFasl + widget.index).toString() : widget.index.toString() ),
          builder: (c, snapshot) {
            if (snapshot.hasData) {
              titleCurrentPage = snapshot.data.title;
              globals.titleCurrentPage = titleCurrentPage;
              indexCurrentPage = snapshot.data.number;
              globals.indexCurrentPage = indexCurrentPage;
              indexFaslCurrentPage = snapshot.data.bab;
              globals.indexFaslCurrentPage = indexFaslCurrentPage;
              codeCurrentPage =
                  indexFaslCurrentPage * 1000 + indexCurrentPage;
              globals.codeCurrentPage = codeCurrentPage;
              print(
                  "titleCurrentPage      <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   " +
                      titleCurrentPage);
            }

            return snapshot.hasData
                ? Column(children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data.arabic.length,
                    itemBuilder: (BuildContext c, int i) {
                      String key =
                      snapshot.data.arabic.keys.elementAt(i);
                      return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0),
                              child: Column(
                                children: <Widget>[
                                  if (int.parse(key) -
                                      snapshot.data.delay ==
                                      1)
                                    ListTile(
                                      dense: true,
                                      title: Text(
                                        'بِسْمِ اللَّـهِ الرَّ حْمَـٰنِ الرَّ حِيمِ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppStyle
                                              .textQuranfontFamily,
                                          fontSize: 1.2 *
                                              globals.fontArabicLevel,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  if (snapshot.data.arabic[key] !=
                                      "" &&
                                      snapshot.data.arabic[key] !=
                                          null &&
                                      widget.indexFasl >= 4)
                                    ListTile(
                                      dense: true,
                                      title: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          text: replaceFarsiNumber((snapshot
                                              .data
                                              .arabic[key] +
                                              '﴿' +
                                              (int.parse(key) -
                                                  snapshot
                                                      .data
                                                      .delay)
                                                  .toString() +
                                              '﴾')
                                              .toString()),
                                          style: TextStyle(
                                            fontFamily: AppStyle
                                                .textQuranfontFamily,
                                            fontSize: 1.2 *
                                                globals
                                                    .fontArabicLevel,
                                            height: 1.5,
                                            color: Theme.of(context)
                                                .accentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (snapshot.data.farsi[key] !=
                                      null &&
                                      snapshot.data.farsi[key] != "")
                                    ListTile(
                                      dense: true,
                                      title: RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                          children:
                                          highlightOccurrencesDetailSec(
                                              snapshot.data
                                                  .farsi[key],
                                              widget.query,
                                              globals.fontTarjLevel +
                                                  4),
                                          style: TextStyle(
                                            fontFamily: 'عربی ساده',
                                            fontSize:
                                            globals.fontTarjLevel,
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
        )
            : DetailSec55(
          detail: widget.detail,
          index: widget.index,
          indent: widget.indent,
          indexFasl: 5,
          code: widget.indexFasl * 1000 + widget.index,
        ),
        // bottomNavigationBar: AdmobBanner(
        //   adUnitId: 'ca-app-pub-5524959616213219/7557264464',
        //   adSize: AdmobBannerSize.BANNER,
        //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        //   //   if (event == AdmobAdEvent.clicked) {}
        //   // },
        // ),
      );
  }
}