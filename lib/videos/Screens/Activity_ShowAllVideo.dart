import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/utils/style.dart';
import '../../ui/widget/drawer.dart';
import '../api/api.dart';
import '../models/theme_model.dart';
import 'Activity_Review.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class Activity_ShowAllVideo extends StatelessWidget {
  Activity_ShowAllVideo(this.cat_id);
  final String cat_id;


  GlobalKey<ScaffoldState> _scaffoldKey;

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
                    future: api().GetAllVideosPerPage("1", "1"),
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
                                  for (var i = 0; i < snapshot.data.length; i++)
                                    Padding(
                                      padding: EdgeInsets.all(6),
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(0)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Activity_Review(
                                                            theme_data: snapshot
                                                                .data[i])));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                12,
                                            child: Image.network(
                                              "http://arbaeentv.com/" +
                                                  snapshot
                                                      .data[i].cover_address,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  50,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    )
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
