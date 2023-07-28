import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mafatih/videos/Screens/Activity_Review.dart';
import 'package:mafatih/videos/Screens/Activity_ShowAllStoreies.dart';
import 'package:mafatih/videos/Screens/Activity_ShowAllVideo.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/models/categories_model.dart';
import 'package:mafatih/videos/models/theme_model.dart';

import '../../Screens/Activity_ShowAllVideo_PerPageLoading.dart';
import '../staggered.dart';


class layout_home extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() =>layout_home_State();

}


class layout_home_State extends State<layout_home>
{


  
  //Globla Varibales
  var SelectedItem=0;



  //Main function start
  @override
  Widget build(BuildContext context) 
  {
    return SingleChildScrollView(
      child: Directionality(
      textDirection: TextDirection.rtl ,
      child: Container(
        child: Column(
          children: [

            HomeTopButtoms(context)
            // ,
            // TopVideoBoxes(context)
            ,
            FutureBuilder<List<categories_model>>(
              future: api().GetAllCategories(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Column(
                    children: [
                      for(int i = 0; i < all_categories.length; i++)
                        videosSection(context, all_categories[i])
                    ],
                  );
                }
                else
                {
                  return CircularProgressIndicator();
                }
              },
            )
            ,
            Container(
              margin: EdgeInsets.all(25),
            )
                        
          ],
        ),
      )
    ),
    );
  }
  //Main function end


  //Top Button Item Start
  Widget HomeTopButtoms(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: FutureBuilder<List<categories_model>>(
          future: api().GetAllCategories(),
          builder: ((context, snapshot) {

            if(snapshot.hasData)
            {
              snapshot.data.insert(0, categories_model(id: 0, name: "همه", slug: "", status: ""));
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: EdgeInsets.all(5)
                    ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: (SelectedItem==index)?Colors.green:Color.fromARGB(255, 247, 247, 247),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.green,width: 1,style: BorderStyle.solid)
                              )
                          ),
                          onPressed: (){

                            selected_category_index=snapshot.data[index].id;
                            Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(selected_category_index.toString()) )));

                          },
                          child: Text(snapshot.data[index].name,style: TextStyle( color: (SelectedItem==index)?Colors.white:Colors.black87 ,fontSize: 12),)
                      ),
                    ),
                  );
                },
              );
            }
            else
            {
              return Center(
                child: Container()
              );
            }

          }),
        ),
      ),
    );
  }
  //Top Button Item End


  //Get Top Items Start
  Widget TopVideoBoxes(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        Container(
          width: MediaQuery.of(context).size.width/2-10,
          color: Colors.white,
          height: 140,
          child: Column(
            children: [
              Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 100,fit: BoxFit.cover,)
              ,
              Container(
                padding: EdgeInsets.all(5),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    width: 35,
                    height: 25,
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: Icon(Icons.play_arrow,color: Colors.green),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid)
                    ),
                  )
                  ,
                  Text("قالب دیجیتال مارکتینگ",style: TextStyle( color: Colors.black87 ,fontSize: 10,fontWeight: FontWeight.bold),)

                ],
              ),
              )
            ],
          ),
        )
        ,
        Container(
          width: MediaQuery.of(context).size.width/2-10,
          color: Colors.white,
          height: 140,
          child: Column(
            children: [
              Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 100,fit: BoxFit.cover,)
              ,
              Container(
                padding: EdgeInsets.all(5),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    width: 35,
                    height: 25,
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: Icon(Icons.play_arrow,color: Colors.green),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid)
                    ),
                  )
                  ,
                  Text("قالب دیجیتال مارکتینگ",style: TextStyle( color: Colors.black87 ,fontSize: 10,fontWeight: FontWeight.bold),)

                ],
              ),
              )
            ],
          ),
        )

      ],
    )
    );
  }
  //Get Top Items End
  

  //Stories section Start
  /*
  Widget StoriesSection(BuildContext context)
  {
    return FutureBuilder(
      future: api().GetAllThemeData(),
      builder: (context, snapshot) {

        if(snapshot.hasData)
        {
          List<theme_model>? data = snapshot.data as List<theme_model>?;
          debugPrint("https://videoir.com/"+data![0].files[2].file_address);
          return Container(
        margin: EdgeInsets.only(top: 6),
        child: Column(
        children: [

          Container(
            margin: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("قالب های استوری",style: TextStyle( fontSize: 13))
              ,
              TextButton(
                style: TextButton.styleFrom(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(width: 1,color: Colors.blue)
                  )
                ),
                onPressed: (){
                    Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllStoreies() )));
                },
                child: Row(
                  children: [
                    Text("نمایش همه",style: TextStyle( fontSize: 13 ))
                    ,
                    Icon(Icons.keyboard_arrow_left,size: 13,)
                  ],
                )
              )

            ],
          ),
          )
          ,
          Container(
            height: 200,
            child: ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index)
            {
              return Padding(
                padding: EdgeInsets.all(6),
                child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review()));
                },
                child: Container(
                  width: 115,
                  height: 200,
                  child: Image.network("https://videoir.com/"+data[index].files[2].file_address,height: 270,fit: BoxFit.fill),
                )
              ),
              );
            }
          )
        )

      ],
    ),
    );
        }
        else
        {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          );
        }

      },
    );
  }
   */
  //Stories section End


  //Video section Start
  Widget videosSection(BuildContext context,categories_model catgegory)
  {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: Column(
      children: [

        Container(
          margin: EdgeInsets.only(top: 14,left: 14,right: 14,bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(catgegory.name,style: TextStyle( fontSize: 13 , fontWeight: FontWeight.bold))
            ,
            TextButton(
              style: TextButton.styleFrom(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 1,color: Colors.green)
                )
              ),
              onPressed: (){
                selected_category_index=catgegory.id;
                Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(catgegory.id.toString()) )));
              },
              child: Row(
                children: [
                  Text("نمایش همه",style: TextStyle( fontSize: 13 ))
                  ,
                  Icon(Icons.keyboard_arrow_left,size: 13,)
                ],
              )
            )

          ],
        ),
        )
        ,
        Container(
          height: 120,
          child: FutureBuilder<List<theme_model>>(
            future: api().GetAllThemeOfCategoriesById(catgegory.id.toString()),
            builder: (context, snapshot) {
              if(snapshot.hasData)
              {
                return ListView.builder(
                    itemCount: (snapshot.data.length > 5 )?5:snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index)
                    {
                      return Padding(
                        padding: EdgeInsets.all(6),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0)
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review(theme_data: snapshot.data[index])));
                            },
                            child: Container(
                              width: 200,
                              height: 120,
                              child: Image.network("http://arbaeentv.com/" + snapshot.data[index].cover_address,height: 120,fit: BoxFit.cover),
                              // child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 120,fit: BoxFit.cover),
                            )
                        ),
                      );
                    }
                );
              }
              else
              {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
        )

      ],
    ),
    );
  }
  //Video section End



}