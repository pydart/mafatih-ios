import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mafatih/videos/Screens/Activity_GetNewUserData.dart';
import 'package:mafatih/videos/Screens/Activity_Verify.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';

class Activity_Signup extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => Activity_Signup_state();

}

class Activity_Signup_state extends State<Activity_Signup>
{

  //global variables start
  bool checklaw=false;
  bool checklen=false;
  var phone_text = TextEditingController();
  //global variables End


  //main function start
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0XFFf7fbfe),
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(14),
            height: 400,
            child: Column(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      onChanged: ((value) {
                        if(value.length==11)
                        {
                          setState(() {
                            checklen=true;
                          });
                        }
                        else
                        {
                          setState(() {
                            checklen=false;
                          });
                        }
                      }),
                      maxLength: 11,
                      controller: phone_text,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                          counter: Offstage(),
                          fillColor: Colors.white,
                          filled: true,
                          counterStyle: TextStyle( color: Colors.white),
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                          hintText: "09********",
                          contentPadding: EdgeInsets.all(0)
                      ),
                    ),
                  ),
                )
                ,
                CheckboxListTile(
                    contentPadding: EdgeInsets.zero,

                    title: Container(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        actions: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.all(14),
                                                  backgroundColor: Color(0XFF2AC114),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(100)
                                                  )
                                              ),
                                              onPressed: (){
                                                setState(() {
                                                  checklaw=true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text("می پذیرم",style: TextStyle( color: Colors.white),)
                                          )
                                        ],
                                        insetPadding: EdgeInsets.all(0),
                                        contentPadding: EdgeInsets.all(0),
                                        content: Container(
                                          padding: EdgeInsets.all(10),
                                          height: 413,
                                          width: MediaQuery.of(context).size.width-24,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [

                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text("قوانین و حریم خصوصیه ویدیو آی ار",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 14 ),textAlign: TextAlign.right,),
                                              )
                                              ,
                                              Container(
                                                height: 1,
                                                color: Color(0XFFA5A5A5),
                                              )
                                              ,
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                height: 350,
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: SingleChildScrollView(
                                                    child: Text(law.trimLeft(),style: TextStyle(fontSize: 12 ),textAlign: TextAlign.justify,),
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              },
                              child: Text("قوانین و مقررات",style: TextStyle( fontSize: 12 ,color: Colors.blue),textAlign: TextAlign.right),
                            )
                            ,
                            Container(
                              margin: EdgeInsets.all(2),
                            )
                            ,
                            Text(" را قبول کردم و آن را قبول دارم",style: TextStyle( fontSize: 10 ),textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                    ),
                    value: checklaw,
                    onChanged: (value){
                      setState(() {
                        checklaw=value;
                      });
                    }
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: (checklaw && checklen)?Color(0XFF07afee):Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: (){

                        //&& (phone_text.text[0]=='0' && phone_text.text[0]=='9')
                        if(checklaw && checklen)
                        {
                          api().SendRegisterSms(phone_text.value.text.toString()).then((value) {
                            debugPrint(value);
                            if(value.contains("has-user"))
                            {
                              Fluttertoast.showToast(
                              msg: "شماره قبلا ثبت شد",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.CENTER,
                              webPosition: "center",
                              webBgColor: "#FF0000",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                            }
                            else
                            {
                              Phone_Number=phone_text.value.text.toString();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Activity_GetNewUserData()));
                            }

                          } );

                        }
                        // else
                        // {
                        //   Fluttertoast.showToast(
                        //       msg: "مشکلی در پذیرش ",
                        //       backgroundColor: Colors.red,
                        //       gravity: ToastGravity.CENTER,
                        //       webPosition: "center",
                        //       webBgColor: "#FF0000",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0
                        //   );
                        // }
                        
                      },
                      child: Text("دریافت کد",style: TextStyle( color: Colors.white ),),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    ));
  }
  //main function end



}