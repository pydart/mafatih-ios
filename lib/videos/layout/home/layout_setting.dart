import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';

class layout_setting extends StatelessWidget
{


  var first_name_EditTextController=new TextEditingController();
  var last_name_EditTextController=new TextEditingController();
  var password_EditTextController=new TextEditingController();



  //Main function start
  @override
  Widget build(BuildContext context) 
  {

    first_name_EditTextController.text=user.first_name;
    last_name_EditTextController.text=user.last_name;

    return SingleChildScrollView(
      child: Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width-14,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text("تنظیمات",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
            height: 1,
            color: Colors.grey,
          )
          ,
          SizedBox(
            height: 100,
            width: 100,
            child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
            ),
            onPressed: (){

            }, 
            child: Image.network("https://www.videoir.com/upload/images/2022/11/14/166841877486116.jpeg",width: 100,height: 100),
          ),
          )
          ,
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 14),
          )
          ,
          Text("نام*",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
          ,
          Container(
            margin: EdgeInsets.all(1),
          )
          ,
          ClipRRect(
            //borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              child: TextField(
                controller: first_name_EditTextController,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              fillColor: Color(0XFFF3F4F6),
              filled: true,
                border: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
              hintText: ""
            ),
            
          ),
            ),
          )
          ,
          Container(
            margin: EdgeInsets.all(14),
          )
          ,
          Text("نام خانوادگی*",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
          ,
          Container(
            margin: EdgeInsets.all(1),
          )
          ,
          ClipRRect(
            //borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              child: TextField(
                controller: last_name_EditTextController,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              fillColor: Color(0XFFF3F4F6),
              filled: true,
                border: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
              hintText: ""
            ),
          ),
            ),
          )
          ,
          Container(
            margin: EdgeInsets.all(14),
          )
          ,
          Text("کلمه عبور",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.right)
          ,
          Container(
            margin: EdgeInsets.all(1),
          )
          ,
          ClipRRect(
            //borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              child: TextField(
                controller: password_EditTextController,
                obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              fillColor: Color(0XFFF3F4F6),
              filled: true,
                border: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
                enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Color(0XFFA5A5A5)) ,gapPadding: 0),
              hintText: ""
            ),
          ),
            ),
          )
          ,
          Container(
            margin: EdgeInsets.all(14),
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
              onPressed: (){
                api().SetNewNameFamilyAndPassword(first_name_EditTextController.text.toString(), last_name_EditTextController.text.toString(), "");
              },
              child: Text("ویرایش حساب",style: TextStyle( color: Colors.white ),),
            ),
          ),
          )

        ],
      ),
    )
    ),
    );
  }
  //Main function end



}