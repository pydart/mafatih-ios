import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mafatih/videos/Screens/Activity_Login.dart';
import 'package:mafatih/videos/Screens/Activity_Main.dart';
import 'package:mafatih/videos/Screens/Activity_Signup.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/DataSaver/DataSaver.dart';
import 'package:mafatih/videos/data/data.dart';

class Activity_Splash extends StatelessWidget
{

  //Timer function Start
  void StarTimer(BuildContext context)
  {

    Timer.periodic(Duration( seconds: 5 ), (timer){

      Data_Sever.Get_Data("token").then((value) {
        value="15|513csRNHOFJidVSYrItGuQHnDiC9NWE4WdJsnpKe";

        if(value.isEmpty || value.length <= 0 || value=="null")
        {

          //Navigate to login page
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Activity_Login()), (route) => false);
        }
        else
        {

          token=value;
          api().GetUserData(token).then((value) {
            print("///////////////////////////*************************value *************  value:   ${value}") ;
            if(value)
            {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Activity_Main()), (route) => false);
            }
            else
            {
              Data_Sever.Save_Data("token", "");
              //Navigate to login page
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Activity_Login()), (route) => false);
            }

          });

        }

      });


    });

  }
  //Timer function End


  //Main function start
  @override
  Widget build(BuildContext context)
  {
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Activity_Main()), (route) => false);

    StarTimer(context);

    return SafeArea(child: Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/transfer.gif",
            width: 250,
            height: 250,
          ),
        ),
      ),
    ));
  }
  //Main function end



}