import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/utils/sharedFunc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consent_manager.dart';
import '../../utils/constants.dart';
import '../listpage/detailSec.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:provider/provider.dart';
import '../listpage/detailSec4.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../listpage/home2.dart';
import '../listpage/settings.dart';

class Favorites extends StatefulWidget {
  List<String?>? titlebookmark = globals.titleBookMarked;
  List<int?>? indexbookmark = globals.indexBookMarked;
  List<int?>? indexFaslbookmark = globals.indexFaslBookMarked;
  List<int?>? codebookmark = globals.codeBookMarked;

  Favorites(
      {Key? key,
       this.titlebookmark,
      this.indexbookmark,
      this.indexFaslbookmark,
      this.codebookmark})
      : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

late SharedPreferences prefs;
final SharedFunc sharedfunc = new SharedFunc();

/// get bookmarkPage from sharedPreferences
getBookmark() async {
  prefs = await SharedPreferences.getInstance();

  if (globals.indexBookMarked == null) {
    print("globals.titleBookMarked== null ????????????????????????????");
    globals.titleBookMarked = [];
    globals.indexBookMarked = [];
    globals.indexFaslBookMarked = [];
    globals.codeBookMarked = [];
  } else if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code)) {
    final List<String> titleBookMarked = prefs.getStringList(globals.BOOKMARKED_PAGE_title)!;

    final savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index)!;
    List<int> indexBookMarked = savedStrList.map((i) => int.parse(i)).toList();

    final savedStrFaslList =
        prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl)!;
    List<int> indexFaslBookMarked =
        savedStrFaslList.map((i) => int.parse(i)).toList();

    List<String> savedStrCodeList =
        prefs.getStringList(globals.BOOKMARKED_PAGE_Code)!;
    List<int> codeBookMarked =
        savedStrCodeList.map((i) => int.parse(i)).toList();

    globals.titleBookMarked = titleBookMarked;
    globals.indexBookMarked = indexBookMarked;
    globals.indexFaslBookMarked = indexFaslBookMarked;
    globals.codeBookMarked = codeBookMarked;
  }

  if (globals.indexBookMarked == null) {





    List mapBookMarked = [
      for (int i = 0; i < globals.codeBookMarked!.length; i++)
        {
          'index': i,
          'titleBookMarked': globals.titleBookMarked![i],
          'indexBookMarked': globals.indexBookMarked![i],
          'indexFaslBookMarked': globals.indexFaslBookMarked![i],
          'codeBookMarked': globals.codeBookMarked![i]
        }
    ];
    globals.mapBookMarked = mapBookMarked;
    print(
        '-----------------------------------------------mapBookMarked----------------------------------------$mapBookMarked');
  } else if (prefs.containsKey(globals.BOOKMARKED_MAP)) {
    // await prefs.setmap(globals.BOOKMARKED_PAGE_title, _title);
  }
}

/// set bookmarkPage in sharedPreferences
void setBookmark(List<String?> _title, List<int?> _index, List<int?> _indexFasl,
    List<int?> _code) async {
  prefs = await SharedPreferences.getInstance();
//    if (_index[0] != null && !_index[0].isNaN) {
  await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title as List<String>);

  List<String> _strindex = _index.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

  List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

  List<String> _strcode = _code.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
}


class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    _initializeMobileAdsSDK();
    _loadAd();

    getBookmark();
    widget.titlebookmark = globals.titleBookMarked;
    widget.indexbookmark = globals.indexBookMarked;
    widget.indexFaslbookmark = globals.indexFaslBookMarked;
    widget.codebookmark = globals.codeBookMarked;
    List mapBookMarked = [
      for (int i = 0; i < globals.codeBookMarked!.length; i++)
        {
          'index': i,
          'titleBookMarked': globals.titleBookMarked![i],
          'indexBookMarked': globals.indexBookMarked![i],
          'indexFaslBookMarked': globals.indexFaslBookMarked![i],
          'codeBookMarked': globals.codeBookMarked![i]>1000000?int.parse(globals.codeBookMarked![i].toString().replaceAll(RegExp(r'0*$'), '').substring(globals.codeBookMarked![i].toString().length - 3)):globals.codeBookMarked![i],
          // 'codeBookMarked': globals.codeBookMarked![i]
        }
    ];
    globals.mapBookMarked = mapBookMarked;
//    Favorites();
  }

  /// Navigation event handler
  _onItemTapped(int indexTab, int _indexlocal) {
    setState(() {
      String? _title = globals.mapBookMarked[_indexlocal]['titleBookMarked'];
      int? _index =
          (globals.mapBookMarked[_indexlocal]['codeBookMarked'] - 1000000) ~/
              1000;
      // int? _indexKey = (((globals.mapBookMarked[_indexlocal]['codeBookMarked']) %
      //     1000) -
      //     1) <
      //     0
      //     ? 0
      //     : (((globals.mapBookMarked[_indexlocal]['codeBookMarked']) % 1000) -
      //     1);
      int _indexFasl = 1;
      int? _code = globals.mapBookMarked[_indexlocal]['codeBookMarked'];
      // globals.titleCurrentPage=
      //     globals.indexCurrentPage
      // globals.indexFaslCurrentPage

      if (indexTab == 2) {
        if (globals.codeBookMarked!.contains(_code))
          setState(() {
            globals.titleBookMarked!.remove(_title);
            globals.indexBookMarked!.remove(_index);
            globals.indexFaslBookMarked!.remove(_indexFasl);
            globals.codeBookMarked!.remove(_code);
            print(
                "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
            print(
                "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.codeBookMarked}");
            widget.titlebookmark = globals.titleBookMarked;
            widget.indexbookmark = globals.indexBookMarked;
            widget.indexFaslbookmark = globals.indexFaslBookMarked;
            widget.codebookmark = globals.codeBookMarked;
            List mapBookMarked = [
              for (int i = 0; i < globals.codeBookMarked!.length; i++)
                {
                  'index': i,
                  'titleBookMarked': globals.titleBookMarked![i],
                  'indexBookMarked': globals.indexBookMarked![i],
                  'indexFaslBookMarked': globals.indexFaslBookMarked![i],
                  'codeBookMarked': globals.codeBookMarked![i],
                }
            ];
            globals.mapBookMarked = mapBookMarked;

            setBookmark(
                globals.titleBookMarked!,
                globals.indexBookMarked!,
                globals.indexFaslBookMarked!,
                globals.codeBookMarked!);
          });

      } else if (indexTab == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (indexTab == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings()));
      }
    });
  }


  Future<bool?> _onDeletePressed(context, _index) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("آیا قصد پاک کردن منتخب را دارید؟"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("بله"),
              onPressed: () {
                String smsSaved = "با موفقیت به منتخب ها افزوده شد";
                String smsRemoved = "با موفقیت از منتخب ها حذف شد";
                Fluttertoast.showToast(
                    msg:
                    // (globals.codeBookMarked
                    //             .contains(globals
                    //                         .mapBookMarked[
                    //                     index][
                    //                 'codeBookMarked'])) ==
                    //         true ??
                    smsRemoved,
                    // : smsSaved,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 18.0);
                _onItemTapped(2, _index);
                Navigator.pop(context, false);
              },
            ),
            ElevatedButton(
              child: Text(
                "خیر",
                textAlign: TextAlign.right,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ));
  }

  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  Orientation? _currentOrientation;

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
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  /// Initialize the Mobile Ads SDK if the SDK has gathered consent aligned with
  /// the app's configured messages.
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
    var ui = Provider.of<UiState>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor:Theme.of(context).brightness == Brightness.light
              ? Colors.green
              : Colors.black,
          centerTitle: true,
          title: Text(
            "فهرست منتخب",
            style: AppStyle.titleup,
          ),
          elevation: 0.0,
          actions: <Widget>[

          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ReorderableListView(
              children: new List.generate(
                  // widget.numCard,
                  globals.mapBookMarked.length,
                  (index) => Card(
                      key: ValueKey(globals.mapBookMarked[index]),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(width: 0.5, color: Colors.green)),
                      child: Container(
                          padding: EdgeInsets.all(1),
                          // child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          child: new ListTile(

                              title: IntrinsicHeight(
                                child: Stack(
                                  children: [
                                    Align(
                                      child: Text(
                                        globals.mapBookMarked[index]
                                            ['titleBookMarked'],
                                        style: AppStyle.title,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              leading: Icon(
                                Icons.height,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  _onDeletePressed(context,index);
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 16),
//                            dense: true,

                              onTap: () {
                                if (globals.mapBookMarked[index]
                                        ['indexFaslBookMarked'] !=
                                    4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailSec(
                                                detail:
                                                    globals.mapBookMarked[index]
                                                        ['titleBookMarked'],
                                                index:
                                                    globals.mapBookMarked[index]
                                                            ['codeBookMarked'] %
                                                        1000,
                                                // 1,
                                                indexFasl:
                                                    globals.mapBookMarked[index]
                                                            [
                                                            'codeBookMarked'] ~/
                                                        1000,
                                                code:
                                                    globals.mapBookMarked[index]
                                                        ['codeBookMarked'],
                                              ))).then((value) {
                                    setState(() {
                                      widget.titlebookmark =
                                          globals.titleBookMarked;
                                      widget.indexbookmark =
                                          globals.indexBookMarked;
                                      widget.indexFaslbookmark =
                                          globals.indexFaslBookMarked;
                                      widget.codebookmark =
                                          globals.codeBookMarked;
                                      List mapBookMarked = [
                                        for (int i = 0;
                                            i < globals.codeBookMarked!.length;
                                            i++)
                                          {
                                            'index': i,
                                            'titleBookMarked':
                                                globals.titleBookMarked![i],
                                            'indexBookMarked':
                                                globals.indexBookMarked![i],
                                            'indexFaslBookMarked':
                                                globals.indexFaslBookMarked![i],
                                            'codeBookMarked':
                                                globals.codeBookMarked![i],
                                          }
                                      ];
                                      globals.mapBookMarked = mapBookMarked;
                                    });
                                  });
                                } else if (globals.mapBookMarked[index]
                                            ['indexFaslBookMarked'] ==
                                        4 &&
                                    !ui.terjemahan!) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailSec4(
                                                detail:
                                                    globals.mapBookMarked[index]
                                                        ['titleBookMarked'],
                                                index:
                                                    globals.mapBookMarked[index]
                                                        ['indexBookMarked'],
                                                // 1,
                                                indexFasl: globals
                                                                .mapBookMarked[
                                                            index][
                                                        'indexFaslBookMarked'] +
                                                    1,
                                                code:
                                                    globals.mapBookMarked[index]
                                                        ['codeBookMarked'],
                                              ))).then((value) {
                                    setState(() {
                                      widget.titlebookmark =
                                          globals.titleBookMarked;
                                      widget.indexbookmark =
                                          globals.indexBookMarked;
                                      widget.indexFaslbookmark =
                                          globals.indexFaslBookMarked;
                                      widget.codebookmark =
                                          globals.codeBookMarked;
                                      List mapBookMarked = [
                                        for (int i = 0;
                                            i < globals.codeBookMarked!.length;
                                            i++)
                                          {
                                            'index': i,
                                            'titleBookMarked':
                                                globals.titleBookMarked![i],
                                            'indexBookMarked':
                                                globals.indexBookMarked![i],
                                            'indexFaslBookMarked':
                                                globals.indexFaslBookMarked![i],
                                            'codeBookMarked':
                                                globals.codeBookMarked![i],
                                          }
                                      ];
                                      globals.mapBookMarked = mapBookMarked;
                                    });
                                  });
                                } else if (globals.mapBookMarked[index]
                                            ['indexFaslBookMarked'] ==
                                        4 &&
                                    ui.terjemahan!) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailSec4(
                                                detail:
                                                    globals.mapBookMarked[index]
                                                        ['titleBookMarked'],
                                                index:
                                                    globals.mapBookMarked[index]
                                                        ['indexBookMarked'],
                                                // 1,
                                                indexFasl:
                                                    globals.mapBookMarked[index]
                                                        ['indexFaslBookMarked'],
                                                code:
                                                    globals.mapBookMarked[index]
                                                        ['codeBookMarked'],
                                              ))).then((value) {
                                    setState(() {
                                      widget.titlebookmark =
                                          globals.titleBookMarked;
                                      widget.indexbookmark =
                                          globals.indexBookMarked;
                                      widget.indexFaslbookmark =
                                          globals.indexFaslBookMarked;
                                      widget.codebookmark =
                                          globals.codeBookMarked;
                                      List mapBookMarked = [
                                        for (int i = 0;
                                            i < globals.codeBookMarked!.length;
                                            i++)
                                          {
                                            'index': i,
                                            'titleBookMarked':
                                                globals.titleBookMarked![i],
                                            'indexBookMarked':
                                                globals.indexBookMarked![i],
                                            'indexFaslBookMarked':
                                                globals.indexFaslBookMarked![i],
                                            'codeBookMarked':
                                                globals.codeBookMarked![i],
                                          }
                                      ];
                                      globals.mapBookMarked = mapBookMarked;
                                    });
                                  });
                                  ;
                                }
                              })))),
              onReorder: reorderData,
            )),
        bottomNavigationBar:(_bannerAd != null && _isLoaded)?
        SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ):null
        );
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = globals.mapBookMarked.removeAt(oldindex);
      globals.mapBookMarked.insert(newindex, items);
      print(
          '-----------------------------------------------mapBookMarked----------------------------------------${globals.mapBookMarked}');
      globals.titleBookMarked = [];
      globals.indexBookMarked = [];
      globals.indexFaslBookMarked = [];
      globals.codeBookMarked = [];

      for (int i = 0; i < globals.mapBookMarked.length; i++) {
        globals.titleBookMarked!
            .insert(i, globals.mapBookMarked[i]['titleBookMarked']);
        globals.indexBookMarked!
            .insert(i, globals.mapBookMarked[i]['indexBookMarked']);
        globals.indexFaslBookMarked!
            .insert(i, globals.mapBookMarked[i]['indexFaslBookMarked']);
        globals.codeBookMarked!
            .insert(i, globals.mapBookMarked[i]['codeBookMarked']);
      }
      setBookmark(globals.titleBookMarked!, globals.indexBookMarked!,
          globals.indexFaslBookMarked!, globals.codeBookMarked!);
    });
  }
}
