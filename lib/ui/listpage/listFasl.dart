import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/models/FaslInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mafatih/ui/widget/listSec.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import '../home2.dart';

class ListFasl extends StatefulWidget {
  @override
  _ListFaslState createState() => _ListFaslState();
}

class _ListFaslState extends State<ListFasl> {
  SharedPreferences prefs;

//  @override
//  void initState() {
//    CheshmakPlugin.removeBannerAds;
//  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FaslInfo>>(
      future: ServiceData().loadFaslInfo(),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? Column(
                children: <Widget>[
                  SizedBox(height: 30),
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
                        children: snapshot.data.map((data) {
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
                                                    data.title,
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
//                                                      titlebookmark: globals
//                                                          .titleBookMarked,
//                                                      indexbookmark: globals
//                                                          .indexBookMarked,
//                                                      indexFaslbookmark: globals
//                                                          .indexFaslBookMarked,

                                                          )),
                                            )
//          ), //_onItemTapped(0),
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
