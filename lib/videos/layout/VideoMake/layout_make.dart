import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class layout_make extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => layout_make_State();

}

class layout_make_State extends State<layout_make>
{
  
  //main function start
  @override
  Widget build(BuildContext context) 
  {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(top: 14,bottom: 0),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Image.asset("assets/icons/create.png",height: 150,)
          ,
          Container(margin: EdgeInsets.all(5),)
          ,
          Text("ویدیو ای آر در حال ساخت ویدیو شماست ...",style: TextStyle( color: Colors.black,fontSize: 14 ),textAlign: TextAlign.center)
          ,
          Container(margin: EdgeInsets.all(5),)
          ,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(  
              backgroundColor: Color(0XFFe5e7eb),  
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),  
              value: 0.1,  
              minHeight: 14,
            ),  
          )
          ,
          Container(margin: EdgeInsets.all(5),)
          ,
          Text("کمی بعد میتوانید ویدیویی را که ساخته اید تماشا کنید",style: TextStyle( color: Color(0XFF737280),fontSize: 12 ),textAlign: TextAlign.center)
          ,
          Container(margin: EdgeInsets.all(5),)
          ,
          Container(
            padding: EdgeInsets.all(6),
            width: MediaQuery.of(context).size.width - 14,
            color: Color(0XFFbec2c8),
            child: Text("تا اتمام روند ساخت ویدیو می توانید این پنجره را ببندید و نتیجه را بعدا در بخش ویدیو های من مشاهده کنید",style: TextStyle( color: Colors.black,fontSize: 13 ),textAlign: TextAlign.center),
          )

          
        ],
      ),
    )
    );
  }
  //main function end

}