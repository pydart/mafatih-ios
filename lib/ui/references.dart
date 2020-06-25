import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:mafatih/data/services.dart';

class Ref extends StatefulWidget {
  @override
  _RefState createState() => _RefState();
}

class _RefState extends State<Ref> {
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    future:
    ServiceData().loadInfo();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
//          onPressed: () => Navigator.of(context).pop(),
          onPressed: () => Navigator.popUntil(
              context, ModalRoute.withName(Navigator.defaultRouteName)),
        ),
        title: Text('فهرست منابع'),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "در این  برنامه سعی شده است که  اسامی الهی با منابع قرآنی آنها تفسیر شوند. اسم سوره و آیه مربوطه در متون  آورده شده اند. ",
                      style: AppStyle.ref,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        "منابع:          قران کریم\n                 پایگاه اطلاع رسانی استاد حسین انصاریان\n                 پرتال فرهنگی راسخون\n                 دانشنامه اسلامی \n",
                        style: AppStyle.ref),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
