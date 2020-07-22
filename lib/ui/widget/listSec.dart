import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/models/FaslSecInfo.dart';
import 'package:mafatih/data/services.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import '../detailSec.dart';
import '../home2.dart';
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

//            onPressed: () => Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) =>
//                        Home())), //Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              widget.detail,
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      ListTile(
                                                          title: Center(
                                                            child: Text(
                                                              data.title,
                                                              style: AppStyle
                                                                  .title,
                                                              textAlign:
                                                                  TextAlign
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
                                                          })
                                                    ]))),
                                      )
                                    ]))
//                              : data.indent == "2"
//                                  ? Padding(
//                                      padding: const EdgeInsets.symmetric(
//                                          horizontal: 15.0),
//                                      child: Column(children: [
//                                        Card(
//                                            elevation: 0.0,
//                                            shape: RoundedRectangleBorder(
//                                                borderRadius:
//                                                    BorderRadius.circular(5),
//                                                side: BorderSide(
//                                                    width: 0.5,
//                                                    color: Colors.green)),
//                                            child: Container(
//                                                padding: EdgeInsets.all(1.0),
////                                            padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                                child: Column(
//                                                    crossAxisAlignment:
//                                                        CrossAxisAlignment
//                                                            .center,
//                                                    children: <Widget>[
//                                                      ListTile(
//                                                          title: Center(
//                                                            child: Text(
//                                                              data.title,
//                                                              style: AppStyle
//                                                                  .title,
//                                                              textAlign:
//                                                                  TextAlign
//                                                                      .center,
//                                                            ),
//                                                          ),
//                                                          contentPadding:
//                                                              EdgeInsets
//                                                                  .symmetric(
//                                                                      vertical:
//                                                                          0.0,
//                                                                      horizontal:
//                                                                          16),
//                                                          dense: true,
//                                                          onTap: () {
//                                                            Navigator.push(
//                                                                context,
//                                                                MaterialPageRoute(
//                                                                    builder:
//                                                                        (context) =>
//                                                                            DetailSec(
//                                                                              detail: data.title,
//                                                                              index: data.index,
//                                                                              indexFasl: widget.indexFasl,
//                                                                            )));
//                                                          })
//                                                    ])))
//                                      ]))
//                                  : data.indent == "3"
//                                      ? Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              horizontal: 15.0),
//                                          child: Column(children: [
//                                            Card(
//                                                elevation: 0.0,
//                                                shape: RoundedRectangleBorder(
//                                                    borderRadius:
//                                                        BorderRadius.circular(
//                                                            5),
//                                                    side: BorderSide(
//                                                        width: 0.5,
//                                                        color: Colors.green)),
//                                                child: Container(
//                                                    padding:
//                                                        EdgeInsets.all(1.0),
//                                                    child: Column(
//                                                        crossAxisAlignment:
//                                                            CrossAxisAlignment
//                                                                .center,
//                                                        children: <Widget>[
//                                                          ListTile(
//                                                              title: Center(
//                                                                child: Text(
//                                                                  data.title,
//                                                                  style: AppStyle
//                                                                      .title,
//                                                                  textAlign:
//                                                                      TextAlign
//                                                                          .center,
//                                                                ),
//                                                              ),
//                                                              contentPadding:
//                                                                  EdgeInsets.symmetric(
//                                                                      vertical:
//                                                                          0.0,
//                                                                      horizontal:
//                                                                          16),
//                                                              dense: true,
//                                                              onTap: () {
//                                                                Navigator.push(
//                                                                    context,
//                                                                    MaterialPageRoute(
//                                                                        builder: (context) =>
//                                                                            DetailSec(
//                                                                              detail: data.title,
//                                                                              index: data.index,
//                                                                              indexFasl: widget.indexFasl,
//                                                                            )));
//                                                              })
//                                                        ])))
//                                          ]))
//                                      : data.indent == "4"
//                                          ? Padding(
//                                              padding:
//                                                  const EdgeInsets.symmetric(
//                                                      horizontal: 15.0),
//                                              child: Column(children: [
//                                                Card(
//                                                    elevation: 0.0,
//                                                    shape:
//                                                        RoundedRectangleBorder(
//                                                            borderRadius:
//                                                                BorderRadius
//                                                                    .circular(
//                                                                        5),
//                                                            side: BorderSide(
//                                                                width: 1,
//                                                                color: Colors
//                                                                    .green)),
////                                                    color: Colors.white,
//                                                    child: Container(
//                                                        padding:
//                                                            EdgeInsets.all(1.0),
////                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                                        child: Column(
//                                                            crossAxisAlignment:
//                                                                CrossAxisAlignment
//                                                                    .center,
//                                                            children: <Widget>[
//                                                              ListTile(
//                                                                  title: Center(
//                                                                    child: Text(
//                                                                      data.title,
//                                                                      style: AppStyle
//                                                                          .title,
//                                                                      textAlign:
//                                                                          TextAlign
//                                                                              .center,
//                                                                    ),
//                                                                  ),
//                                                                  contentPadding: EdgeInsets.symmetric(
//                                                                      vertical:
//                                                                          0.0,
//                                                                      horizontal:
//                                                                          16),
//                                                                  dense: true,
//                                                                  onTap: () {
//                                                                    Navigator.push(
//                                                                        context,
//                                                                        MaterialPageRoute(
//                                                                            builder: (context) => DetailSec(
//                                                                                  detail: data.title,
//                                                                                  index: data.index,
//                                                                                  indexFasl: widget.indexFasl,
//                                                                                )));
//                                                                  })
//                                                            ])))
//                                              ]))
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
                                                                // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                SvgPicture
                                                                    .asset(
                                                              'assets/GolCard.svg',
                                                              color:
                                                                  Colors.green,
                                                              height: 50,
                                                              width: 50,
//                                                                        fit: BoxFit
//                                                                            .contain,
                                                            ),
                                                            title: Text(
                                                              data.title,
                                                              style: AppStyle
                                                                  .titleFasl,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            trailing: SvgPicture
                                                                .asset(
                                                              'assets/GolCard.svg',
                                                              color:
                                                                  Colors.green,
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
//                                                                        Navigator.push(
//                                                                            context,
//                                                                            MaterialPageRoute(
//                                                                                builder: (context) => DetailSec(
//                                                                                      detail: data.title,
//                                                                                      index: data.index,
//                                                                                      indexFasl: widget.indexFasl,
//                                                                                    )));
                                                            })
                                                      ])))
                                        ]))
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0));

//                                  : Padding(
//                                      padding: const EdgeInsets.symmetric(
//                                          horizontal: 8.0),
//                                      child: Column(children: [
//                                        Card(
//                                            elevation: 0.0,
//                                            color: Colors.green,
//                                            child: Container(
//                                                padding: EdgeInsets.all(1.0),
////                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                                child: Column(
//                                                    crossAxisAlignment:
//                                                        CrossAxisAlignment
//                                                            .center,
//                                                    children: <Widget>[
//                                                      ListTile(
//                                                          title: Center(
//                                                            child: Text(
//                                                              data.title,
//                                                              style: AppStyle
//                                                                  .title,
//                                                            ),
//                                                          ),
//                                                          onTap: () {
//                                                            data.indent !=
//                                                                    "titr"
//                                                                ? Navigator.push(
//                                                                    context,
//                                                                    MaterialPageRoute(
//                                                                        builder: (context) => DetailSec(
//                                                                              detail: data.title,
//                                                                              index: data.index,
//                                                                              indexFasl: widget.indexFasl,
//                                                                            )))
//                                                                : (print("titr"));
//                                                          })
//                                                    ])))
//                                      ]));
                          }).toList()),
                    ),
                  )
//                : PKCardListSkeleton(
//                    isCircularImage: true,
//                    isBottomLinesActive: true,
//                    length: 10,
//                  );
                : Container();
          },
        ));
  }
}
