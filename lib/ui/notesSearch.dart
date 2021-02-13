import 'package:mafatih/data/models/MixedTextInfoAll.dart';
import 'package:mafatih/data/services.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/ui/detailSec4.dart';
import 'package:mafatih/ui/detailSec.dart';
import 'package:mafatih/ui/detailSec5.dart';

import 'loading.dart';

class NotesSearch extends SearchDelegate<MixedTextInfoAll> {
  List<MixedTextInfoAll> notes;
  List<MixedTextInfoAll> filteredNotes = [];
  bool titleSearchActive = true;
  bool textSearchActive = false;
  List<int> selectedDoa = [
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
  ];

  bool loading = false;

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        // hintColor: Colors.black,
        // primaryColor: Colors.white,
        textTheme: TextTheme(
      title: TextStyle(
        // color: Colors.black,
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
      IconButton(
        icon: Icon(
          Icons.clear,
          // color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        // color: Colors.black,
      ),

      onPressed: () => Navigator.pop(context),

//      onPressed: () {
//        close(context, null);
//      },
//      onPressed: () => Navigator.popAndPushNamed(context, '/home'),
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
//                child: SvgPicture.asset("assets/zarebin.svg"),
                child: Image.asset("assets/zarebin.png"),
//                color: Colors.grey,
//                height: 25,
//                width: 25,
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
            )
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
                // color: Colors.white,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
//                width: 50,
//                height: 50,
//                child: Icon(
//                  Icons.sentiment_dissatisfied,
//                  size: 50,
//                  // color: Colors.black,
//                ),
                      width: 100,
                      height: 100,
                      child: Container(
//                        child: SvgPicture.asset("assets/notfound.svg"),
                        child: Image.asset("assets/notfound.png"),
//                color: Colors.grey,
//                height: 25,
//                width: 25,
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
                    )
                  ],
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
                                      color: Colors.grey,
                                    )
                                  : Container(),
                              RichText(
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
                            ],
                          ),
                          subtitle: RichText(
                            maxLines: 2,
                            text: TextSpan(
                              children: highlightOccurrences(
                                  filteredNotes[index].arabic, ""),
                              style: TextStyle(
                                fontFamily: 'IRANSans',
                                fontSize: 12,
//                              color: Theme.of(context)
//                                  .accentColor, // color: Colors.grey,
                                color: Colors.grey[600], // color: Colors.grey,
//
//                                  color: Colors.grey,
                              ),
                            ),
                          ),
//                        //[1009,1010,1011,1014,1017,1028, 1029,1030,1031,1032,1033,1034,1110,1119,1122,1124,1132,3153,3222,3224,3216,]
//                        leading: filteredNotes[index].index == 3
//                            ? Icon(Icons.star)
//                            : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSec(
                                    detail: filteredNotes[index].titleDetail,
                                    index: filteredNotes[index].indexbab,
                                    indexFasl: filteredNotes[index].bab,
                                    query: query,
                                    code: filteredNotes[index].bab * 1000 +
                                        filteredNotes[index].indexbab),
                              ),
                            );
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

  List<MixedTextInfoAll> getFilteredList(List<MixedTextInfoAll> note) {
    loading = true;
    filteredNotes = [];
    List<MixedTextInfoAll> _filteredNotesTitle = [];
    List<MixedTextInfoAll> _filteredNotesArabic = [];

    for (int i = 0; i < note.length; i++) {
      if (titleSearchActive && note[i].title.contains(query)) //
      {
        print(
            "///////////////////////////////mmmmmmmmmmmmmmmmmmmmmmmmmmm     _filteredNotesTitle.add(note[i])");
        _filteredNotesTitle.add(note[i]);
      }

      if (textSearchActive &&
          note[i].arabic.contains(query) &&
          !note[i].title.contains(query)) //
      {
        _filteredNotesArabic.add(note[i]);
      }
    }
//    filteredNotes.addAll(_filteredNotesTitle);
//    filteredNotes.addAll(_filteredNotesArabic);
    filteredNotes = _filteredNotesTitle + _filteredNotesArabic;
    loading = false;
    return filteredNotes;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var ui = Provider.of<UiState>(context);

    if (query == '') {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
//        return CheckboxListTile(
//          title: const Text('Item'),
//          value: titleSearchActive,
//          onChanged: (bool newValue) {
//            setState(() {
//              titleSearchActive = newValue;
//            });
//          },
//        );
//      });
        return Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
//                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("فهرست",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IRANSans',
                          fontSize: 18,
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
                  width: 100,
                  height: 100,
                  child: Container(
//                    child: SvgPicture.asset("assets/zarebin.svg"),
                    child: Image.asset("assets/zarebin.png"),
//                color: Colors.grey,
//                height: 25,
//                width: 25,
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
                )
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
                                      color: Colors.grey,
                                    )
                                  : Container(),
                              RichText(
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
                            ],
                          ),
                          subtitle: RichText(
                            maxLines: 2,
                            text: TextSpan(
                              children: highlightOccurrences(
                                  filteredNotes[index].arabic, ""),
                              style: TextStyle(
                                fontFamily: 'IRANSans',
                                fontSize: 12,
//                              color: Theme.of(context)
//                                  .accentColor, // color: Colors.grey,
                                color: Colors.grey[600], // color: Colors.grey,
//
//                                  color: Colors.grey,
                              ),
                            ),
                          ),
//                        //[1009,1010,1011,1014,1017,1028, 1029,1030,1031,1032,1033,1034,1110,1119,1122,1124,1132,3153,3222,3224,3216,]
//                        leading: filteredNotes[index].index == 3
//                            ? Icon(Icons.star)
//                            : null,
                          onTap: () {
/*                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailSec(
                                    detail: filteredNotes[index].titleDetail,
                                    index: filteredNotes[index].indexbab,
                                    indexFasl: filteredNotes[index].bab,
                                    query: query,
                                    code: filteredNotes[index].bab * 1000 +
                                        filteredNotes[index].indexbab),
                              ),
                            );*/

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
                                      builder: (context) => DetailSec5(
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
//          style: TextStyle(
//              fontFamily: 'IRANSans', fontSize: 20, color: Colors.grey[900])
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green
          // color: Colors.black,
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
