import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/utils/sharedFunc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:week_of_year/date_week_extensions.dart';

import 'home_about.dart';


class Drawers extends StatelessWidget {
  String gif1Url;
  String gif2Url;
  String gif3Url;
  String newVersionBuildNumber;
  double currentBuildNumber;
  Drawers({
    Key key,
    this.gif1Url,
    this.gif2Url,
    this.gif3Url,
    this.newVersionBuildNumber,
    this.currentBuildNumber,
  }) : super(key: key);
  bool isInstalled;
  final SharedFunc sharedfunc = new SharedFunc();

String urlgif1="https://www.videoir.com/apps_versions/gif1.gif";
String urlgif2="https://www.videoir.com/apps_versions/gif2.gif";
String urlgif3="https://www.videoir.com/apps_versions/gif3.gif";

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
//            trailing: Icon(Icons.keyboard_arrow_left),
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
                    if (newVersionBuildNumber!=null && double.parse(newVersionBuildNumber) >
                        currentBuildNumber) {
                      sharedfunc.updater(context);
                    } else if (newVersionBuildNumber==null || double.parse(newVersionBuildNumber) <=
                        currentBuildNumber){
                      sharedfunc.no_update(context);
                    }
                  } catch (e) {
                    print("Exception Caught: $e");
                  }
                }),
            InkWell(
              onTap: () {_launchURL(gif1Url);
              final date = DateTime.now();
                print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
              child: CachedNetworkImage(
                imageUrl: urlgif1,
                cacheKey: urlgif1 + DateTime.now().weekOfYear.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
            SizedBox(height:5),
            InkWell(
              onTap: () {_launchURL(gif2Url);},
              child: CachedNetworkImage(
                imageUrl: urlgif2,
                cacheKey: urlgif2+DateTime.now().weekOfYear.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
            SizedBox(height:5),
            InkWell(
              onTap: () {_launchURL(gif3Url);},
              child: CachedNetworkImage(
                imageUrl: urlgif3,
                cacheKey: urlgif3+DateTime.now().weekOfYear.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-5524959616213219/7557264464',
        adSize: AdmobBannerSize.BANNER,
        // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        //   if (event == AdmobAdEvent.clicked) {}
        // },
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}