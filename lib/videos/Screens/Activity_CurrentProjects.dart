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

class Activity_CurrentProjects extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() => Activity_CurrentProjects_State();

}


class Activity_CurrentProjects_State extends State<Activity_CurrentProjects>
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
              height: MediaQuery.of(context).size.height-60,
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

          Text("پروژه های در حال حاضر",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
            height: 1,
            color: Colors.grey,
          )
          ,
          Column(
            children: [


              FutureBuilder<List<video_project_model>>(
                future: api().GetCurentProjects(),
                builder: ((context, snapshot) {

                  if(snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 9, right: 9, top: 14, bottom: 14),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              children: [

                                Container(
                                  child: Column(
                                    children: [

                                      Row(
                                        children: [

                                          Image.asset("assets/images/wait.jpeg",
                                            width: 150, fit: BoxFit.fitWidth,)
                                          ,
                                          Container(
                                            margin: EdgeInsets.all(5),
                                          )
                                          ,
                                          Column(
                                            children: [
                                              Text("ویدیوی در حال ساخت",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11),)
                                            ],
                                          )

                                        ],
                                      )
                                      ,
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        color: Colors.grey,
                                        height: 1,
                                      )
                                      ,
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Color(0XFFe5e7eb),
                                          valueColor: new AlwaysStoppedAnimation<
                                              Color>(Colors.blue),
                                          value: snapshot.data[index].make_pool.percent / 100,
                                          minHeight: 10,
                                        ),
                                      )

                                    ],
                                  ),
                                )


                              ],
                            ),
                          );
                        })
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                })
              )


            ],
          )
          
        ],
      ),
    )
    );
  }
  //Content end




}