import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:mafatih/videos/Screens/Activity_Create_Video.dart';
import 'package:mafatih/videos/Widgets/VideoApp.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/layout/Global/navbar.dart';
import 'package:mafatih/videos/models/theme_model.dart';
import 'package:mafatih/library/Globals.dart' as globals;

import '../../data/utils/style.dart';
import '../../ui/widget/drawer.dart';

class Activity_Review extends StatefulWidget
{
  theme_model theme_data;

  Activity_Review({
     this.theme_data
  });

  @override
  State<StatefulWidget> createState()=>Activity_Review_State(
    theme_data: this.theme_data
  );
}

class Activity_Review_State extends State<Activity_Review>
{

  //constractor start
  theme_model theme_data;

  Activity_Review_State({
     this.theme_data
  });
  //constractor end


  //global variable start
   GlobalKey<ScaffoldState> _scaffoldKey;
  //global variable end



  //initilize function start
  @override
  void initState() 
  {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }
  //initilize function end





  //main function start
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
      child:Scaffold(

        drawer: Container(
        child: Drawer(
        child: Drawers(
        newVersionBuildNumber: globals.newVersionBuildNumber, currentBuildNumber: globals.currentBuildNumber),
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
  "نمایش ویدیو",
  style: AppStyle.titleup,
  ),
  )
  ];
  },


        // endDrawer: navbar(),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [

              // TopAppBar(context)
              // ,
              // Container(
              //   margin: EdgeInsets.all(14),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("نمایش قالب",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
              //       ,
              //       InkWell(
              //         child: Text("قالب ها",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ,color: Colors.blue),),
              //         onTap: (){
              //           Navigator.pop(context);
              //         },
              //       )
              //     ],
              //   ),
              // )
              // ,
              VideoPlayer(context)
              ,
              Content(context)

            ],
          ),
        ),
      ),
    )));
  }
  //main function end


  //top appbar start
  Widget TopAppBar(BuildContext context)
  {
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
              onPressed: (){
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: Icon(Icons.menu,color: Colors.black,size: 24,)
            ),
            )
            ,
            Image.asset("assets/textlogo.png",height: 50,)

          ],
        ),
      ),
    );
  }
  //top appbar end


  //Video Player Start
  Widget VideoPlayer(BuildContext context)
  {
    print("//////////////////////////////////   theme_data            //////////////  $theme_data");

    return Container(
      width: MediaQuery.of(context).size.width - 14,
      margin: EdgeInsets.all(14),
      child: AspectRatio(
        aspectRatio: 16/16,
        child: VideoApp(
          videoaddress: "http://arbaeentv.com/"+theme_data.video_address,
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
  Widget Content(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width-14,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text(theme_data.title,style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold ,fontFamily: 'IRANSans'),)
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
            height: 1,
            color: Color(0XFFb0b6bf),
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  
                  Icon(Icons.timer,color: Color(0XFFb0b6bf),size: 14)
                  ,
                  Container(
                    margin: EdgeInsets.all(2),
                  )
                  ,
                  Text("زمان ویدیو "+replaceFarsiNumber(theme_data.duration),style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold ,fontFamily: 'IRANSans',color: Color(0XFFb0b6bf),),)

                ],
              )
              ,
              TextButton(
                onPressed: (){
                  Share.share('https://Videoir.com/template/'+theme_data.title);
                },
                child: Row(
                  children: [

                    Icon(Icons.share,color: Color(0XFFb0b6bf),size: 14)
                    ,
                    Container(
                      margin: EdgeInsets.all(2),
                    )
                    ,
                    Text("اشتراک گذاری",style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold ,fontFamily: 'IRANSans' ,color: Color(0XFFb0b6bf),),)

                  ],
                )
              )


            ],
          )
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
            height: 1,
            color: Color(0XFFb0b6bf),
          )
          ,
          // Container(
          //   width: 50,
          //   height: 50,
          //   child: Center(
          //     child: SizedBox(
          //       width: 40,
          //       height: 40,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(10),
          //         child: Container(
          //         color: Color(0XFFf9fafb),
          //         child: Column(
          //           children: [
          //             Text("-",style: TextStyle( color: Color(0XFF9ca3af),fontSize: 14,fontWeight: FontWeight.bold ),)
          //             ,
          //             Text(('(theme_data.size_16=="true")?"16":"")+((theme_data.size_1=="true")?"1":":")+((theme_data.size_9=="true")?"9":"")'),style: TextStyle( color: Color(0XFF9ca3af),fontSize: 10,fontWeight: FontWeight.bold ),)
          //           ],
          //         ),
          //       ),
          //       ),
          //     ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.only(top: 14,bottom: 14),
          //   height: 1,
          //   color: Color(0XFFb0b6bf),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   padding: EdgeInsets.all(5),
          //   child: TextButton(
          //     style: TextButton.styleFrom(
          //       backgroundColor: Color(0XFF07afee),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)
          //       )
          //     ),
          //     onPressed: (){
          //
          //       curent_theme=theme_data;
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Create_Video() ));
          //
          //     },
          //     child: Text("ساخت ویدیو",style: TextStyle( color: Colors.white ),),
          //   ),
          // ),
          // )

        ],
      ),
    );
  }
  //Content End


}