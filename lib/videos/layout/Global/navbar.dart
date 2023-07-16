import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mafatih/videos/Screens/Activity_CurrentProjects.dart';
import 'package:mafatih/videos/Screens/Activity_Main.dart';
import 'package:mafatih/videos/Screens/Activity_MyVideoes.dart';
import 'package:mafatih/videos/Screens/Activity_Splash.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/DataSaver/DataSaver.dart';
import 'package:mafatih/videos/data/data.dart';


class navbar extends StatelessWidget
{

  @override
  Widget build(BuildContext context) 
  {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          color: Color(0X1100adee),
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [

              NavbarProfile(context)
              ,
              NavbarItems(context)

            ],
          ),
        ),
      ),
    );
  }




  //Navbar Profile Start
  Widget NavbarProfile(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.all(10),
      width: 280,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [

              Row(
                children: [
                  Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network("https://www.videoir.com/"+user.image,width: 70,),
                      )
                  )
                  ,
                  Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(user.name)
                            ,
                            Container(
                              margin: EdgeInsets.all(2),
                            )
                            ,
                            Text(user.mobile,style: TextStyle( color: Color(0XFFA2A2A2) ),)

                          ],
                        ),
                      )
                  )
                ],
              )
              
            ],
          )
      ),
    );
  }
  //Navbar Profile End



  //Navbar Items Start
  Widget NavbarItems(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(bottom: 40),
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [

            
            Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_CurrentProjects() ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.movie_creation,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("ویدیو های در حال ساخت",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_MyVideoes() ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.movie_outlined,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("پروژه های من",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      launch("https://videoir.com/blog/2023/01/08/help/");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.create,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("راهنمای ساخت ویدیو",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_MyVideoes() ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.call,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("تماس با ما",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      launch("https://videoir.com/blog/2023/01/08/about/");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.accessibility_sharp,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("درباره ما",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextButton(
                    onPressed: (){
                      launch("https://videoir.com/blog/2023/01/08/community-guideline/");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.backup,size: 20,color: Color(0XFFA5A5A5))
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                          ,
                          Text("حریم خصوصی",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5,bottom: 5,left: 20,right: 20),
                height: 1,
                color: Colors.grey,
              )
            ,
            Container(
              margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextButton(
                  onPressed: (){

                    api().Logout();
                    Data_Sever.Save_Data("token", "");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Activity_Splash()), (route) => false);

                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.logout,size: 20,color: Color(0XFFA5A5A5))
                        ,
                        Container(
                          margin: EdgeInsets.all(5),
                        )
                        ,
                        Text("خروج از حساب کاربری",style: TextStyle( color: Color(0XFF3B4147),fontSize: 13 ),)
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  //Navbar Items End




  
}