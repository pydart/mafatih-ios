import 'package:adivery/adivery_ads.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mafatih/data/models/FaslInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/ui/listpage/listSec.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:mafatih/utils/sharedFunc.dart';
import 'package:week_of_year/date_week_extensions.dart';

import '../../utils/constants.dart';

class ListFasl extends StatefulWidget {
  @override
  _ListFaslState createState() => _ListFaslState();
}

class _ListFaslState extends State<ListFasl> {
  SharedPreferences prefs;

  final SharedFunc sharedfunc = new SharedFunc();

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
          InkWell(
            onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgiffirstpage1"]);
            final date = DateTime.now();
            print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
            child: CachedNetworkImage(
              imageUrl: Constants.urlgiffirstpage1,
              cacheKey: Constants.urlgiffirstpage1 + DateTime.now().weekOfYear.toString(),
              errorWidget: (context, url, error) => SizedBox.shrink(),
            ),
          ),
          SizedBox(height:5),
          InkWell(
            onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgiffirstpage2"]);},
            child: CachedNetworkImage(
              imageUrl: Constants.urlgiffirstpage2,
              cacheKey: Constants.urlgiffirstpage2+DateTime.now().weekOfYear.toString(),
              errorWidget: (context, url, error) => SizedBox.shrink(),
            ),
          ),
          SizedBox(height:5),
          InkWell(
            onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgiffirstpage3"]);},
            child: CachedNetworkImage(
              imageUrl: Constants.urlgiffirstpage3,
              cacheKey: Constants.urlgiffirstpage3+DateTime.now().weekOfYear.toString(),
              errorWidget: (context, url, error) => SizedBox.shrink(),
            ),
          ),
          Center(
            child: AdmobBanner(
              adUnitId: 'ca-app-pub-5524959616213219/5790610979',
              adSize: AdmobBannerSize.LARGE_BANNER,
              // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //   if (event == AdmobAdEvent.clicked) {}
              // },
            ),
          ),
          // BannerAd("2028260f-a8b1-4890-8ef4-224c4de96e02",BannerAdSize.LARGE_BANNER,
          // )
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
