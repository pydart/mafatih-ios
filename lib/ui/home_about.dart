import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/data/utils/style.dart';
import 'package:provider/provider.dart';

import 'ayatkursi.dart';

class HomeAbout extends StatefulWidget {
  @override
  _HomeAboutState createState() => _HomeAboutState();
}

class _HomeAboutState extends State<HomeAbout>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => Navigator.of(context).pop(),
//              onPressed: () => Navigator.popUntil(
//                  context, ModalRoute.withName(Navigator.defaultRouteName)),

//              onPressed: () =>
//                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            title: Text('درباره برنامه', style: AppStyle.detailsurahTitle),
            elevation: 0.0,
          )
        ];
      },
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[AyatKursi()],
        ),
      ),
    ));
  }
}
