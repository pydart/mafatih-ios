import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/data/utils/style.dart';

import '../widget/ayatkursi.dart';

class HomeAbout extends StatefulWidget {
  @override
  _HomeAboutState createState() => _HomeAboutState();
}

class _HomeAboutState extends State<HomeAbout>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

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
            backgroundColor:Theme.of(context).brightness == Brightness.light
                ? Colors.green
                : Colors.black,
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => Navigator.of(context).pop(),
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
