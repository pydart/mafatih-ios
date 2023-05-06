import 'package:admob_flutter/admob_flutter.dart';
import 'package:mafatih/data/models/FaslSecInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../detailSec.dart';
import '../detailSec4.dart';
import '../detailSec5.dart';
import '../notesSearch.dart';

class ListSec extends StatefulWidget {
  final detail, indexFasl;
  ListSec({Key key, @required this.detail, this.indexFasl}) : super(key: key);

  @override
  _ListSecState createState() => _ListSecState();
}

class _ListSecState extends State<ListSec> {
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            widget.detail,
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
      body: FutureBuilder<List<FaslSecInfo>>(
        future: ServiceData().loadFaslSecInfo(widget.indexFasl),
        builder: (c, snapshot) {
          return snapshot.hasData
              ? Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
//                        itemExtent: 60,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data.map((data) {
                          return data.indent == "1"
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(children: [
                                    Container(
                                      child: Card(
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              side: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.green)),
                                          child: Container(
//                                              margin:
//                                                  const EdgeInsets.symmetric(
//                                                      vertical: 1),
                                              padding: EdgeInsets.all(1),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    ListTile(
                                                        title: Center(
                                                          child: Text(
                                                            data.title,
                                                            style:
                                                                AppStyle.title,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        0.0,
                                                                    horizontal:
                                                                        16),
                                                        dense: true,
                                                        onTap: () {
                                                          if (widget
                                                              .indexFasl ==
                                                          7 ) {
                                                            print("//////////////////********************************************************////////////////////////////////widget.indexFasl     ${widget.indexFasl}");

                                                            Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                          builder:
                                                          (context) =>
                                                          ListSec(
                                                          detail:
                                                          data.title,
                                                          indexFasl:
                                                          data.index)
                                                          ));
                                                          }
                                                          else if (widget
                                                                  .indexFasl !=
                                                              4) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DetailSec(
                                                                              detail: data.title,
                                                                              index: data.index,
                                                                              indent: data.indent,
                                                                              indexFasl: widget.indexFasl,
                                                                              code: widget.indexFasl * 1000 + data.index,
                                                                            )));
                                                          } else if (widget
                                                                      .indexFasl ==
                                                                  4 &&
                                                              !ui.terjemahan) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DetailSec4(
                                                                              detail: data.title,
                                                                              index: data.index,
                                                                              indent: data.indent,
                                                                              indexFasl: 5,
                                                                              code: widget.indexFasl * 1000 + data.index,
                                                                            )));
                                                          } else if (widget
                                                                      .indexFasl ==
                                                                  4 &&
                                                              ui.terjemahan) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DetailSec4(
                                                                              detail: data.title,
                                                                              index: data.index,
                                                                              indent: data.indent,
                                                                              indexFasl: widget.indexFasl,
                                                                              code: widget.indexFasl * 1000 + data.index,
                                                                            )));
                                                          }

                                                        })
                                                  ]))),
                                    )
                                  ]))
                              : data.indent == "titr"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: Column(children: [
                                        Card(
                                            elevation: 0.0,
                                            color: Colors.transparent,
                                            child: Container(
                                                padding: EdgeInsets.all(1.0),
//                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                          leading:
                                                              Image.asset(
                                                            "assets/GolCard.png",
                                                            color: Colors.green,
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          title: Text(
                                                            data.title,
                                                            style: AppStyle
                                                                .titleFasl,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          trailing:
                                                              Image.asset(
                                                            "assets/GolCard.png",
                                                            color: Colors.green,
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          // ]),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          16),
                                                          dense: true,
                                                          onTap: () {

                                                          })
                                                    ])))
                                      ]))
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0));

                        }).toList()),
                  ),
                )

              : Container();
        },
      ),
      // bottomNavigationBar: AdmobBanner(
      //   adUnitId: 'ca-app-pub-5524959616213219/7557264464',
      //   adSize: AdmobBannerSize.LARGE_BANNER,
      //   // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //   //   if (event == AdmobAdEvent.clicked) {}
      //   // },
      // ),
    );
  }
}
