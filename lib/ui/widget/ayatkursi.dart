// import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AyatKursi extends StatefulWidget {
  @override
  _AyatKursiState createState() => _AyatKursiState();
}

class _AyatKursiState extends State<AyatKursi> {

  bool isInstalled;

  @override
  Widget build(BuildContext context) {
//    var ui = Provider.of<UiState>(context);
//    return FutureBuilder<AyathKursi>(
//        future: ServiceData().loadAyatKursi(),
//        builder: (context, snapshot) {
//      if (snapshot.hasData) {
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
                      "برنامه مفاتیح الجنان بر گرفته از کتاب مفاتیح الجنان شیخ عباس قمی می باشد. این مفاتیح به ترجمه فصیح و روان حجت السلام شیخ حسین انصاریان مزین شده است. سعی گروه نرم افزاری پایدارت بر این است که بتواند مفاتیح ساده ، سریع و در عین حال کاربردی بدون امکانات درون برنامه ای اضافه بسازد تا انشالله کمکی ناچیز و کوچک برای به همراه داشتن کلیات مفاتیح برای همگان فراهم شود. باشد که این مفاتیح را به نیابت ازهمه پیامبران، ائمه اطهار، معصومین ،شهدا ، علما و اموات مسلمین  برای سلامتی و تعجیل در فرج حضرت ولی عصر عجل الله تعالی فرجه الشریف بخوانیم.\n \nگروه پایدارت را از دعای خیرتان محروم نفرمایید.\nومن الله توفیق\n",
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
//             Text(
//               '   دیگر برنامه ها',
//               style: AppStyle.settingRelated,
//             ),
//             Container(
//               height: 1,
//               color: Color(0xf6c40c0c),
//             ),
//             ListTile(
//                 leading: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
//                     new IconTheme(
//                       data: new IconThemeData(
//                         color: null,
//                       ), //IconThemeData
//
//                       child: Container(
//                         child: new Image.asset("assets/ashoura.png"),
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                     Text(
//                       'زیارت عاشورا',
//                       style: AppStyle.setting,
//                     ),
//                   ],
//                 ),
//                 onTap: () async {
//                   isInstalled =
//                   await DeviceApps.isAppInstalled('pydart.ashoura');
//                   if (isInstalled) {
//                     DeviceApps.openApp('pydart.ashoura');
//                   } else {
//                     String url = Constants.storeUrlAshoura;
//                     if (await canLaunch(url))
//                       await launch(url);
//                     else
//                       throw 'Could not launch $url';
//                   }
//                 }),
//             ListTile(
//                 leading: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
//                     new IconTheme(
//                       data: new IconThemeData(
//                         color: null,
//                       ), //IconThemeData
//
//                       child: Container(
//                         child: new Image.asset("assets/komeil.png"),
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                     Text(
//                       'دعای کمیل',
//                       style: AppStyle.setting,
//                     ),
//                   ],
//                 ),
//                 onTap: () async {
//                   isInstalled =
//                   await DeviceApps.isAppInstalled('pydart.komeil');
//                   if (isInstalled) {
//                     DeviceApps.openApp('pydart.komeil');
//                   } else {
//                     String url = Constants.storeUrlKomeil;
//                     if (await canLaunch(url))
//                       await launch(url);
//                     else
//                       throw 'Could not launch $url';
//                   }
//                 }),
//             ListTile(
//                 leading: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
//                     new IconTheme(
//                       data: new IconThemeData(
//                         color: null,
//                       ), //IconThemeData
//
//                       child: Container(
//                         child: new Image.asset("assets/aahd.png"),
// //                        color: Colors.white,
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                     Text(
//                       'دعای عهد',
//                       style: AppStyle.setting,
//                     ),
//                   ],
//                 ),
//                 onTap: () async {
//                   isInstalled = await DeviceApps.isAppInstalled('pydart.aahd');
//                   if (isInstalled) {
//                     DeviceApps.openApp('pydart.aahd');
//                   } else {
//                     String url = Constants.storeUrlAahd;
//                     if (await canLaunch(url))
//                       await launch(url);
//                     else
//                       throw 'Could not launch $url';
//                   }
//                 }),
//             ListTile(
//                 leading: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
//                     new IconTheme(
//                       data: new IconThemeData(
//                         color: null,
//                       ), //IconThemeData
//
//                       child: Container(
//                         child: new Image.asset("assets/nodbe.png"),
// //                        color: Colors.white,
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                     Text(
//                       'دعای ندبه',
//                       style: AppStyle.setting,
//                     ),
//                   ],
//                 ),
//                 onTap: () async {
//                   isInstalled = await DeviceApps.isAppInstalled('pydart.nodbe');
//                   if (isInstalled) {
//                     DeviceApps.openApp('pydart.nodbe');
//                   } else {
//                     String url = Constants.storeUrlNodbe;
//                     if (await canLaunch(url))
//                       await launch(url);
//                     else
//                       throw 'Could not launch $url';
//                   }
//                 }),
//             ListTile(
//                 leading: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
// //                  Icon( icon: new Image.asset("assets / asmaIcon.png")), // icon-1
// //                  new Image.asset("assets/asmaIcon.png"),
//                     new IconTheme(
//                       data: new IconThemeData(
//                         color: null,
//                       ), //IconThemeData
//
//                       child: Container(
//                         child: new Image.asset("assets/kasa.png"),
// //                        color: Colors.white,
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//
//                     Text(
//                       'حدیث کسا',
//                       style: AppStyle.setting,
//                     ),
//                   ],
//                 ),
//                 onTap: () async {
//                   isInstalled = await DeviceApps.isAppInstalled('pydart.kasa');
//                   if (isInstalled) {
//                     DeviceApps.openApp('pydart.kasa');
//                   } else {
//                     String url = Constants.storeUrlKasa;
//                     if (await canLaunch(url))
//                       await launch(url);
//                     else
//                       throw 'Could not launch $url';
//                   }
//                 }),

            // Center(
            //   child: BannerAd(
            //     "2028260f-a8b1-4890-8ef4-224c4de96e02",
            //     BannerAdSize.LARGE_BANNER,
            //   ),
            // ),
            Center(
              child: AdmobBanner(
                adUnitId: 'ca-app-pub-5524959616213219/5382351205',
                adSize: AdmobBannerSize.LARGE_BANNER,
                // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                //   if (event == AdmobAdEvent.clicked) {}
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
//      return PKCardPageSkeleton(
//        totalLines: 1,
//      );
//    });
//  }
}
