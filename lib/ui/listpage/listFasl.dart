import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/models/FaslInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mafatih/ui/widget/listSec.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import '../detailSec.dart';
import '../detailSec4.dart';
import '../detailSec5.dart';
import '../home2.dart';

class ListFasl extends StatefulWidget {
  @override
  _ListFaslState createState() => _ListFaslState();
}

class _ListFaslState extends State<ListFasl> {
  SharedPreferences prefs;

//  @override
//  void initState() {
//    CheshmakPlugin.removeBannerAds;
//  }
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
      print("***************************************************_scrollPosition    $_scrollPosition ");
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("***************************************************_scrollPosition    $_scrollPosition ");
    var ui = Provider.of<UiState>(context);

    return FutureBuilder<List<FaslInfo>>(
      future: ServiceData().loadFaslInfo(),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? Column(children: <Widget>[
        globals.indexFasllastViewedPage != null ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  child: const Text('نمایش آخرین صفحه',                                            style: TextStyle(
//                                            fontWeight: FontWeight.bold,
                      fontFamily: 'IRANSans',
                      fontSize: 14,
                      height: 1.7,
//                                            color:
//                                                Theme.of(context).buttonColor),
                      color: Color(0xf6c40c0c)),
                  ),
                  onPressed: () async {
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
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[400]
                        : Colors.grey[500],

                  )),


            ],
          ):SizedBox(),                  SizedBox(height: 30),
                  // Container(
                  //   height: 30,
                  //   width: 250,
                  //   child: Image.asset("assets/tazhibLineOverFaslList.png"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data.map((data) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              child: Column(children: [
                                Card(
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                            width: 0.5, color: Colors.green)),
                                    child: Container(
                                        padding: EdgeInsets.all(0.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              ListTile(
                                                title: Center(
                                                  child: Text(
                                                    data.title,
                                                    style: AppStyle.titleBab,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ListSec(
                                                              detail:
                                                                  data.title,
                                                              indexFasl:
                                                                  data.index),
                                                    ),
                                                  );
                                                },
                                              )
                                            ])))
                              ]));
                        }).toList()),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
                      child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side:
                                  BorderSide(width: 0.5, color: Colors.green)),
                          child: Container(
                              padding: EdgeInsets.all(0.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ListTile(
                                        title: Center(
                                          child: Text(
                                            "فهرست منتخب",
                                            style: AppStyle.titleBab,
                                          ),
                                        ),
                                        onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Favorites(
//                                                      titlebookmark: globals
//                                                          .titleBookMarked,
//                                                      indexbookmark: globals
//                                                          .indexBookMarked,
//                                                      indexFaslbookmark: globals
//                                                          .indexFaslBookMarked,

                                                          )),
                                            )
//          ), //_onItemTapped(0),
                                        )
                                  ])))),
                  Container(
                    height: 60,
                    width: 250,
                    // child: SvgPicture.asset(
                    //   "assets/tazhibLineOverFaslList.svg",
                    // ),
                    child: Image.asset("assets/tazhibLineOverFaslList.png"),
                  ),
                ],
              )
//            : PKCardListSkeleton(
//                isCircularImage: true,
//                isBottomLinesActive: true,
//                length: 10,
//              );
            : Container();
      },
    );
  }
}
