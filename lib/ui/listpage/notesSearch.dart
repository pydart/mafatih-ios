import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mafatih/data/models/MixedTextInfoAll.dart';
import 'package:mafatih/data/services.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/ui/listpage/detailSec.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:week_of_year/date_week_extensions.dart';
import '../../utils/constants.dart';
import 'detailSec4.dart';

class NotesSearch extends SearchDelegate<MixedTextInfoAll> {
  @override
  String get searchFieldLabel => "جستجو";

  @override
  TextStyle get searchFieldStyle => TextStyle(
    // decorationColor: Colors.white,
    // backgroundColor: Colors.white,
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        // decoration: TextDecoration.none,
      );

  List<MixedTextInfoAll> notes;
  List<MixedTextInfoAll> filteredNotes = [];
  List<MixedTextInfoAll> filteredNotesTitle = [];
  List<MixedTextInfoAll> filteredNotesArabic = [];

  bool titleSearchActive = true;
  bool textSearchActive = true;
  List<int> selectedDoa = [
    3082,
    2229,
    1110,
    1119,
    1122,
    1124,
    1132,
    3055,
    3153,
    3222,
    3224,
    3216,
    2010,
    2081,
    2090,
    2089,
    2071,
    2072,
    2070,
    1115,
    1117,
    1118,
    6010,
    7056,
    7057,
    3028,
  ];

  bool loading = false;

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    // TextField(cursorColor: Colors.white);
    final ThemeData theme = Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white54,
          selectionColor: Colors.white54,
          selectionHandleColor: Colors.white54,
        ),
        hintColor: Colors.white54,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 20,
          ),
        ));
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query != ''
          ? IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).splashColor,
              ),
              onPressed: () {
                query = '';
              },
            )
          : Container()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).splashColor,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return Container(
        // color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Container(
                child: Image.asset("assets/zarebin.png"),
              ),
            ),
            Text(
              'جستجو در برنامه',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'IRANSans',
              ),
            ),
            AdmobBanner(
              adUnitId: 'ca-app-pub-5524959616213219/3098984556',
              adSize: AdmobBannerSize.FULL_BANNER,
              // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //   if (event == AdmobAdEvent.clicked) {}
              // },
            ),
          ],
        )),
      );
    } else {
      loading = true;

      filteredNotes = [];
      return FutureBuilder<List<MixedTextInfoAll>>(
          future: ServiceData().loadMixedTextInfoAll(),
          builder: (c, snapshot) {
            if (snapshot.hasData) {
              getFilteredList(notes = snapshot.data);
            }
            if (filteredNotes.length == 0) {
              return Container(
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        child: Image.asset("assets/notfound.png"),
                      ),
                    ),
                    Text(
                      'هیچ نتیجه ای یافت نشد!',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'IRANSans',
                      ),
                    ),
                    AdmobBanner(
                      adUnitId: 'ca-app-pub-5524959616213219/3098984556',
                      adSize: AdmobBannerSize.FULL_BANNER,
                      // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                      //   if (event == AdmobAdEvent.clicked) {}
                      // },
                    ),
                    InkWell(
                      onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch1"]);
                      final date = DateTime.now();
                      print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
                      child: CachedNetworkImage(
                        imageUrl: Constants.urlgifsearch1,
                        cacheKey: Constants.urlgifsearch1 + DateTime.now().weekOfYear.toString(),
                        errorWidget: (context, url, error) => SizedBox.shrink(),
                      ),
                    ),
                  ],
                )),
              );
            } else {
              return Container(
                // color: Colors.white,

                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  setState(() => loading = false);

                  return Column(
                    children: [
                      ListView.builder(
                        itemCount: filteredNotes.length == null
                            ? 0
                            : filteredNotesTitle.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                textSearchActive
                                    ? ListTile(
                                        title: Row(
                                          children: <Widget>[
                                            selectedDoa.contains(1000 *
                                                        filteredNotesTitle[
                                                                index]
                                                            .bab +
                                                    filteredNotesTitle[index]
                                                        .indexbab)
                                                ? Icon(
                                                    Icons.star,
                                                    color: Colors.green,
                                                  )
                                                : Container(),
                                            RichText(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                children: highlightOccurrences(
                                                    filteredNotesTitle[index]
                                                        .title,
                                                    query),
                                                style: TextStyle(
                                                  fontFamily: 'IRANSans',
                                                  fontSize: 17,
                                                  color: Theme.of(context)
                                                      .accentColor, // color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            children: highlightOccurrences(
                                                filteredNotesTitle[index]
                                                    .arabic,
                                                ""),
                                            style: TextStyle(
                                              fontFamily: 'IRANSans',
                                              fontSize: 12,
//                              color: Theme.of(context)
//                                  .accentColor, // color: Colors.grey,
                                              color: Colors.grey[
                                                  600], // color: Colors.grey,
//
                                            ),
                                          ),
                                        ),

                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailSec(
                                                  detail:
                                                      filteredNotesTitle[index]
                                                          .titleDetail,
                                                  index:
                                                      filteredNotesTitle[index]
                                                          .indexbab,
                                                  indexFasl:
                                                      filteredNotesTitle[index]
                                                          .bab,
                                                  query: query,
                                                  code: filteredNotesTitle[
                                                                  index]
                                                              .bab *
                                                          1000 +
                                                      filteredNotesTitle[index]
                                                          .indexbab),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(),
                                // InkWell(
                                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch1"]);
                                //   final date = DateTime.now();
                                //   print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
                                //   child: CachedNetworkImage(
                                //     imageUrl: Constants.urlgifsearch1,
                                //     cacheKey: Constants.urlgifsearch1 + DateTime.now().weekOfYear.toString(),
                                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                                //   ),
                                // ),
                                // SizedBox(height:5),
                                // InkWell(
                                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch2"]);},
                                //   child: CachedNetworkImage(
                                //     imageUrl: Constants.urlgifsearch2,
                                //     cacheKey: Constants.urlgifsearch2+DateTime.now().weekOfYear.toString(),
                                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                                //   ),
                                // ),
                                // SizedBox(height:5),
                                // InkWell(
                                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch3"]);},
                                //   child: CachedNetworkImage(
                                //     imageUrl: Constants.urlgifsearch3,
                                //     cacheKey: Constants.urlgifsearch3+DateTime.now().weekOfYear.toString(),
                                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                                //   ),
                                // ),
                                AdmobBanner(
                                  adUnitId:
                                      'ca-app-pub-5524959616213219/3098984556',
                                  adSize: AdmobBannerSize.FULL_BANNER,
                                  // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                                  //   if (event == AdmobAdEvent.clicked) {}
                                  // },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      textSearchActive
                          ? ListView.builder(
                              itemCount: filteredNotesArabic.length == null
                                  ? 0
                                  : filteredNotesArabic.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Row(
                                          children: <Widget>[
                                            selectedDoa.contains(1000 *
                                                        filteredNotesArabic[
                                                                index]
                                                            .bab +
                                                    filteredNotesArabic[index]
                                                        .indexbab)
                                                ? Icon(
                                                    Icons.star,
                                                    color: Colors.green,
                                                  )
                                                : Container(),
                                            Icon(Icons.text_snippet_outlined,
                                                color: Colors.grey),
                                            RichText(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                children: highlightOccurrences(
                                                    filteredNotesArabic[index]
                                                        .title,
                                                    query),
                                                style: TextStyle(
                                                  fontFamily: 'IRANSans',
                                                  fontSize: 17,
                                                  color: Theme.of(context)
                                                      .accentColor, // color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            children: highlightOccurrences(
                                                filteredNotesArabic[index]
                                                    .arabic,
                                                query),
                                            style: TextStyle(
                                              fontFamily: 'IRANSans',
                                              fontSize: 12,
                                              color: Colors.grey[
                                                  600], // color: Colors.grey,
//
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailSec(
                                                  detail:
                                                      filteredNotesArabic[index]
                                                          .titleDetail,
                                                  index:
                                                      filteredNotesArabic[index]
                                                          .indexbab,
                                                  indexFasl:
                                                      filteredNotesArabic[index]
                                                          .bab,
                                                  query: query,
                                                  code: filteredNotesArabic[
                                                                  index]
                                                              .bab *
                                                          1000 +
                                                      filteredNotesArabic[index]
                                                          .indexbab),
                                            ),
                                          );
                                        },
                                      ),
                                      AdmobBanner(
                                        adUnitId:
                                            'ca-app-pub-5524959616213219/3098984556',
                                        adSize: AdmobBannerSize.LARGE_BANNER,
                                        // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                                        //   if (event == AdmobAdEvent.clicked) {}
                                        // },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ],
                  );
                }),
              );
            }
          });
    }
  }

  List<MixedTextInfoAll> getFilteredList(List<MixedTextInfoAll> note) {
    loading = true;
    filteredNotes = [];
    filteredNotesTitle = [];
    filteredNotesArabic = [];

    for (int i = 0; i < note.length; i++) {
      if (titleSearchActive == true && note[i].title.contains(query)) //
      {
        print(
            "///////////////////////////////mmmmmmmmmmmmmmmmmmmmmmmmmmm     _filteredNotesTitle.add(note[i])  ${note[i]}");
        filteredNotesTitle.add(note[i]);

      }

      if (textSearchActive == true && note[i].arabic.contains(query)
          ) //
      {
        filteredNotesArabic.add(note[i]);
      }
    }
    filteredNotes = filteredNotesTitle + filteredNotesArabic;
    loading = false;
    return filteredNotes;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    if (query == '') {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("فهرست",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IRANSans',
                          fontSize: 18,
                          color: Colors.green,
                        )),
                    Checkbox(
                      activeColor: Colors.green,
                      value: titleSearchActive,
                      onChanged: (bool value) {
                        setState(() {
                          titleSearchActive = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
//                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("متن",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IRANSans',
                          fontSize: 18,
                          color: Colors.green,
                        )),
                    Checkbox(
                      value: textSearchActive,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        setState(() {
                          textSearchActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ]),
          Container(
            height: 1,
            color: Colors.green,
          ),
          SizedBox(height: 150),
          Container(
            // color: Colors.white,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Container(
                    child: Image.asset("assets/zarebin.png"),
                  ),
                ),
                Text(
                  "جستجو در برنامه",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'IRANSans',
                  ),
                ),
                // InkWell(
                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch1"]);
                //   final date = DateTime.now();
                //   print('timeeeeeeeeeeeeeeeeee' + date.weekOfYear.toString());},
                //   child: CachedNetworkImage(
                //     imageUrl: Constants.urlgifsearch1,
                //     cacheKey: Constants.urlgifsearch1 + DateTime.now().weekOfYear.toString(),
                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                //   ),
                // ),
                // SizedBox(height:5),
                // InkWell(
                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch2"]);},
                //   child: CachedNetworkImage(
                //     imageUrl: Constants.urlgifsearch2,
                //     cacheKey: Constants.urlgifsearch2+DateTime.now().weekOfYear.toString(),
                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                //   ),
                // ),
                // SizedBox(height:5),
                // InkWell(
                //   onTap: () {sharedfunc.launchURL(globals.jsonGifAdUrlMap["urlgifsearch3"]);},
                //   child: CachedNetworkImage(
                //     imageUrl: Constants.urlgifsearch3,
                //     cacheKey: Constants.urlgifsearch3+DateTime.now().weekOfYear.toString(),
                //     errorWidget: (context, url, error) => SizedBox.shrink(),
                //   ),
                // ),
                AdmobBanner(
                  adUnitId: 'ca-app-pub-5524959616213219/3098984556',
                  adSize: AdmobBannerSize.LARGE_BANNER,
                  // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  //   if (event == AdmobAdEvent.clicked) {}
                  // },
                ),
              ],
            )),
          ),
        ]);
      });
    } else {
      loading = true;

      filteredNotes = [];
      return FutureBuilder<List<MixedTextInfoAll>>(
          future: ServiceData().loadMixedTextInfoAll(),
          builder: (c, snapshot) {
            if (snapshot.hasData) {
              getFilteredList(notes = snapshot.data);
            }
            if (filteredNotes.length == 0) {
              return Container(
                // color: Colors.white,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                )),
              );
            } else {
              return Container(
                // color: Colors.white,

                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  setState(() => loading = false);

                  return ListView.builder(
                    itemCount:
                        filteredNotes.length == null ? 0 : filteredNotes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(0.0),
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              selectedDoa.contains(
                                      1000 * filteredNotes[index].bab +
                                          filteredNotes[index].indexbab)
                                  ? Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    )
                                  : Container(),
                              Expanded(
                                child: RichText(
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  // overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: highlightOccurrences(
                                        filteredNotes[index].title, query),
                                    style: TextStyle(
                                      fontFamily: 'IRANSans',
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .accentColor, // color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          subtitle: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: textSearchActive
                                  ? highlightOccurrences(
                                      filteredNotes[index].arabic, query)
                                  : highlightOccurrences(
                                      filteredNotes[index].arabic, ""),
                              style: TextStyle(
                                fontFamily: 'IRANSans',
                                fontSize: 12,
                                color: Colors.grey[600], // color: Colors.grey,
                              ),
                            ),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //
                            //         DetailSec(
                            //         detail: filteredNotes[index].titleDetail,
                            //         index: filteredNotes[index].indexbab,
                            //         indexFasl: filteredNotes[index].bab,
                            //         query: query,
                            //         code: filteredNotes[index].bab * 1000 +
                            //             filteredNotes[index].indexbab),
                            //   ),
                            // );

                            if (filteredNotes[index].bab != 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailSec(
                                            detail: filteredNotes[index]
                                                .titleDetail,
                                            index:
                                                filteredNotes[index].indexbab,
                                            indexFasl: filteredNotes[index].bab,
                                            query: query,
                                            code: filteredNotes[index].bab *
                                                    1000 +
                                                filteredNotes[index].indexbab,
                                          )));
                            } else if (filteredNotes[index].bab == 4 &&
                                !ui.terjemahan) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailSec4(
                                            detail: filteredNotes[index]
                                                .titleDetail,
                                            index:
                                                filteredNotes[index].indexbab,
                                            indexFasl: 5,
                                            code: filteredNotes[index].bab *
                                                    1000 +
                                                filteredNotes[index].indexbab,
                                          )));
                            } else if (filteredNotes[index].bab == 4 &&
                                ui.terjemahan) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailSec4(
                                            detail: filteredNotes[index]
                                                .titleDetail,
                                            index:
                                                filteredNotes[index].indexbab,
                                            indexFasl: filteredNotes[index].bab,
                                            code: filteredNotes[index].bab *
                                                    1000 +
                                                filteredNotes[index].indexbab,
                                          )));
                            }
                          },
                        ),
                      );
                    },
                  );
                }),
              );
            }
          });
    }
  }
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query == null ||
      query.isEmpty ||
      !source.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: source)];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }
    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green
          ),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }
    lastMatchEnd = match.end;
  }
  return children;
}
