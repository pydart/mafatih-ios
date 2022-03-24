import 'package:admob_flutter/admob_flutter.dart';
import 'package:mafatih/data/models/ayatkursi.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class AyatKursi extends StatefulWidget {
  @override
  _AyatKursiState createState() => _AyatKursiState();
}

class _AyatKursiState extends State<AyatKursi> {
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
                      "برنامه مفاتیح الجنان بر گرفته از کتاب مفاتیح الجنان شیخ عباس قمی می باشد. این مفاتیح با ترجمه فصیح و روان حجت السلام شیخ حسین انصاریان مزین شده است. سعی گروه نرم افزاری فلاتر بر این است که بتواند مفاتیح ساده ، سریع و در عین حال کاربردی بدون امکانات درون برنامه ای اضافه بسازد تا انشالله کمکی ناچیز و کوچک برای به همراه داشتن کلیات مفاتیح برای همگان فراهم شود. \nگروه پایدارت را از دعای خیرتان محروم نفرمایید\nومن الله توفیق",
                      textAlign: TextAlign.justify,
                      style: AppStyle.about,
                    ),
                    AppStyle.spaceH10,
//                            if (ui.terjemahan) Text(snapshot.data.translation),
//                            if (ui.tafsir)
//                              Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  AppStyle.spaceH10,
//                                  Text(
//                                    'Tafsir',
//                                    style: AppStyle.end2subtitle,
//                                  ),
//                                  AppStyle.spaceH10,
//                                  Text(snapshot.data.tafsir),
//                                ],
//                              ),
                  ],
                ),
              ),
            ),
            AdmobBanner(
              adUnitId: 'ca-app-pub-5524959616213219/7557264464',
              adSize: AdmobBannerSize.BANNER,
              // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //   if (event == AdmobAdEvent.clicked) {}
              // },
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
