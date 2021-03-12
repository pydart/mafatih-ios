import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../detailSec.dart';
import '../home2.dart';
import '../notesSearch.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:provider/provider.dart';
import '../detailSec4.dart';
import 'package:mafatih/data/uistate.dart';

class Favorites extends StatefulWidget {
  List<String> titlebookmark = globals.titleBookMarked;
  List<int> indexbookmark = globals.indexBookMarked;
  List<int> indexFaslbookmark = globals.indexFaslBookMarked;
  List<int> codebookmark = globals.codeBookMarked;

  Favorites(
      {Key key,
      @required this.titlebookmark,
      this.indexbookmark,
      this.indexFaslbookmark,
      this.codebookmark})
      : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

SharedPreferences prefs;

/// get bookmarkPage from sharedPreferences
getBookmark() async {
  prefs = await SharedPreferences.getInstance();

  if (globals.indexBookMarked == null) {
    print("globals.titleBookMarked== null ????????????????????????????");
    globals.titleBookMarked = [];
    globals.indexBookMarked = [];
    globals.indexFaslBookMarked = [];
    globals.codeBookMarked = [];
  } else {
    if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code)) {
      final titleBookMarked =
          prefs.getStringList(globals.BOOKMARKED_PAGE_title);

      final savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index);
      List<int> indexBookMarked =
          savedStrList.map((i) => int.parse(i)).toList();

      final savedStrFaslList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
      List<int> indexFaslBookMarked =
          savedStrFaslList.map((i) => int.parse(i)).toList();

      List<String> savedStrCodeList =
          prefs.getStringList(globals.BOOKMARKED_PAGE_Code);
      List<int> codeBookMarked =
          savedStrCodeList.map((i) => int.parse(i)).toList();

      globals.titleBookMarked = titleBookMarked;
      globals.indexBookMarked = indexBookMarked;
      globals.indexFaslBookMarked = indexFaslBookMarked;
      globals.codeBookMarked = codeBookMarked;
    }
  }
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getBookmark();
      widget.titlebookmark = globals.titleBookMarked;
      widget.indexbookmark = globals.indexBookMarked;
      widget.indexFaslbookmark = globals.indexFaslBookMarked;
      widget.codebookmark = globals.codeBookMarked;
    });

//    Favorites();
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    return Scaffold(
//        appBar: AppBar(
//          leading: IconButton(
//            icon: Icon(
//              Icons.keyboard_backspace,
//            ),
//            onPressed: () => Navigator.pop(context),
//
////            onPressed: () => Navigator.push(
////                context,
////                MaterialPageRoute(
////                    builder: (context) =>
////                        Home())), //Navigator.of(context).pop(),
//          ),
//          title: Center(
//            child: Text(
//              "فهرست منتخب",
//              textAlign: TextAlign.center,
//              style: AppStyle.titleup,
//            ),
//          ),
//          elevation: 0.0,
////          actions: <Widget>[
//////            IconButton(
//////              icon: Icon(Icons.search),
//////              onPressed: () {
//////                showSearch(context: context, delegate: NotesSearch());
//////              },
//////            ),
////          ],
//        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),

//            onPressed: () => Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) =>
//                        Home())), //Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "فهرست منتخب",
              style: AppStyle.titleup,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
//            Directionality(
//              textDirection: TextDirection.rtl,
//            ),
            // IconButton(
            //   icon: Icon(Icons.more_vert),
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Settings()));
            //   },
            // )

            // IconButton(
            //   icon: Icon(Icons.search),
            //   onPressed: () {
            //     showSearch(context: context, delegate: NotesSearch());
            //   },
            // ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ListView(

                // child: new ListView.builder(
                // itemBuilder: (BuildContext context, int index) {

                //   physics: ScrollPhysics(),
                // shrinkWrap: true,
                // children:[
                //       Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 8.0),
                //           child: Column(children: [
                //             Container(
                //               child:
                // return   widget.titlebookmark[index]!= null ?

                // new Card(
                //     elevation: 0.0,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //         side: BorderSide(width: 0.5, color: Colors.green)),
                //     child: Container(
                //         padding: EdgeInsets.all(1),
                //         child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,

                children: new List.generate(
                    // widget.numCard,
                    widget.titlebookmark.length,
                    (index) => Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(width: 0.5, color: Colors.green)),
                        child: Container(
                            padding: EdgeInsets.all(1),
                            // child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            child: new ListTile(
                                // children: <Widget>[
                                // ListTile(
                                title: Center(
                                  child: Text(
                                    widget.titlebookmark[index],
                                    style: AppStyle.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16),
//                            dense: true,

                                onTap: () {
                                  if (widget.indexFaslbookmark[index] != 4) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailSec(
                                                  detail: widget
                                                      .titlebookmark[index],
                                                  index: widget
                                                      .indexbookmark[index],
                                                  // 1,
                                                  indexFasl: widget
                                                      .indexFaslbookmark[index],
                                                  code: widget
                                                      .codebookmark[index],
                                                ))).then((value) {
                                      setState(() {
                                        widget.titlebookmark =
                                            globals.titleBookMarked;
                                        widget.indexbookmark =
                                            globals.indexBookMarked;
                                        widget.indexFaslbookmark =
                                            globals.indexFaslBookMarked;
                                        widget.codebookmark =
                                            globals.codeBookMarked;
                                      });
                                    });
                                    ;
                                  } else if (widget.indexFaslbookmark[index] ==
                                          4 &&
                                      !ui.terjemahan) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailSec4(
                                                  detail: widget
                                                      .titlebookmark[index],
                                                  index: widget
                                                      .indexbookmark[index],
                                                  // 1,
                                                  indexFasl: widget
                                                      .indexFaslbookmark[index],
                                                  code: widget
                                                      .codebookmark[index],
                                                ))).then((value) {
                                      setState(() {
                                        widget.titlebookmark =
                                            globals.titleBookMarked;
                                        widget.indexbookmark =
                                            globals.indexBookMarked;
                                        widget.indexFaslbookmark =
                                            globals.indexFaslBookMarked;
                                        widget.codebookmark =
                                            globals.codeBookMarked;
                                      });
                                    });
                                  } else if (widget.indexFaslbookmark[index] ==
                                          4 &&
                                      ui.terjemahan) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailSec4(
                                                  detail: widget
                                                      .titlebookmark[index],
                                                  index: widget
                                                      .indexbookmark[index],
                                                  // 1,
                                                  indexFasl: widget
                                                      .indexFaslbookmark[index],
                                                  code: widget
                                                      .codebookmark[index],
                                                ))).then((value) {
                                      setState(() {
                                        widget.titlebookmark =
                                            globals.titleBookMarked;
                                        widget.indexbookmark =
                                            globals.indexBookMarked;
                                        widget.indexFaslbookmark =
                                            globals.indexFaslBookMarked;
                                        widget.codebookmark =
                                            globals.codeBookMarked;
                                      });
                                    });
                                    ;
                                  }
                                })))))));
  }
}
