import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mafatih/videos/Screens/Activity_Main.dart';
import 'package:mafatih/videos/Screens/Activity_SetNewForgetPassword.dart';
import 'package:mafatih/videos/Screens/Activity_Splash.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';

class Activity_Verify_Forget extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() => Activity_Verify_Forget_State();
  
}

class Activity_Verify_Forget_State extends State<Activity_Verify_Forget>
{


  //Global Varibles
  int countdown=120;
  Timer countdownTimer;
  Duration myDuration = Duration(minutes: 2);
  String SMSAlert="تا ارسال مجدد پیامک";
  var Sec_Visible=true;
  var pincode = TextEditingController();



  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) { setState(() {
          
          if(countdown>0)
          {
            countdown--;
          }
          else
          {
            Sec_Visible=false;
            SMSAlert="پیامک دوباره برای شما ارسال شد";
            stopTimer();
          }

        });  });
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 2));
  }




  @override
  void initState() {
    super.initState();
    startTimer();
  }




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
                  "assets/icons/ic_message.png",
                  height: 50,
                  fit: BoxFit.cover,
                )
                ,
                Container(
                  margin: EdgeInsets.all(14),
                )
                ,
                Text("کد بازیابی برای شما ارسال شد",style: TextStyle( color: Colors.black,fontSize: 12 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                ,
                Container(
                  margin: EdgeInsets.all(2),
                )
                ,
                Text("لطفا آن را در کادر زیر وارد کنید",style: TextStyle( color: Colors.black,fontSize: 12  ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                ,
                Container(
                  margin: EdgeInsets.all(10),
                )
                ,
                Container(
                  margin: EdgeInsets.all(10),
                )
                ,
                Container(
                  width: MediaQuery.of(context).size.width - 75,
                  child: PinCodeTextField(
                    controller: pincode,
                    length: 5,
                    appContext: context,
                    onChanged: (String value) {

                    },
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 35,
                      activeFillColor: Colors.black87,
                    ),
                  ),
                )
                ,
                Container(
                  margin: EdgeInsets.all(4),
                )
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(SMSAlert,style: TextStyle( color: Colors.black,fontSize: 14)),
                    Visibility(
                      visible: Sec_Visible,
                      child: Text(" $countdown ثانیه",style: TextStyle( color: Colors.blue,fontSize: 14)),
                    )
                  ],
                )
                ,
                Container(
                  margin: EdgeInsets.all(4),
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
                          backgroundColor: Color(0XFF07afee),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: (){
                        api().CheckForgetPasswordCode(Phone_Number, pincode.value.text.toString()).then((value) {

                          if(value)
                          {
                            forgetpass_code_catch=pincode.value.text.toString();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Activity_SetNewForgetPassword()), (route) => false);
                          }


                        });
                        

                      },
                      child: Text("تایید و ادامه",style: TextStyle( color: Colors.white ),),
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