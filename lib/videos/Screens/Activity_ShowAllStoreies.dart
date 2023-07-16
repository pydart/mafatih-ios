import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/videos/Screens/Activity_Review.dart';

class Activity_ShowAllStoreies extends StatelessWidget
{
  

  //main function start
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
        child: Scaffold(
      body: Column(
          children:[

            Container(
              height: 60,
              child: TopAppBar(context),
            )
            ,
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 60,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [

                    for(var i=0;i<10;i++)
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0)
                            ),
                            // onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review()));
                            // },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3 - 13,
                              height: 220,
                              child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/144-cover.jpg",height: 150,fit: BoxFit.cover),
                            )
                        ),
                      )

                  ],
                ),
              ),
            )

          ]
      ),
    ));
  }
  //main function end


  
  //top appbar start
  Widget TopAppBar(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              width: 40,
              child: TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Icon(Icons.turn_sharp_left,color: Colors.black,size: 24,)
            ),
            )
            ,
            Image.asset("assets/textlogo.png",height: 50,)

          ],
        ),
      ),
    );
  }
  //top appbar end



  
}