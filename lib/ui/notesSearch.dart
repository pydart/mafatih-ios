import 'package:mafatih/data/models/MixedTextInfoAll.dart';
import 'package:mafatih/data/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafatih/data/utils/style.dart';

import 'package:mafatih/ui/detailSec.dart';

class NotesSearch extends SearchDelegate<MixedTextInfoAll> {
  List<MixedTextInfoAll> notes;
  List<MixedTextInfoAll> filteredNotes = [];

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
                child: SvgPicture.asset("assets/zarebin.svg"),
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
      filteredNotes = [];

      getFilteredList(notes);
//            }
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
                  child: SvgPicture.asset("assets/notfound.svg"),
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
          child: ListView.builder(
            itemCount: filteredNotes.length == null ? 0 : filteredNotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.note,
                  // color: Colors.black,
                ),
                title: Text(
                  filteredNotes[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    // color: Colors.black,
                  ),
                ),

                // subtitle: Text(
                //   filteredNotes[index].arabic,
                //   style: TextStyle(fontSize: 14.0, color: Colors.grey),
                // ),
                onTap: () {
                  close(context, filteredNotes[index]);
                },
              );
            },
          ),
        );
      }
//          });
    }
  }

  List<MixedTextInfoAll> getFilteredList(List<MixedTextInfoAll> note) {
    filteredNotes = [];
    List<MixedTextInfoAll> _filteredNotesTitle = [];
    List<MixedTextInfoAll> _filteredNotesArabic = [];

    for (int i = 0; i < note.length; i++) {
      if (note[i].title.contains(query)) //
      {
        _filteredNotesTitle.add(note[i]);
      }

      if (note[i].arabic.contains(query) && !note[i].title.contains(query)) //
      {
        _filteredNotesArabic.add(note[i]);
      }
    }
//    filteredNotes.addAll(_filteredNotesTitle);
//    filteredNotes.addAll(_filteredNotesArabic);
    filteredNotes = _filteredNotesTitle + _filteredNotesArabic;
    return filteredNotes;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
                child: SvgPicture.asset("assets/zarebin.svg"),
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
      );
    } else {
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
                child: ListView.builder(
                  itemCount:
                      filteredNotes.length == null ? 0 : filteredNotes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(0.0),
                      child: ListTile(
                        title: RichText(
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
                ),
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
