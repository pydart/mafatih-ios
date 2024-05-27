import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

import '../../consent_manager.dart';
import '../../utils/constants.dart';
import '../../videos/Screens/EndlessGridView.dart';
import '../../videos/Screens/MainVideos.dart';

class ListFasl extends StatefulWidget {
  @override
  _ListFaslState createState() => _ListFaslState();
}

class _ListFaslState extends State<ListFasl> {
  late SharedPreferences prefs;

  final SharedFunc sharedfunc = new SharedFunc();

  PageController? pageController;
  late double _scrollPosition;
  late ScrollController _scrollController;
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
      double? _lastScrolledPixel = prefs.getDouble(globals.LAST_SCROLLED_PIXEL);
      setState(() {
        globals.lastScrolledPixel = _lastScrolledPixel;
      });
    }
  }

  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  Orientation? _currentOrientation;

  final String _adUnitId = Platform.isAndroid
      ? Constants.adUnitId
      : Constants.adUnitId;


  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the width of the screen.
  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    if (!mounted) {
      return;
    }

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());

    if (size == null) {
      // Unable to get width of anchored banner.
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
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    var canRequestAds = await _consentManager.canRequestAds();
    if (canRequestAds) {
      setState(() {
        _isMobileAdsInitializeCalled = true;
      });

      // Initialize the Mobile Ads SDK.
      MobileAds.instance.initialize();
      // Load an ad.
      _loadAd();
    }
  }


  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _consentManager.gatherConsent((consentGatheringError) {
      if (consentGatheringError != null) {
        // Consent not obtained in current session.
        debugPrint(
            "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
      }

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();

    // Load an ad.
    _loadAd();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("***************************************************_scrollPosition    $_scrollPosition ");
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
                        children: snapshot.data!.map((data) {
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
                                                    data.title!,
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
                                                     titlebookmark: globals
                                                         .titleBookMarked,
//                                                      indexbookmark: globals
//                                                          .indexBookMarked,
//                                                      indexFaslbookmark: globals
//                                                          .indexFaslBookMarked,

                                                          )),
                                            )
//          ), //_onItemTapped(0),
                                        ),

                                  ])))),
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
                                    "ویدیوها",
                                    style: AppStyle.titleBab,
                                  ),
                                ),

                                  onTap: () => Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_Main()  ))),

        // onTap: () => Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) =>
        //                                   Activity_Main()),
        //                         )
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
          // InkWell(
          //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap!["urlgiffirstpage1"]);
          //   final date = DateTime.now();
          //   print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
          //   child: CachedNetworkImage(
          //     imageUrl: Constants.urlgiffirstpage1,
          //     cacheKey: Constants.urlgiffirstpage1 + DateTime.now().weekOfYear.toString(),
          //     errorWidget: (context, url, error) => SizedBox.shrink(),
          //   ),
          // ),
          // SizedBox(height:5),
          // InkWell(
          //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap!["urlgiffirstpage2"]);},
          //   child: CachedNetworkImage(
          //     imageUrl: Constants.urlgiffirstpage2,
          //     cacheKey: Constants.urlgiffirstpage2+DateTime.now().weekOfYear.toString(),
          //     errorWidget: (context, url, error) => SizedBox.shrink(),
          //   ),
          // ),
          // SizedBox(height:5),
          // InkWell(
          //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap!["urlgiffirstpage3"]);},
          //   child: CachedNetworkImage(
          //     imageUrl: Constants.urlgiffirstpage3,
          //     cacheKey: Constants.urlgiffirstpage3+DateTime.now().weekOfYear.toString(),
          //     errorWidget: (context, url, error) => SizedBox.shrink(),
          //   ),
          // ),
          // Center(
          //   // child: AdmobBanner(
          //   //   adUnitId: 'ca-app-pub-5524959616213219/5790610979',
          //   //   adSize: AdmobBannerSize.LARGE_BANNER,
          //   //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //   //   //   if (event == AdmobAdEvent.clicked) {}
          //   //   // },
          //   // ),
          // ),
          // BannerAd("2028260f-a8b1-4890-8ef4-224c4de96e02",BannerAdSize.LARGE_BANNER,
          // )

          // bottomNavigationBar:
          // OrientationBuilder(
          //   builder: (context, orientation) {
          //     if (_currentOrientation != orientation) {
          //       _isLoaded = false;
          //       _loadAd();
          //       _currentOrientation = orientation;
          //     }
               Stack(
                children: [
                  if (_bannerAd != null && _isLoaded)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: SizedBox(
                          width: _bannerAd!.size.width.toDouble(),
                          height: _bannerAd!.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd!),
                        ),
                      ),
                    )
                ],
              )


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
