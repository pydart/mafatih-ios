import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../consent_manager.dart';
import '../../data/utils/style.dart';
import '../../utils/constants.dart';
import '../Server/server.dart';
import '../models/theme_model.dart';
import 'SingleVideoPage.dart';

class EndlessGridView extends StatefulWidget {
  EndlessGridView(this.cat_id, this.pageNum, this.cat_name, {Key? key})
      : super(key: key);
  final String cat_id;
  int pageNum;
  final String cat_name;

  @override
  _EndlessGridViewState createState() => _EndlessGridViewState();
}

class _EndlessGridViewState extends State<EndlessGridView> {
  List<theme_model> data_theme_model = [];
  bool isLoading = false;
  int page = 1;
  ScrollController _scrollController = ScrollController();
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;
  bool isDisconnected = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
    _startMonitoringConnection();
    _initializeMobileAdsSDK();
    _loadAd();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _connectionSubscription?.cancel(); // Cancel the internet connection subscription
    _bannerAd?.dispose();
    super.dispose();
  }


  void _startMonitoringConnection() {
    _connectionSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
          setState(() {
            isDisconnected = status == InternetConnectionStatus.disconnected;
          });

          if (status == InternetConnectionStatus.connected) {
            // Internet connection is reestablished, refresh the page
            _refreshPage();
          }
        });
  }

  void _refreshPage() {
    setState(() {
      data_theme_model.clear();
      page = 1;
    });
    fetchData();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = MediaQuery.of(context).size.height * 0.50;

    if (maxScroll - currentScroll <= delta && !isLoading) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Fetch data from API
    List<theme_model> newData = await _getDataFromApi(page);

    setState(() {
      isLoading = false;
      data_theme_model.addAll(newData);
      page++;
    });
  }

  Future<List<theme_model>> _getDataFromApi(int page) async {
    List all_vid_each_page = [];
    String UrlApi;

    widget.cat_id == "0"
        ? UrlApi = "video/all-videos"
        : UrlApi = "app/category/${widget.cat_id}";

    var response = await server().Get("${UrlApi}?page=${page.toString()}", true);
    List all_vid_each_page_1 = jsonDecode(response)["data"]["videos"]["data"];
    all_vid_each_page.addAll(all_vid_each_page_1);

    var result = List<theme_model>.from(
        all_vid_each_page.map((x) => theme_model.fromjson(x)));

    return result;
  }


  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
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
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  void _initializeMobileAdsSDK() async {
    MobileAds.instance.initialize();
    _loadAd();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor:                              Theme.of(context).brightness == Brightness.light
                  ? Colors.green
                  : Colors.black,              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Theme.of(context).brightness == Brightness.light
                      ?  Colors.black
                      : Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),

              title: Text(
                widget.cat_name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'IRANSans',
                  color: Theme.of(context).brightness == Brightness.light
                      ?  Colors.black
                      : Colors.white
                ),
                textDirection: TextDirection.rtl,

              ),
            ),
            // if (isDisconnected)
            //   SliverToBoxAdapter(
            //     child: Container(
            //       color: Colors.red,
            //       child: TextButton(
            //         onPressed: _refreshPage,
            //         child: Text(
            //           'تلاش دوباره',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle item tap
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Activity_Review(
                                    theme_data:
                                    data_theme_model[index])));
                        print('Item ${data_theme_model[index].id} tapped');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            data_theme_model[index].cover_address==null?
                            AspectRatio(
                              aspectRatio: 3 / 2,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10), // Set the desired border radius
                                  child:   Image.asset("assets/cover.png",
                                    fit: BoxFit.cover,)
                              ),
                            ):

                            AspectRatio(
                              aspectRatio: 3 / 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10), // Set the desired border radius
                                child: Image.network(
                                  "https://arbaeentv.com/" +
                                      data_theme_model[index].cover_address!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // SizedBox(height: 8.0),
                            RichText(
                              maxLines: 2, // Set maximum lines to 2
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'IRANSans',
                                  fontSize: 12.0,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.black,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ?  Colors.black
                                      : Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: data_theme_model[index].title,
                                  ),
                                  TextSpan(text: '\n'), // Force line break
                                ],
                              ),
                            ),
                            // SizedBox(height: 2.0),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: data_theme_model.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 2, // Set desired aspect ratio
                  mainAxisSpacing: 48.0, // Adjust the spacing between rows
                  crossAxisSpacing: 2.0,
                  crossAxisCount: 2,
                ),
              ),
            ),
            if (isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar:(_bannerAd != null && _isLoaded)?
    SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    ):null
    );
  }
}