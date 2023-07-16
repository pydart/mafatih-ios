import 'package:adivery/adivery_ads.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/utils/sharedFunc.dart';
import 'package:week_of_year/date_week_extensions.dart';
import '../../utils/constants.dart';
import '../listpage/home_about.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class Drawers extends StatelessWidget {

  double newVersionBuildNumber;
  double currentBuildNumber;
  Drawers({
    Key key,
    this.newVersionBuildNumber,
    this.currentBuildNumber,
  }) : super(key: key);
  bool isInstalled;
  final SharedFunc sharedfunc = new SharedFunc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              height: 130,
              child: DrawerHeader(
                margin: EdgeInsets.only(bottom: 0.0),
                padding: EdgeInsets.only(right: 0, bottom: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: double.infinity,
                      child: Image.asset("assets/MafatihDrawer.png"),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xf6c40c0c),
            ),
            ListTile(
              leading: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Icon(Icons.info), // icon-1
                  Text(
                    'درباره برنامه',
                    style: AppStyle.setting,
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new HomeAbout()),
              ),
            ),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    Icon(Icons.settings), // icon-1
                    Text(
                      'تنظیمات',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () {
                  // Settings();
                  Navigator.popAndPushNamed(context, '/settings');
                }),
            ListTile(
                leading: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    Icon(Icons.update), // icon-1
                    Text(
                      'بروز رسانی',
                      style: AppStyle.setting,
                    ),
                  ],
                ),
                onTap: () {
                  print("currentBuildNumber $currentBuildNumber");
                  try {
                    if (newVersionBuildNumber!=null && newVersionBuildNumber >
                        currentBuildNumber) {
                      sharedfunc.updater(context);
                    } else if (newVersionBuildNumber==null || newVersionBuildNumber <=
                        currentBuildNumber){
                      sharedfunc.no_update(context);
                    }
                  } catch (e) {
                    print("Exception Caught: $e");
                  }
                }),
            InkWell(
              onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifdrawer1"]);
              final date = DateTime.now();
                print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
              child: CachedNetworkImage(
                imageUrl: Constants.urlgifdrawer1,
                cacheKey: Constants.urlgifdrawer1 + DateTime.now().weekOfYear.toString(),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
            SizedBox(height:5),
            InkWell(
              onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifdrawer2"]);},
              child: CachedNetworkImage(
                imageUrl: Constants.urlgifdrawer2,
                cacheKey: Constants.urlgifdrawer2+DateTime.now().weekOfYear.toString(),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
            SizedBox(height:5),
            InkWell(
              onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifdrawer3"]);},
              child: CachedNetworkImage(
                imageUrl: Constants.urlgifdrawer3,
                cacheKey: Constants.urlgifdrawer3+DateTime.now().weekOfYear.toString(),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
        Center(child: BannerAd("2028260f-a8b1-4890-8ef4-224c4de96e02",BannerAdSize.LARGE_BANNER,)),
            Center(
              child: AdmobBanner(
                adUnitId: 'ca-app-pub-5524959616213219/7557264464',
                adSize: AdmobBannerSize.LARGE_BANNER,
                // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                //   if (event == AdmobAdEvent.clicked) {}
                // },
              ),
            ),

          ],
        ),
      ),
      // bottomNavigationBar: AdmobBanner(
      //   adUnitId: 'ca-app-pub-5524959616213219/7557264464',
      //   adSize: AdmobBannerSize.LARGE_BANNER,
      //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //   //   if (event == AdmobAdEvent.clicked) {}
      //   // },
      // ),
    );
  }
}

