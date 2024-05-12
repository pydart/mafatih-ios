import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mafatih/videos/models/theme_model.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import '../../ui/widget/drawer.dart';
import '../Widgets/videoPlayer/player_page.dart';

class Activity_Review extends StatefulWidget {

  Activity_Review({required this.theme_data});
  theme_model theme_data;

  @override
  State<StatefulWidget> createState() =>
      Activity_Review_State();
}

class Activity_Review_State extends State<Activity_Review> {


  @override
  void initState() {
    KeepScreenOn.turnOn();
    super.initState();
  }
  //initilize function end

  //main function start
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor:Colors.green,

                    pinned: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ];
              },

              // endDrawer: navbar(),
              body: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [VideoPlayer(context), Content(context)],
                  ),
                ),
              ),
            )));
  }


  //Video Player Start
  Widget VideoPlayer(BuildContext context) {
    print(
        "//////////////////////////////////   theme_data            //////////////  ${widget.theme_data}");

    return Container(
      width: MediaQuery.of(context).size.width - 14,
      margin: EdgeInsets.all(14),
      child: AspectRatio(
        aspectRatio: 16 / 16,
        child: SafeArea(
          child: new PydartVideoPlayer(
            url: "https://arbaeentv.com/" + widget.theme_data.video_address!,
          ),
        ),
      ),
    );
  }

  //Video Player End
  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }

  //Content Start
  Widget Content(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width - 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.theme_data.title!,
            style: TextStyle(fontSize: 14, fontFamily: 'IRANSans'),
          ),
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            height: 1,
            color: Color(0XFFb0b6bf),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.timer, color: Color(0XFFb0b6bf), size: 14),
                  Container(
                    margin: EdgeInsets.all(2),
                  ),
                  Text(
                    "زمان ویدیو " + replaceFarsiNumber(widget.theme_data.duration!),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IRANSans',
                      color: Color(0XFFb0b6bf),
                    ),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    Share.share(
                      "https://arbaeentv.com/" + widget.theme_data.video_address!,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Color(0XFFb0b6bf), size: 14),
                      Container(
                        margin: EdgeInsets.all(2),
                      ),
                      Text(
                        "اشتراک گذاری",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IRANSans',
                          color: Color(0XFFb0b6bf),
                        ),
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Share.share("https://arbaeentv.com/video/" +
                        widget.theme_data.video_address!);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye,
                          color: Color(0XFFb0b6bf), size: 14),
                      Container(
                        margin: EdgeInsets.all(2),
                      ),
                      Text(
                        replaceFarsiNumber(widget.theme_data.seen.toString()),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IRANSans',
                          color: Color(0XFFb0b6bf),
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            height: 1,
            color: Color(0XFFb0b6bf),
          ),
          Center(
            child: AdmobBanner(
              adUnitId: 'ca-app-pub-5524959616213219/5790610979',
              adSize: AdmobBannerSize.LARGE_BANNER,
              // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //   if (event == AdmobAdEvent.clicked) {}
              // },
            ),
          ),
        ],
      ),
    );
  }
//Content End
}
