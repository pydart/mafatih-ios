import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/videos/Screens/Activity_VideoEdit.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/models/video_project_model.dart';

class layout_profile extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => layout_profile_state();

}

class layout_profile_state extends State<layout_profile>
{

  //Main function start
  @override
  Widget build(BuildContext context) 
  {
    return SingleChildScrollView(
      child: Column(
      children: [

        Header(context)
        ,
        Content(context)

      ],
    ),
    );
  }
  //Main function end



  //header start
  Widget Header(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: Stack(
        children: [

          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: Image.network("https://www.videoir.com/images/profile-cover.jpg",width: MediaQuery.of(context).size.width,fit: BoxFit.cover)
            )
          )
          ,
          Positioned(
            left: 7,
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width-14,
              height: 100,
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 70,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                      )
                      ,
                      Text("Rezafta",style: TextStyle( color: Colors.black ,fontSize: 14),)
                    ],
                  ),
                )
              ),
            )
          )
          ,
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 50,
            top: 50,
            child: Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000),
                child: Image.network("https://www.videoir.com/upload/images/2022/11/14/166841877486116.jpeg",width: 100,height: 100),
              ),
            )
          )

        ],
      ),
    );
  }
  //header end


  //Content start
  Widget Content(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
        ),
      margin: EdgeInsets.only(left: 0,right: 0),
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width-14,
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
            builder:((context, snapshot) {

              if(snapshot.hasData)
              {
                return Wrap(
                  children: [

                    for(var i=0;i<snapshot.data.length;i++)
                      Container(
                        margin: EdgeInsets.only(left: 4,right: 4,bottom: 9,top: 9),
                        width: MediaQuery.of(context).size.width / 2 - 15,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFA5A5A5),style: BorderStyle.solid,width: 0.25),
                        ),
                        child: Column(
                          children: [

                            Image.network("https://www.videoir.com/" +
                                snapshot.data[i].cover.file_address,height: 90,fit: BoxFit.fitWidth,)
                            ,
                            Container(
                              margin: EdgeInsets.all(2),
                            )
                            ,
                            Text(snapshot.data[i].title)
                            ,
                            Row(
                              children: [

                                Expanded(
                                    child: TextButton(
                                        onPressed: (){

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_VideoEdit() ));

                                        },
                                        child: Container(
                                          height: 30,
                                          child: Icon(Icons.edit,size: 18,color: Color(0XFF9ca3af )),
                                        )
                                    )
                                )
                                ,
                                Expanded(
                                    child: TextButton(
                                        onPressed: (){
                                          Delete_Popup(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          child: Icon(Icons.delete,size: 18,color: Color(0XFF9ca3af )),
                                        )
                                    )
                                )

                              ],
                            )
                            ,
                            Container(
                              margin: EdgeInsets.all(4),
                            )

                          ],
                        ),
                      )

                  ],
                );
              }
              else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

            })
          )
          
        ],
      ),
    )
    );
  }
  //Content end


  //Alert start
  Future<void> Delete_Popup(BuildContext context) async
  {
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        content: Container(
          height: 100,
          width: MediaQuery.of(context).size.width - 20,
          color: Colors.white,
          child: Column(
            children: [
              Text("حذف ویدیو",style: TextStyle( fontSize: 16, color: Colors.black45,fontWeight: FontWeight.bold ))
              ,
              Container(margin: EdgeInsets.all(4))
              ,
              Text("آیا از حذف ویدیو مطمئن هستید؟",style: TextStyle( fontSize: 13,color: Colors.black45,fontWeight: FontWeight.bold ))
              ,
              Container(margin: EdgeInsets.all(7))
              ,
              Row(
                children: [
                  TextButton(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1),
                        child: Center(
                          child: Text("خیر منصرف شدم",style: TextStyle( fontSize: 13,color: Colors.black45,fontWeight: FontWeight.bold ),textAlign: TextAlign.center),
                        ),
                      )
                  )
                  ,
                  Container(margin: EdgeInsets.all(7))
                  ,
                  TextButton(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0XFFff4c4c)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(1),
                        child: Center(
                          child: Text("بله حذف شود",style: TextStyle( fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold ),textAlign: TextAlign.center),
                        ),
                      )
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  //Alert end



}