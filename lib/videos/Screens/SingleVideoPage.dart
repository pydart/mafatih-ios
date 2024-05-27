import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:share_plus/share_plus.dart';

import '../../consent_manager.dart';
import '../../utils/constants.dart';
import '../Widgets/videoPlayer/player_page.dart';
import '../models/theme_model.dart';

class Activity_Review extends StatefulWidget {
  Activity_Review({required this.theme_data});
  final theme_model theme_data;

  @override
  State<StatefulWidget> createState() => Activity_Review_State();
}

class Activity_Review_State extends State<Activity_Review> {
  bool isDownloading = false;
  String downloadMessage = 'دانلود';

  Future<void> _downloadFile() async {
    setState(() {
      isDownloading = true;
      downloadMessage = 'در حال دانلود';
    });

    try {
      var request = await http.get(Uri.parse(
          'https://arbaeentv.com/' + widget.theme_data.video_address!));
      var bytes = request.bodyBytes;
      String dir = (await getExternalStorageDirectory())!.path;
      File file = File('$dir/${widget.theme_data.title}.mp4');
      await file.writeAsBytes(bytes);
      setState(() {
        isDownloading = false;
        downloadMessage = 'دانلود شد';
      });
      print('Video downloaded successfully in $file');
      Fluttertoast.showToast(msg: ' $fileویدیو دانلود شد در فایل: ',toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 3,);
    } catch (e) {
      setState(() {
        isDownloading = false;
        downloadMessage = 'دانلود';
      });
      Fluttertoast.showToast(msg: 'دانلود انجام نشد');
    }
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
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _initializeMobileAdsSDK();
    _loadAd();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title:           RichText(
                  maxLines: 1, // Set maximum lines to 2
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'IRANSans',
                      fontSize: 16.0,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black,
                      color: Theme.of(context).brightness == Brightness.light
                          ?  Colors.black
                          : Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: widget.theme_data.title,
                      ),
                    ],
                  ),
                ),
                backgroundColor:                              Theme.of(context).brightness == Brightness.light
                    ? Colors.green
                    : Colors.black,                pinned: true,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace,                   color: Theme.of(context).brightness == Brightness.light
                      ?  Colors.black
                      : Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  VideoPlayer(context),
                  Content(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }

  // Video Player Start
  Widget VideoPlayer(BuildContext context) {
    print(
        "//////////////////////////////////   theme_data            //////////////  ${widget.theme_data}");

    return Container(
      width: MediaQuery.of(context).size.width - 14,
      margin: EdgeInsets.all(14),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: SafeArea(
          child: new PydartVideoPlayer(
            url: "https://arbaeentv.com/" + widget.theme_data.video_address!,
          ),
        ),
      ),
    );
  }
  late final VoidCallback onDownloadPressed;

  // Content Start
  Widget Content(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.fromLTRB(14,14,14,1),
      width: MediaQuery.of(context).size.width - 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.theme_data.title!,
            style: TextStyle(fontSize: 16, fontFamily: 'IRANSans',                    color: Theme.of(context).brightness == Brightness.light
                ?  Colors.black
                : Colors.white,),
          ),
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            height: 1,
            color: Theme.of(context).brightness == Brightness.light
                ?  Colors.black
                : Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor:                              Theme.of(context).brightness == Brightness.light
                          ? Colors.green
                          : Colors.black,                      child: Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(

                      replaceFarsiNumber(widget.theme_data.duration!),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        color: Theme.of(context).brightness == Brightness.light
                            ?  Colors.black
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () =>     Share.share("https://arbaeentv.com/video/" + widget.theme_data.slug!),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor:                              Theme.of(context).brightness == Brightness.light
                          ? Colors.green
                          : Colors.black,
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),

                    Text(
                      "اشتراک گذاری",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        color: Theme.of(context).brightness == Brightness.light
                            ?  Colors.black
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              DownloadButton(
                isDownloading: isDownloading,
                downloadMessage: downloadMessage,
                onDownloadPressed: _downloadFile,
              ),

            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            height: 1,
            color: Color(0XFFb0b6bf),
          ),
          if (_bannerAd != null && _isLoaded)
          SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        ],
      ),
    );
  }

// Content End
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    required this.isDownloading,
    required this.downloadMessage,
    required this.onDownloadPressed,
  });

  final bool isDownloading;
  final String downloadMessage;
  final VoidCallback onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDownloading ? null : onDownloadPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor:                              Theme.of(context).brightness == Brightness.light
                ? Colors.green
                : Colors.black,
            child: Icon(
              Icons.download,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            downloadMessage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'IRANSans',
              color: Theme.of(context).brightness == Brightness.light
                  ?  Colors.black
                  : Colors.white,
            ),
          )
        ],
      ),
    );


    // return GestureDetector(
    //   onTap: () => isDownloading ? null : onDownloadPressed,
    //   child: Column(
    //     children: [
    //       CircleAvatar(
    //         backgroundColor: Color.fromRGBO(245, 178, 3, 1.0),
    //         child: Icon(
    //           Icons.download,
    //           color: Colors.white,
    //         ),
    //       ),
    //       SizedBox(height: 8.0),
    //       Text(
    //         downloadMessage,
    //         style: TextStyle(
    //           fontSize: 12,
    //           fontWeight: FontWeight.bold,
    //           fontFamily: 'IRANSans',
    //           color: Theme.of(context).brightness == Brightness.light
    //               ?  Colors.black
    //               : Colors.white,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}