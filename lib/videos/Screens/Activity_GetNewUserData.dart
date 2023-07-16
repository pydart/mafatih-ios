import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mafatih/videos/Screens/Activity_ForgetPassword.dart';
import 'package:mafatih/videos/Screens/Activity_Main.dart';
import 'package:mafatih/videos/Screens/Activity_Signup.dart';
import 'package:mafatih/videos/Screens/Activity_Verify.dart';
import 'package:mafatih/videos/Screens/Activity_Verify_Forget.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';


class Activity_GetNewUserData extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => Activity_GetNewUserData_State();

}

class Activity_GetNewUserData_State extends State<Activity_GetNewUserData>
{


  var username_text = TextEditingController();
  var email_text = TextEditingController();
  var password_text = TextEditingController();
  var repassword_text = TextEditingController();

  bool check_username=false;
  bool check_email=false;
  bool check_password=false;
  bool check_repassword=false;


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
            height: 600,
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
                Text("بازیابی رمز عبور",style: TextStyle( color: Colors.black,fontSize: 14 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
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
                Text("*ایمیل",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
                ,
                Container(
                  margin: EdgeInsets.all(1),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if(value.toString().contains("@"))
                        {
                          setState(() {
                            check_email=true;
                          });
                        }
                        else
                        {
                          setState(() {
                            check_email=false;
                          });
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: email_text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: InputBorder.none,
                          hintText: "abc@gmail.com"
                      ),
                    ),
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                Text("*نام کاربری",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
                ,
                Container(
                  margin: EdgeInsets.all(1),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if(value.length>0)
                        {
                          setState(() {
                            check_username=true;
                          });
                        }
                        else
                        {
                          setState(() {
                            check_username=false;
                          });
                        }
                      },
                      controller: username_text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: InputBorder.none,
                          hintText: "videoir"
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
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if(value.length>0)
                        {
                          setState(() {
                            check_password=true;
                          });
                        }
                        else
                        {
                          setState(() {
                            check_password=false;
                          });
                        }
                      },
                      controller: password_text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: InputBorder.none,
                          hintText: "**************"
                      ),
                    ),
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(5),
                )
                ,
                Text("*تکرار کلمه عبور",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
                ,
                Container(
                  margin: EdgeInsets.all(1),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if(value.length>0)
                        {
                          setState(() {
                            check_repassword=true;
                          });
                        }
                        else
                        {
                          setState(() {
                            check_repassword=false;
                          });
                        }
                      },
                      controller: repassword_text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white ),
                          border: InputBorder.none,
                          hintText: "**************"
                      ),
                    ),
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
                          backgroundColor: (check_username && check_email && check_password && check_repassword)?Color(0XFF07afee):Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: () async {

                        if(check_username && check_email && check_password && check_repassword)
                        {
                          email=email_text.value.text.toString();
                          username=username_text.value.text.toString();
                          repassword1=password_text.value.text.toString();
                          repassword2=repassword_text.value.text.toString();

                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Activity_Verify()), (route) => false);
                        }

                      },
                      child: Text("بعدی",style: TextStyle( color: Colors.white ),),
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