import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../consent_manager.dart';
import '../../utils/constants.dart';


class AyatKursi extends StatefulWidget {
  @override
  _AyatKursiState createState() => _AyatKursiState();
}


class _AyatKursiState extends State<AyatKursi> {

  @override
  void initState() {
    _consentManager.gatherConsent((consentGatheringError) {
      _initializeMobileAdsSDK();
    });
    _initializeMobileAdsSDK();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }


  bool? isInstalled;
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
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "برنامه مفاتیح الجنان بر گرفته از کتاب مفاتیح الجنان شیخ عباس قمی می باشد. این مفاتیح به ترجمه فصیح و روان حجت السلام شیخ حسین انصاریان مزین شده است. سعی گروه نرم افزاری پایدارت بر این است که بتواند مفاتیح ساده ، سریع و در عین حال کاربردی بدون امکانات درون برنامه ای اضافه بسازد تا انشالله کمکی ناچیز و کوچک برای به همراه داشتن کلیات مفاتیح برای همگان فراهم شود. باشد که این مفاتیح را به نیابت ازهمه پیامبران، ائمه اطهار، معصومین ،شهدا ، علما و اموات مسلمین  برای سلامتی و تعجیل در فرج حضرت ولی عصر عجل الله تعالی فرجه الشریف بخوانیم.\n بخش ویدیوها بستری است تا بتوانیم آرشیو کاملی از سخنرانی های مطرح در مباحث مذهبی گرداوری کنیم .هدف از این بخش این است که  شما کاربران گرامی به راحتی بتوانید مباحث دینی سخنرانان مورد علاقه خود را دنبال کنید. تمامی محتوای استفاده شده در قسمت ویدیو ها از سایت های مرجع سخنرانان بوده و بدون هیچ دخل و تصرفی به اشتراک گذاشته می شود.\n\nگروه پایدارت را از دعای خیرتان محروم نفرمایید.\nومن الله توفیق\n",
                      textAlign: TextAlign.justify,
                      style: AppStyle.about,
                    ),
                    AppStyle.spaceH10,
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'ارتباط با ما :',
                  textAlign: TextAlign.right,
                  style: AppStyle.about,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () async {
                    String tel =
                        'tel://+989356007935';
                    if (await canLaunch(tel))
                      await launch(tel);
                    else
                      throw 'Could not launch $tel';
                  },
                  icon: Text(
                    '989356007935+',
                    textAlign: TextAlign.justify,
                    style: AppStyle.contactus,
                  ),
                  label: Icon(
                    Icons.call,
                    size: 30,
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () async {
                    String urlgmail =
                        'mailto:pydart.com@gmail.com?subject=This is Subject Title&body=This is Body of Email';
                    if (await canLaunch(urlgmail))
                      await launch(urlgmail);
                    else
                      throw 'Could not launch $urlgmail';
                  },
                  icon: Text(
                    'pydart.com@gmail.com',
                    textAlign: TextAlign.justify,
                    style: AppStyle.contactus,
                  ),
                  label: Icon(
                    Icons.email_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton.icon(
                  onPressed: () async {
                    String urlInsta = "https://www.instagram.com/pydart";
                    String url = urlInsta;
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      throw 'Could not launch $url';
                  },
                  icon: Text(
                    ' pydart@',
                    textAlign: TextAlign.justify,
                    style: AppStyle.contactus,
                  ),
                  label: Image.asset(
                    "assets/Instagram.png",
                    width: 30,
                    height: 30,
                    color: Colors.green,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Center(
              child: Stack(
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
            ),
          ],
        ),
      ),
    );
  }
}
