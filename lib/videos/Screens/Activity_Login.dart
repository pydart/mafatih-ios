import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mafatih/videos/Screens/Activity_ForgetPassword.dart';
import 'package:mafatih/videos/Screens/Activity_Main.dart';
import 'package:mafatih/videos/Screens/Activity_Signup.dart';
import 'package:mafatih/videos/api/api.dart';


class Activity_Login extends StatelessWidget
{


  var username_text = TextEditingController();
  var password_text = TextEditingController();


  //main function start
  @override
  Widget build(BuildContext context) 
  {
    //Get Permission
    requestFilePermission();

    return SafeArea(child: Scaffold(
      backgroundColor: Color(0XFFf7fbfe),

      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(14),
            height: 520,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/logoblue.png",
                  width: 70,
                  height: 70,
                )
                ,
                Container(
                  margin: EdgeInsets.all(14),
                )
                ,
                Text("شماره همراه خود را وارد کنید",style: TextStyle( color: Colors.black,fontSize: 14 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                Text("کد فعال سازی به شماره شما ارسال خواهد شد",style: TextStyle( color: Colors.black,fontSize: 14  ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                ,
                Container(
                  margin: EdgeInsets.all(10),
                )
                ,
                Text("*شماره موبایل",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
                ,
                Container(
                  margin: EdgeInsets.all(1),
                )
                ,
                ClipRRect(
                  child: SizedBox(
                    child: TextField(
                      controller: username_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFA5A5A5)
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          hintText: "09×××××××××",
                          hintStyle: TextStyle(
                              color: Color(0XFFC4BFBF)
                          )
                      ),
                    ),
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                Text("*کلمه عبور",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
                ,
                Container(
                  margin: EdgeInsets.all(1),
                )
                ,
                ClipRRect(
                  child: SizedBox(
                    child: TextField(
                      controller: password_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                          hintText: "****",
                          hintStyle: TextStyle(
                            color: Color(0XFFC4BFBF)
                          )
                      ),
                    ),
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Activity_ForgetPassword()));
                        },
                        child: Text("فراموشی رمز عبور",style: TextStyle( color: Colors.blue,fontSize: 14 ),textAlign: TextAlign.right),
                      )
                    ],
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0XFF2AC114),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: () async {

                        if(username_text.text.length>0 && password_text.text.length>0)
                        {
                          bool LoginReponse=await api().Login(username_text.value.text.toString(),password_text.value.text.toString());
                          if(LoginReponse)
                          {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Activity_Main()), (route) => false);
                          }
                        }
                        else
                        {
                          Fluttertoast.showToast(
                              msg: "مقادیر خواسته شده را تکمیل کنید",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.CENTER,
                              webPosition: "center",
                              webBgColor: "#FF0000",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }

                      },
                      child: Text("ورود",style: TextStyle( color: Colors.white ),),
                    ),
                  ),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0XFF07afee),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Activity_Signup()));
                      },
                      child: Text("ثبت نام",style: TextStyle( color: Colors.white ),),
                    ),
                  ),
                )

              ],
            ),
          ),
            ),
        ),
      ),
    ));
  }
  //main function end



  //Get All Permissions Start
  Future<void> requestFilePermission() async
  {
    PermissionStatus result = await Permission.storage.request();
  }
  //Get All Permissions End





}