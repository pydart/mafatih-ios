import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import '../detailSec.dart';
import '../home2.dart';
import 'package:mafatih/ui/notesSearch.dart';
import 'file:///G:/Flutter/Qurani2 -Babs/lib/library/Globals.dart' as globals;

class Favorites extends StatefulWidget {
  List<String> titlebookmark;
  List<int> indexbookmark;
  List<int> indexFaslbookmark;
  Favorites(
      {Key key,
      @required this.titlebookmark,
      this.indexbookmark,
      this.indexFaslbookmark})
      : super(key: key);
//  int numCard=widget.titlebookmark.length();

  @override
  _FavoritesState createState() => _FavoritesState();
}

@override
void initState() {}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
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
                            dense: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSec(
                                      detail: widget.titlebookmark[index],
                                      index: widget.indexbookmark[index],
                                      // 1,
                                      indexFasl:
                                          widget.indexFaslbookmark[index],
                                    ),
                                  ));
                            },
                          ),
                        ))))));
  }
}
