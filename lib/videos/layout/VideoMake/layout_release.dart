import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class layout_release extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => layout_release_State();

}

class layout_release_State extends State<layout_release>
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: SizedBox(
              child: TextField(
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
            ),
            maxLength: 24,
            decoration: InputDecoration(
              fillColor: Color(0XFFf9f9f9),
              filled: true,
              border: InputBorder.none,
              hintText: "عنوان"
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
            borderRadius: BorderRadius.circular(0),
            child: SizedBox(
              child: TextField(
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 255,
            decoration: InputDecoration(
              fillColor: Color(0XFFf9f9f9),
              filled: true,
              border: InputBorder.none,
              hintText: "جزئیات"
            ),
          ),
            ),
          )
          ,
          Container(
            margin: EdgeInsets.all(14),
          )
          ,
          
          
        ],
      ),
    )
    );
  }
  //main function end

}