import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/models/FaslInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mafatih/ui/widget/listSec.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'file:///G:/Flutter/Qurani2 -Babs/lib/library/Globals.dart' as globals;
import 'package:mafatih/ui/detailSec.dart';

class ListFasl extends StatefulWidget {
  @override
  _ListFaslState createState() => _ListFaslState();
}

class _ListFaslState extends State<ListFasl> {
  SharedPreferences prefs;

  /// Navigation event handler
  _onItemTapped(int indexTabHome) {
    /// Go to Bookmarked page
    if (indexTabHome == 0) {
      setState(() {
        globals.titleBookMarked = [];
        globals.indexBookMarked = [];
        globals.indexFaslBookMarked = [];

        /// in case Bookmarked page is null (Bookmarked page initialized in splash screen)
        if (globals.indexBookMarked == null) {
          print("globals.titleBookMarked== null ????????????????????????????");
          globals.titleBookMarked = [];
          globals.indexBookMarked = [];
          globals.indexFaslBookMarked = [];

          // globals.titleBookMarked.add(globals.DEFAULT_BOOKMARKED_PAGE_title);
          // globals.indexBookMarked.add(globals.DEFAULT_BOOKMARKED_PAGE_index);
          // globals.indexFaslBookMarked.add(
          //     globals.DEFAULT_BOOKMARKED_PAGE_indexFasl);
        } else {
          getBookmark();
        }

//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => Favorites(
//                titlebookmark: globals.titleBookMarked,
//                indexbookmark: globals.indexBookMarked,
//                indexFaslbookmark: globals.indexFaslBookMarked),
//          ),
//        );
      });
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //         builder: (context) => DetailSec(
      //               detail: globals.titleBookMarked,
      //               index: globals.indexBookMarked,
      //               indexFasl: globals.indexFaslBookMarked,
      //             )), //pages: globals.bookmarkedPage - 1
      // (Route<dynamic> route) => true);

      /// Continue reading
    }
  }

  /// get bookmarkPage from sharedPreferences
  getBookmark() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(globals.BOOKMARKED_PAGE_index)) {
      final titleBookMarked =
          prefs.getStringList(globals.BOOKMARKED_PAGE_title);

      final savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index);
      List<int> indexBookMarked =
          savedStrList.map((i) => int.parse(i)).toList();

      final savedStrFaslList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
      List<int> indexFaslBookMarked =
          savedStrFaslList.map((i) => int.parse(i)).toList();

      setState(() {
        globals.titleBookMarked = titleBookMarked;
        globals.indexBookMarked = indexBookMarked;
        globals.indexFaslBookMarked = indexFaslBookMarked;
      });

      /// if not found return default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FaslInfo>>(
      future: ServiceData().loadFaslInfo(),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? Column(
                children: <Widget>[
                  SizedBox(height: 80),
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
                                        borderRadius: BorderRadius.circular(5),
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
                              borderRadius: BorderRadius.circular(5),
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
                      child: SvgPicture.asset(
                        "assets/tazhibLineOverFaslList.svg",
                      )),
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
