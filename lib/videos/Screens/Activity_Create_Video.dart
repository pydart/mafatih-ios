import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/videos/layout/Global/navbar.dart';
import 'package:mafatih/videos/layout/VideoMake/layout_make.dart';
import 'package:mafatih/videos/layout/VideoMake/layout_plans.dart';
import 'package:mafatih/videos/layout/VideoMake/layout_release.dart';
import 'package:mafatih/videos/layout/VideoMake/layout_sounds.dart';

class Activity_Create_Video extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => Activity_Create_Video_State();
}


class Activity_Create_Video_State extends State<Activity_Create_Video>
{


  //global variables
  var layouts=[];
  var curent_section=0;  
   GlobalKey<ScaffoldState> _scaffoldKey;


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
    layouts.add(layout_plans());
    layouts.add(layout_sounds());
    layouts.add(layout_release());
    layouts.add(layout_make());
    

    return SafeArea(child: Scaffold(
      key: _scaffoldKey,
      endDrawer: navbar(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [

              TopAppBar(context)
              ,
              Container(
                margin: EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("نمایش قالب",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
                    ,
                    InkWell(
                      child: Text("قالب ها",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ,color: Colors.blue),),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
              ,
              Steps(context)
              ,
              layouts[curent_section]
              ,
              NextBtn(context)

            ],
          ),
        ),
      ),
    ));
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


  //Content Start
  Widget Steps(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width-150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [

                    Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                  margin: EdgeInsets.only(top: 10,bottom: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(
                    child: Icon(Icons.featured_play_list_outlined,color: Colors.white),
                  ),
                )
                ,
                Text("پلان ها",style: TextStyle( color: Colors.black, fontSize: 12 ),)
                  ],
                )
                ,
                Container(
                  width: (MediaQuery.of(context).size.width/3-30)/2,
                  color: Colors.blue,
                  height: 1,
                )
                ,
                Container(
                  width: (MediaQuery.of(context).size.width/3-30)/2,
                  color: (curent_section>0)?Colors.blue:Color(0XFFd1d6dc),
                  height: 1,
                )
                ,
                Column(
                  children: [

                    Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                  margin: EdgeInsets.only(top: 10,bottom: 2),
                  decoration: BoxDecoration(
                    color: (curent_section>0)?Colors.blue:Color(0XFFd1d6dc),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(
                    child: Icon(Icons.music_note_rounded,color: Colors.white),
                  ),
                )
                ,
                Text("انتخاب موزیک",style: TextStyle( color: Colors.black, fontSize: 12 ),)
                  ],
                )
                ,
                Container(
                  width: (MediaQuery.of(context).size.width/3-30)/2,
                  color: (curent_section>0)?Colors.blue:Color(0XFFd1d6dc),
                  height: 1,
                )
                ,
                Container(
                  width: (MediaQuery.of(context).size.width/3-30)/2,
                  color: (curent_section>1)?Colors.blue:Color(0XFFd1d6dc),
                  height: 1,
                )
                ,
                Column(
                  children: [

                    Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                  margin: EdgeInsets.only(top: 10,bottom: 2),
                  decoration: BoxDecoration(
                    color: (curent_section>1)?Colors.blue:Color(0XFFd1d6dc),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(
                    child: Icon(Icons.video_collection_rounded,color: Colors.white),
                  ),
                )
                ,
                Text("خروجی",style: TextStyle( color: Colors.black, fontSize: 12 ),)
                  ],
                )


              ],
            ),
          )

        ],
      ),
      ),
    );
  }
  //Content End


  //Next Btn Start
  Widget NextBtn(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(top: 0,bottom: 14),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Visibility(
                visible: (curent_section<2)?true:false,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                width: 150,
                height: 50,
                padding: EdgeInsets.all(5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0XFF07afee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      curent_section++;
                    });
                  },
                  child: Text("بعدی",style: TextStyle( color: Colors.white ),),
                ),
              ),
              )
              )
              ,
              Visibility(
                visible: (curent_section==2)?true:false,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                width: 150,
                height: 50,
                padding: EdgeInsets.all(5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      curent_section++;
                    });
                  },
                  child: Text("ساخت",style: TextStyle( color: Colors.white ),),
                ),
              ),
              )
              )
              ,
              Visibility(
                visible: (curent_section>0 && curent_section<3)?true:false,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                width: 150,
                height: 50,
                padding: EdgeInsets.all(5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0XFF07afee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      curent_section--;
                    });
                  },
                  child: Text("قبلی",style: TextStyle( color: Colors.white ),),
                ),
              ),
              )
              )

              
            ],
          )
          
        ],
      ),
    )
    );
  }
  //Next Btn End



  
}