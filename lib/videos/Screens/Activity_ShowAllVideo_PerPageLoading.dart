import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/utils/style.dart';
import '../../ui/widget/drawer.dart';
import '../Server/server.dart';
import '../api/api.dart';
import '../models/theme_model.dart';
import 'Activity_Review.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class Activity_ShowAllVideo_PerPageLoading extends StatefulWidget {
  const Activity_ShowAllVideo_PerPageLoading({Key key}) : super(key: key);

  @override
  State<Activity_ShowAllVideo_PerPageLoading> createState() =>
      _Activity_ShowAllVideo_PerPageLoadingState();
}

class _Activity_ShowAllVideo_PerPageLoadingState
    extends State<Activity_ShowAllVideo_PerPageLoading> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  int _page = 1;

  final int _limit = 20;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        // final res =
        // await http.get(Uri.parse("$_baseUrl?page=$_page"));
        // final List fetchedPosts = json.decode(res.body);

        // final res =api().GetAllVideosPerPage(_page);
        var response =
            await server().Post("video/all", {"page": _page.toString()}, true);
        List all_vid_each_page = jsonDecode(response)["data"]["videos"]["data"];

        if (all_vid_each_page.isNotEmpty) {
          setState(() {
            _posts.addAll(all_vid_each_page);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {

      print(
          '///////////////////////////////////// _firstLoad     start');
      // final res =
      // await http.get(Uri.parse("$_baseUrl?page=$_page"));
      // final res =api().GetAllVideosPerPage("1", _page.toString());
      var response = await server().Post("video/all",{ "category_id" : "1" , "page" : _page.toString()},true);
      List all_vid_each_page = jsonDecode(response)["data"]["videos"]["data"];
      // print('///////////////////////////////////// res     $_baseUrl?page=$_page');
      print(
          '///////////////////////////////////// res     ${all_vid_each_page}');

      setState(() {
        _posts = all_vid_each_page;
        print('///////////////////////////////////// _posts     ${_posts}');
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  ScrollController _controller;
  @override
  void initState() {
    print("/////////////////////////////////////// per page");
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  //main function start
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: Container(
                child: Drawer(
                  child: Drawers(
                      newVersionBuildNumber: globals.newVersionBuildNumber,
                      currentBuildNumber: globals.currentBuildNumber),
                ),
                width: 200),
            key: _scaffoldKey,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    title: Text(
                      "نمایش همه",
                      style: AppStyle.titleup,
                    ),
                  )
                ];
              },
              body: Column(children: [
                // Container(
                //   height: 60,
                //   child: TopAppBar(context),
                // )
                // ,
                FutureBuilder<List<theme_model>>(
                    future: api().GetAllVideosPerPage(_page.toString(),"1"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 60,
                            child: Center(
                              child: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    Image.asset("assets/icons/box.png",
                                        width: 90),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                    ),
                                    Text("موردی یافت نشد")
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: SingleChildScrollView(
                              child: Wrap(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      controller: _controller,
                                      itemBuilder: (_, index) => Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: ListTile(
                                          title: Text(_posts[index]['title']),
                                          subtitle: Text(
                                              _posts[index]['video_address']),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_isLoadMoreRunning == true)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 40),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),

                                  if (_hasNextPage == false)
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 40),
                                      color: Colors.amber,
                                      child: const Center(
                                        child: Text(
                                            'You have fetched all of the content'),
                                      ),
                                    ),

                                  // for(var i = 0; i < snapshot.data.length; i++)
                                  //   Padding(
                                  //     padding: EdgeInsets.all(6),
                                  //     child: TextButton(
                                  //         style: TextButton.styleFrom(
                                  //             padding: EdgeInsets.all(0)
                                  //         ),
                                  //         onPressed: () {
                                  //           Navigator.push(context, MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   Activity_Review(theme_data:snapshot.data[i])));
                                  //         },
                                  //         child: Container(
                                  //           width: MediaQuery
                                  //               .of(context)
                                  //               .size
                                  //               .width / 2 - 12,
                                  //
                                  //           child: Image.network(
                                  //               "https://arbaeentv.com/"+
                                  //                   snapshot.data[i].cover_address
                                  //                       , width: MediaQuery.of(context).size.width / 2 - 50,height:200, fit: BoxFit.cover,
                                  //               ),
                                  //         )
                                  //     ),
                                  //   )
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 60,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      }
                    })
              ]),
            )));
  }
  //main function end

  //top appbar start
  Widget TopAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.turn_sharp_left,
                    color: Colors.black,
                    size: 24,
                  )),
            ),
            Image.asset(
              "assets/textlogo.png",
              height: 50,
            )
          ],
        ),
      ),
    );
  }
//top appbar end

}
