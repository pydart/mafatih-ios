import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/models/categories_model.dart';
import 'package:mafatih/videos/models/theme_model.dart';

import '../../Screens/EndlessGridView.dart';
import '../../Screens/SingleVideoPage.dart';
import '../../Widgets/CustomCircularProgressIndicator.dart';
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
                          for(int i = 0; i < all_categories!.length; i++)
                            videosSection(context, all_categories![i]),

                        ],
                      );
                    }
                    else
                    {
                      return CustomCircularProgressIndicator();
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
          future: api().GetAllCategories() ,
          builder: ((context, snapshot) {

            if(snapshot.hasData)
            {
              snapshot.data!.insert(0, categories_model(id: 0, name: "همه", slug: "", status: ""));
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: EdgeInsets.all(5)
                    ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            // backgroundColor: (SelectedItem==index)?Colors.green:Color.fromARGB(255, 247, 247, 247),
                              backgroundColor: Color.fromARGB(255, 247, 247, 247),

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.green,width: 1,style: BorderStyle.solid)
                              )
                          ),
                          onPressed: (){

                            selected_category_index=snapshot.data![index].id;
                            // Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(selected_category_index.toString(),0, snapshot.data![index].name.toString()) )));

                          },
                          // child: Text(snapshot.data[index].name,style: TextStyle( color: (SelectedItem==index)?Colors.white:Colors.black87 ,fontSize: 12,fontFamily: 'IRANSans'),)
                          child: Text(snapshot.data![index].name!,style: TextStyle( color: Colors.black87 ,fontSize: 12,fontFamily: 'IRANSans'),)
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

                Text(catgegory.name!,style: TextStyle( fontSize: 13 , fontWeight: FontWeight.bold,fontFamily: 'IRANSans'))
                ,
                TextButton(
                    style: TextButton.styleFrom(
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 2,color: Colors.green)
                        )
                    ),
                    onPressed: (){
                      selected_category_index=catgegory.id;
                      // Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(catgegory.id.toString(),0, catgegory.name.toString()) )));
                      Navigator.push(context, (MaterialPageRoute(builder: (context)=>EndlessGridView(catgegory.id.toString(),0, catgegory.name.toString())  )));
                    },
                    child: Row(
                      children: [
                        Text("نمایش همه",style: TextStyle( fontSize: 13 ,fontFamily: 'IRANSans', color:Colors.green))
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
                        itemCount: (snapshot.data!.length > 5 )?5:snapshot.data!.length,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Activity_Review(
                                                  theme_data:
                                                  snapshot.data![index])));
                                },
                                child: Container(
                                  width: 200,
                                  height: 120,
                                  child: Image.network(
                                      "https://arbaeentv.com/" + snapshot.data![index].cover_address!,
                                      height: 120,fit: BoxFit.cover),
                                  // child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 120,fit: BoxFit.cover),
                                )
                            ),
                          );
                        }
                    );
                  }
                  else
                  {
                    return Center(child: CustomCircularProgressIndicator(),);
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