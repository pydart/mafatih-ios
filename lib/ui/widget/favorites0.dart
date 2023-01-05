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

import '../settings.dart';

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

/// set bookmarkPage in sharedPreferences
void setBookmark(List<String> _title, List<int> _index, List<int> _indexFasl,
    List<int> _code) async {
  prefs = await SharedPreferences.getInstance();
//    if (_index[0] != null && !_index[0].isNaN) {
  await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);

  List<String> _strindex = _index.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);

  List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);

  List<String> _strcode = _code.map((i) => i.toString()).toList();
  await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    getBookmark();
    widget.titlebookmark = globals.titleBookMarked;
    widget.indexbookmark = globals.indexBookMarked;
    widget.indexFaslbookmark = globals.indexFaslBookMarked;
    widget.codebookmark = globals.codeBookMarked;

//    Favorites();
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "فهرست منتخب",
            style: AppStyle.titleup,
          ),
          elevation: 0.0,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.search),
            //   onPressed: () {
            //     showSearch(context: context, delegate: NotesSearch());
            //   },
            // ),

            IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  setState(() {
                    globals.titleBookMarked = [];
                    globals.indexBookMarked = [];
                    globals.indexFaslBookMarked = [];
                    globals.codeBookMarked = [];
                    widget.titlebookmark = globals.titleBookMarked;
                    widget.indexbookmark = globals.indexBookMarked;
                    widget.indexFaslbookmark = globals.indexFaslBookMarked;
                    widget.codebookmark = globals.codeBookMarked;
                  });
                  setBookmark(globals.titleBookMarked, globals.indexBookMarked,
                      globals.indexFaslBookMarked, globals.codeBookMarked);
                }),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ListView(

                // Text(
                //   "پاک کردن همه",
                //   style: AppStyle.titleup,
                // ),
                // IconButton(
                //   icon: Icon(Icons.clear_all),
                //   onPressed: () {
                //     setState(() {
                //       globals.titleBookMarked = [];
                //       globals.indexBookMarked = [];
                //       globals.indexFaslBookMarked = [];
                //       globals.codeBookMarked = [];
                //     });
                //     setBookmark(globals.titleBookMarked, globals.indexBookMarked,
                //         globals.indexFaslBookMarked, globals.codeBookMarked);
                //   },
                // ),

                children: new List.generate(
                    // widget.numCard,
                    widget.codebookmark.length,
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
                                                          .codebookmark[index] %
                                                      1000,
                                                  // 1,
                                                  indexFasl:
                                                      widget.codebookmark[
                                                              index] ~/
                                                          1000,
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
