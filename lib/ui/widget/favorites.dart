import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../detailSec.dart';
import '../home2.dart';
import 'package:mafatih/ui/notesSearch.dart';
import 'file:///G:/Flutter/Qurani2_Babs_SplitText/lib/library/Globals.dart'
    as globals;

class Favorites extends StatefulWidget {
  List<String> titlebookmark = globals.titleBookMarked;
  List<int> indexbookmark = globals.indexBookMarked;
  List<int> indexFaslbookmark = globals.indexFaslBookMarked;

  Favorites(
      {Key key,
      @required this.titlebookmark,
      this.indexbookmark,
      this.indexFaslbookmark})
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
  } else {
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
      globals.titleBookMarked = titleBookMarked;
      globals.indexBookMarked = indexBookMarked;
      globals.indexFaslBookMarked = indexFaslBookMarked;
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
    });

//    Favorites();
  }

  @override
  Widget build(BuildContext context) {
//    getBookmark(); //globals.indexBookMarked = !null ??
//    setState(() {
//      widget.titlebookmark = globals.titleBookMarked;
//      widget.indexbookmark = globals.indexBookMarked;
//      widget.indexFaslbookmark = globals.indexFaslBookMarked;
//    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home())), //Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "فهرست منتخب",
              textAlign: TextAlign.center,
              style: AppStyle.titleup,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NotesSearch());
              },
            ),
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
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => DetailSec(
                                                detail:
                                                    widget.titlebookmark[index],
                                                index:
                                                    widget.indexbookmark[index],
                                                // 1,
                                                indexFasl: widget
                                                    .indexFaslbookmark[index],
                                              ))).then((value) {
                                    setState(() {
                                      widget.titlebookmark =
                                          globals.titleBookMarked;
                                      widget.indexbookmark =
                                          globals.indexBookMarked;
                                      widget.indexFaslbookmark =
                                          globals.indexFaslBookMarked;
                                    });
                                  });
                                })))))));
  }
}
