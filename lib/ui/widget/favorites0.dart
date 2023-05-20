// import 'package:admob_flutter/admob_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mafatih/data/utils/style.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mafatih/library/Globals.dart' as globals;
// import 'package:provider/provider.dart';
// import 'package:mafatih/data/uistate.dart';
//
// import '../listpage/detailSec.dart';
//
// class Favorites extends StatefulWidget {
//   List<String> titlebookmark = globals.titleBookMarked;
//   List<int> indexbookmark = globals.indexBookMarked;
//   List<int> indexFaslbookmark = globals.indexFaslBookMarked;
//   List<int> indexKeybookmark = globals.indexKeyBookMarked;
//   List<int> codebookmark = globals.codeBookMarked;
//
//   Favorites(
//       {Key key,
//       @required this.titlebookmark,
//       this.indexbookmark,
//       this.indexFaslbookmark,
//       this.indexKeybookmark,
//       this.codebookmark})
//       : super(key: key);
//
//   @override
//   _FavoritesState createState() => _FavoritesState();
// }
//
// SharedPreferences prefs;
//
// /// get bookmarkPage from sharedPreferences
// getBookmark() async {
//   prefs = await SharedPreferences.getInstance();
//
//   if (globals.indexBookMarked == null) {
//     print("globals.titleBookMarked== null ????????????????????????????");
//     globals.titleBookMarked = [];
//     globals.indexBookMarked = [];
//     globals.indexKeyBookMarked = [];
//     globals.indexFaslBookMarked = [];
//     globals.codeBookMarked = [];
//   } else if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code) &&
//       prefs.containsKey(globals.BOOKMARKED_PAGE_keyindex)) {
//     final titleBookMarked = prefs.getStringList(globals.BOOKMARKED_PAGE_title);
//
//     final savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index);
//     List<int> indexBookMarked = savedStrList.map((i) => int.parse(i)).toList();
//
//     final savedStrKeyList =
//         prefs.getStringList(globals.BOOKMARKED_PAGE_keyindex);
//     List<int> indexKeyBookMarked =
//         savedStrKeyList.map((i) => int.parse(i)).toList();
//
//     final savedStrFaslList =
//         prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
//     List<int> indexFaslBookMarked =
//         savedStrFaslList.map((i) => int.parse(i)).toList();
//
//     List<String> savedStrCodeList =
//         prefs.getStringList(globals.BOOKMARKED_PAGE_Code);
//     List<int> codeBookMarked =
//         savedStrCodeList.map((i) => int.parse(i)).toList();
//
//     globals.titleBookMarked = titleBookMarked;
//     globals.indexBookMarked = indexBookMarked;
//     globals.indexKeyBookMarked = indexKeyBookMarked;
//     globals.indexFaslBookMarked = indexFaslBookMarked;
//     globals.codeBookMarked = codeBookMarked;
//   } else if (prefs.containsKey(globals.BOOKMARKED_PAGE_Code) &&
//       !prefs.containsKey(globals.BOOKMARKED_PAGE_keyindex)) {
//     final titleBookMarked = prefs.getStringList(globals.BOOKMARKED_PAGE_title);
//
//     final savedStrList = prefs.getStringList(globals.BOOKMARKED_PAGE_index);
//     List<int> indexBookMarked = savedStrList.map((i) => int.parse(i)).toList();
//
//     final savedStrFaslList =
//         prefs.getStringList(globals.BOOKMARKED_PAGE_indexFasl);
//     List<int> indexFaslBookMarked =
//         savedStrFaslList.map((i) => int.parse(i)).toList();
//
//     List<String> savedStrCodeList =
//         prefs.getStringList(globals.BOOKMARKED_PAGE_Code);
//     List<int> codeBookMarked =
//         savedStrCodeList.map((i) => int.parse(i)).toList();
//
//     globals.titleBookMarked = titleBookMarked;
//     globals.indexBookMarked = indexBookMarked;
//     globals.indexFaslBookMarked = indexFaslBookMarked;
//     globals.codeBookMarked = codeBookMarked;
//   }
//
//   if (globals.indexBookMarked == null) {
//     List mapBookMarked = [
//       for (int i = 0; i < globals.codeBookMarked.length; i++)
//         {
//           'index': i,
//           'titleBookMarked': globals.titleBookMarked[i],
//           'indexBookMarked': globals.indexBookMarked[i],
//           'indexKeyBookMarked': globals.indexKeyBookMarked[i],
//           'indexFaslBookMarked': globals.indexFaslBookMarked[i],
//           'codeBookMarked': globals.codeBookMarked[i],
//         }
//     ];
//     globals.mapBookMarked = mapBookMarked;
//     print(
//         '-----------------------------------------------mapBookMarked----------------------------------------$mapBookMarked');
//   } else if (prefs.containsKey(globals.BOOKMARKED_MAP)) {
//     // await prefs.setmap(globals.BOOKMARKED_PAGE_title, _title);
//   }
// }
//
// /// set bookmarkPage in sharedPreferences
// void setBookmark(List<String> _title, List<int> _index, List<int> _indexkey,
//     List<int> _indexFasl, List<int> _code) async {
//   prefs = await SharedPreferences.getInstance();
// //    if (_index[0] != null && !_index[0].isNaN) {
//   await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);
//
//   List<String> _strindex = _index.map((i) => i.toString()).toList();
//   await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);
//
//   List<String> _strindexkey = _indexkey.map((i) => i.toString()).toList();
//   await prefs.setStringList(globals.BOOKMARKED_PAGE_keyindex, _strindexkey);
//
//   List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
//   await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);
//
//   List<String> _strcode = _code.map((i) => i.toString()).toList();
//   await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
// }
//
// class _FavoritesState extends State<Favorites> {
//   @override
//   void initState() {
//     super.initState();
//     getBookmark();
//     widget.titlebookmark = globals.titleBookMarked;
//     widget.indexbookmark = globals.indexBookMarked;
//     widget.indexKeybookmark = globals.indexKeyBookMarked;
//     widget.indexFaslbookmark = globals.indexFaslBookMarked;
//     widget.codebookmark = globals.codeBookMarked;
//     List mapBookMarked = [
//       for (int i = 0; i < globals.codeBookMarked.length; i++)
//         {
//           'index': i,
//           'titleBookMarked': globals.titleBookMarked[i],
//           'indexBookMarked': globals.indexBookMarked[i],
//           'indexKeyBookMarked': globals.indexKeyBookMarked[i],
//           'indexFaslBookMarked': globals.indexFaslBookMarked[i],
//           'codeBookMarked': globals.codeBookMarked[i],
//         }
//     ];
//     globals.mapBookMarked = mapBookMarked;
// //    Favorites();
//   }
//
//   bool isBookmarked;
//
//   /// Navigation event handler
//   _onItemTapped(int indexTab, int _indexlocal) {
//     setState(() {
//       String _title = globals.mapBookMarked[_indexlocal]['titleBookMarked'];
//       int _index =
//           (globals.mapBookMarked[_indexlocal]['codeBookMarked'] - 1000000) ~/
//               1000;
//       int _indexKey = (((globals.mapBookMarked[_indexlocal]['codeBookMarked']) %
//                       1000) -
//                   1) <
//               0
//           ? 0
//           : (((globals.mapBookMarked[_indexlocal]['codeBookMarked']) % 1000) -
//               1);
//       int _indexFasl = 1;
//       int _code = globals.mapBookMarked[_indexlocal]['codeBookMarked'];
//       // globals.titleCurrentPage=
//       //     globals.indexCurrentPage
//       // globals.indexFaslCurrentPage
//
//       if (indexTab == 2) {
//         if (globals.codeBookMarked.contains(_code))
//           setState(() {
//             globals.titleBookMarked.remove(_title);
//             globals.indexBookMarked.remove(_index);
//             globals.indexKeyBookMarked.remove(_indexKey);
//             globals.indexFaslBookMarked.remove(_indexFasl);
//             globals.codeBookMarked.remove(_code);
//             print(
//                 "toRemove %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
//             widget.titlebookmark = globals.titleBookMarked;
//             widget.indexbookmark = globals.indexBookMarked;
//             widget.indexKeybookmark = globals.indexKeyBookMarked;
//             widget.indexFaslbookmark = globals.indexFaslBookMarked;
//             widget.codebookmark = globals.codeBookMarked;
//             List mapBookMarked = [
//               for (int i = 0; i < globals.codeBookMarked.length; i++)
//                 {
//                   'index': i,
//                   'titleBookMarked': globals.titleBookMarked[i],
//                   'indexBookMarked': globals.indexBookMarked[i],
//                   'indexKeyBookMarked': globals.indexKeyBookMarked[i],
//                   'indexFaslBookMarked': globals.indexFaslBookMarked[i],
//                   'codeBookMarked': globals.codeBookMarked[i],
//                 }
//             ];
//             globals.mapBookMarked = mapBookMarked;
//
//             setBookmark(
//                 globals.titleBookMarked,
//                 globals.indexBookMarked,
//                 globals.indexKeyBookMarked,
//                 globals.indexFaslBookMarked,
//                 globals.codeBookMarked);
//           });
//         // else
//         //   setState(() {
//         //     print(
//         //         "       <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  globals.indexKey =  ${_indexKey}");
//         //
//         //     globals.titleBookMarked.add(_title);
//         //     globals.indexBookMarked.add(_index);
//         //     globals.indexKeyBookMarked.add(_indexKey);
//         //     globals.indexFaslBookMarked.add(_indexFasl);
//         //     globals.codeBookMarked.add(_code);
//         //     isBookmarked = true;
//         //     print(
//         //         "${globals.codeBookMarked} ----------------------------------------------- globals.codeBookMarked------------------------------------------------");
//         //     print(
//         //         "toSave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: ${globals.titleBookMarked}");
//         //   });
//
//         // if (globals.indexBookMarked != null) {
//         //   setBookmark(
//         //       globals.titleBookMarked,
//         //       globals.indexBookMarked,
//         //       globals.indexKeyBookMarked,
//         //       globals.indexFaslBookMarked,
//         //       globals.codeBookMarked);
//         // }
//       } else if (indexTab == 0) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Home()));
//       } else if (indexTab == 1) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Settings()));
//       }
//     });
//   }
//
//   /// set bookmarkPage in sharedPreferences
//   void setBookmark(List<String> _title, List<int> _index, List<int> _indexkey,
//       List<int> _indexFasl, List<int> _code) async {
//     prefs = await SharedPreferences.getInstance();
// //    if (_index[0] != null && !_index[0].isNaN) {
//     await prefs.setStringList(globals.BOOKMARKED_PAGE_title, _title);
//
//     List<String> _strindex = _index.map((i) => i.toString()).toList();
//     await prefs.setStringList(globals.BOOKMARKED_PAGE_index, _strindex);
//
//     List<String> _strindexkey = _indexkey.map((i) => i.toString()).toList();
//     await prefs.setStringList(globals.BOOKMARKED_PAGE_keyindex, _strindexkey);
//
//     List<String> _strindexFasl = _indexFasl.map((i) => i.toString()).toList();
//     await prefs.setStringList(globals.BOOKMARKED_PAGE_indexFasl, _strindexFasl);
//
//     List<String> _strcode = _code.map((i) => i.toString()).toList();
//     await prefs.setStringList(globals.BOOKMARKED_PAGE_Code, _strcode);
//   }
//
//   Future<bool> _onDeletePressed(_index) {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text("آیا قصد پاک کردن منتخب را دارید؟"),
//               actions: <Widget>[
//                 ElevatedButton(
//                   child: Text("بله"),
//                   onPressed: () {
//                     String smsSaved = "با موفقیت به منتخب ها افزوده شد";
//                     String smsRemoved = "با موفقیت از منتخب ها حذف شد";
//                     Fluttertoast.showToast(
//                         msg:
//                             // (globals.codeBookMarked
//                             //             .contains(globals
//                             //                         .mapBookMarked[
//                             //                     index][
//                             //                 'codeBookMarked'])) ==
//                             //         true ??
//                             smsRemoved,
//                         // : smsSaved,
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         backgroundColor: Colors.green,
//                         textColor: Colors.white,
//                         fontSize: 18.0);
//                     _onItemTapped(2, _index);
//                     Navigator.pop(context, false);
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text(
//                     "خیر",
//                     textAlign: TextAlign.right,
//                   ),
//                   onPressed: () => Navigator.pop(context, false),
//                 ),
//               ],
//             ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var ui = Provider.of<UiState>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "فهرست منتخب",
//           style: AppStyle.titleup,
//         ),
//         elevation: 0.0,
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: new ReorderableListView(
//             children: new List.generate(
//                 // widget.numCard,
//                 globals.mapBookMarked.length,
//                 (index) => Card(
//                     key: ValueKey(globals.mapBookMarked[index]),
//                     elevation: 0.0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         side: BorderSide(width: 0.5, color: Colors.green)),
//                     child: Container(
//                         padding: EdgeInsets.all(1),
//                         // child: Column(
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         child: new ListTile(
//                             title: Align(
//                               child: Text(
//                                 (((globals.mapBookMarked[index]
//                                                 ['codeBookMarked']) %
//                                             1000)) <=
//                                         0
//                                     ? globals.mapBookMarked[index]
//                                         ['titleBookMarked']
//                                     : globals.mapBookMarked[index]
//                                             ['titleBookMarked'] +
//                                         " آیه شماره  " +
//                                         "${(((globals.mapBookMarked[index]['codeBookMarked']) % 1000))}",
//                                 style: AppStyle.title,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             leading: Icon(
//                               Icons.height,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(
//                                 Icons.delete,
//                               ),
//                               onPressed: () {
//                                 _onDeletePressed(index);
//                               },
//                             ),
//
//                             // title: IntrinsicHeight(
//                             //   child: Stack(
//                             //     children: [
//                             //       Align(
//                             //         child: Text(
//                             //           (((globals.mapBookMarked[index][
//                             //                               'codeBookMarked']) %
//                             //                           1000) -
//                             //                       1) <
//                             //                   0
//                             //               ? globals.mapBookMarked[index]
//                             //                   ['titleBookMarked']
//                             //               : globals.mapBookMarked[index]
//                             //                       ['titleBookMarked'] +
//                             //                   "آیه شماره  " +
//                             //                   "${(((globals.mapBookMarked[index]['codeBookMarked']) % 1000))}",
//                             //           style: AppStyle.title,
//                             //           textAlign: TextAlign.center,
//                             //         ),
//                             //       ),
//                             //       Positioned(
//                             //         right: 0,
//                             //         child: Icon(
//                             //           Icons.height,
//                             //           color: Colors.grey.withOpacity(0.5),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 0.0, horizontal: 16),
// //                            dense: true,
//
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailSec(
//                                             detail: globals.mapBookMarked[index]
//                                                 ['titleBookMarked'],
//                                             index: (globals.mapBookMarked[index]
//                                                         ['codeBookMarked'] -
//                                                     1000000) ~/
//                                                 1000,
//                                             indexKey: (((globals.mapBookMarked[
//                                                                 index][
//                                                             'codeBookMarked']) %
//                                                         1000)) <
//                                                     0
//                                                 ? 0
//                                                 : (((globals.mapBookMarked[
//                                                             index]
//                                                         ['codeBookMarked']) %
//                                                     1000)),
//                                             indexFasl: 1,
//                                             code: globals.mapBookMarked[index]
//                                                 ['codeBookMarked'],
//                                           ))).then((value) {
//                                 setState(() {
//                                   widget.titlebookmark =
//                                       globals.titleBookMarked;
//                                   widget.indexbookmark =
//                                       globals.indexBookMarked;
//                                   widget.indexKeybookmark =
//                                       globals.indexKeyBookMarked;
//                                   widget.indexFaslbookmark =
//                                       globals.indexFaslBookMarked;
//                                   widget.codebookmark = globals.codeBookMarked;
//                                   List mapBookMarked = [
//                                     for (int i = 0;
//                                         i < globals.codeBookMarked.length;
//                                         i++)
//                                       {
//                                         'index': i,
//                                         'titleBookMarked':
//                                             globals.titleBookMarked[i],
//                                         'indexBookMarked':
//                                             globals.indexBookMarked[i],
//                                         'indexKeyBookMarked':
//                                             globals.indexKeyBookMarked[i],
//                                         'indexFaslBookMarked':
//                                             globals.indexFaslBookMarked[i],
//                                         'codeBookMarked':
//                                             globals.codeBookMarked[i],
//                                       }
//                                   ];
//                                   globals.mapBookMarked = mapBookMarked;
//                                 });
//                               });
//                             })))),
//             onReorder: reorderData,
//           )),
//       bottomNavigationBar: AdmobBanner(
//         adUnitId: 'ca-app-pub-5524959616213219/3003275544',
//         adSize: AdmobBannerSize.BANNER,
//         // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
//         //   if (event == AdmobAdEvent.clicked) {}
//         // },
//       ),
//     );
//   }
//
//   void reorderData(int oldindex, int newindex) {
//     setState(() {
//       if (newindex > oldindex) {
//         newindex -= 1;
//       }
//       final items = globals.mapBookMarked.removeAt(oldindex);
//       globals.mapBookMarked.insert(newindex, items);
//       print(
//           '-----------------------------------------------mapBookMarked----------------------------------------${globals.mapBookMarked}');
//       globals.titleBookMarked = [];
//       globals.indexBookMarked = [];
//       globals.indexKeyBookMarked = [];
//       globals.indexFaslBookMarked = [];
//       globals.codeBookMarked = [];
//
//       for (int i = 0; i < globals.mapBookMarked.length; i++) {
//         globals.titleBookMarked
//             .insert(i, globals.mapBookMarked[i]['titleBookMarked']);
//         globals.indexBookMarked
//             .insert(i, globals.mapBookMarked[i]['indexBookMarked']);
//         globals.indexKeyBookMarked
//             .insert(i, globals.mapBookMarked[i]['indexKeyBookMarked']);
//         globals.indexFaslBookMarked
//             .insert(i, globals.mapBookMarked[i]['indexFaslBookMarked']);
//         globals.codeBookMarked
//             .insert(i, globals.mapBookMarked[i]['codeBookMarked']);
//       }
//
//       setBookmark(
//           globals.titleBookMarked,
//           globals.indexBookMarked,
//           globals.indexKeyBookMarked,
//           globals.indexFaslBookMarked,
//           globals.codeBookMarked);
//     });
//   }
// }
