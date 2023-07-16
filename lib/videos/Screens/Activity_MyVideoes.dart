import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/videos/Screens/Activity_VideoEdit.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/layout/Global/navbar.dart';
import 'package:mafatih/videos/layout/home/layout_home.dart';
import 'package:mafatih/videos/layout/home/layout_profile.dart';
import 'package:mafatih/videos/layout/home/layout_setting.dart';
import 'package:mafatih/videos/layout/home/layout_theme.dart';
import 'package:mafatih/videos/models/video_project_model.dart';

class Activity_MyVideoes extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() => Activity_MyVideoes_State();

}


class Activity_MyVideoes_State extends State<Activity_MyVideoes>
{


  //Global Variables
   GlobalKey<ScaffoldState> _scaffoldKey;



  @override
  void initState() 
  {
    super.initState();  
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }




  //Main functio start
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: navbar(),
        body: Column(
          children: [
            Container(
              height: 60,
              child: TopAppBar(context),
            )
            ,
            Container(
              height: MediaQuery.of(context).size.height-60-60,
              child: SingleChildScrollView(
              child: Column(
                children: [

                  Content(context)

                ],
              ),
             ),
            )
          ],
        ),
      )
    );
  }
  //Main functio end

  
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
              child: InkWell(
              onTap: (){
                debugPrint("Open");
                setState(() {
                  _scaffoldKey.currentState?.openEndDrawer();
                });
                
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



  
  //Content start
  Widget Content(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
      margin: EdgeInsets.only(left: 14,right: 14),
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width-14,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text("پروژه های من",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
            height: 1,
            color: Colors.grey,
          )
          ,
          FutureBuilder<List<video_project_model>>(
          future: api().GetCurentProjects(),
          builder: ((context, snapshot) {

            if(snapshot.hasData) {

              return Wrap(
                children: [

                  for(var i = 0; i < snapshot.data.length; i++)
                    if(snapshot.data[i].make_pool.percent==100)
                        Container(
                          margin: EdgeInsets.all(9),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2 - 48,
                          child: Column(
                            children: [

                              Image.network("https://www.videoir.com/" +
                                  snapshot.data[i].cover.file_address,
                                height: 114, fit: BoxFit.fitWidth,)
                              ,
                              Row(
                                children: [

                                  Expanded(
                                      child: TextButton(
                                          onPressed: () {

                                          },
                                          child: Container(
                                            height: 46,
                                            child: Icon(Icons.delete, size: 18,
                                                color: Color(0XFF9ca3af)),
                                          )
                                      )
                                  )
                                  ,
                                  Expanded(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Activity_VideoEdit()));
                                          },
                                          child: Container(
                                            height: 46,
                                            child: Icon(Icons.edit, size: 18,
                                                color: Color(0XFF9ca3af)),
                                          )
                                      )
                                  )

                                ],
                              )

                            ],
                          ),
                        )

                ],
              );

            }
            else{
              return CircularProgressIndicator();
            }

          })
          )

        ],
      ),
    )
    );
  }
  //Content end




}