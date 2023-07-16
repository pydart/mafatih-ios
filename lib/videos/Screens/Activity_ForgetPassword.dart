import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mafatih/videos/Screens/Activity_SetNewForgetPassword.dart';
import 'package:mafatih/videos/Screens/Activity_Verify.dart';
import 'package:mafatih/videos/Screens/Activity_Verify_Forget.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';

class Activity_ForgetPassword extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => Activity_ForgetPassword_state();

}

class Activity_ForgetPassword_state extends State<Activity_ForgetPassword>
{

  //global variables start
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
                Text("کد بازیابی به شماره شما ارسال خواهد شد",style: TextStyle( color: Colors.black,fontSize: 14  ,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                ,
                Container(
                  margin: EdgeInsets.all(10),
                )
                ,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: TextField(
                      onChanged: (value) {
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
                      },
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
                          counterStyle: TextStyle( color: Colors.white ),
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10) ),
                          hintText: "09********",
                          contentPadding: EdgeInsets.all(0)
                      ),
                    ),
                  ),
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
                          backgroundColor: (checklen)?Color(0XFF07afee):Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      onPressed: (){

                        if(phone_text.text.length==11)
                        {
                          api().SendForgetPasswordSMS(phone_text.value.text.toString()).then((value) {
                            Phone_Number=phone_text.value.text.toString();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Activity_Verify_Forget()));
                          });
                        }
                        
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