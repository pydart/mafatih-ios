import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mafatih/videos/Screens/SingleVideoPage.dart';
import 'package:mafatih/videos/api/api.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/models/categories_model.dart';
import 'package:mafatih/videos/models/theme_model.dart';
import '../../Screens/EndlessGridView.dart';


class layout_home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>layout_home_State();
}
class layout_home_State extends State<layout_home>
{
  var SelectedItem=0;
  late bool _isConnected = true; // Initialize with a default value
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectionSubscription = InternetConnectionChecker().onStatusChange.listen(_updateConnectivity);
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {
      _isConnected = isConnected;
    });
  }

  void _updateConnectivity(InternetConnectionStatus status) {
    setState(() {
      _isConnected = status == InternetConnectionStatus.connected;
    });

    if (_isConnected) {
      // Internet connection is available, refresh the page or perform any necessary actions.
    }
  }

  void _showConnectivityDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:Theme.of(context).brightness ==
                Brightness.light
                ? Colors.white
                : Colors.grey,
            title:  Text(
              "لطفا از اتصال دستگاه خود به اینترنت مطمئن شوید. ",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'IRANSans',
                // fontWeight:FontWeight.bold,
                color:  Theme.of(context).brightness ==
                    Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),

            // content: Text('Please check your internet connection.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'تلاش دوباره',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'IRANSans',
                    fontWeight:FontWeight.bold,
                    color:  Colors.green,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkConnectivity();
                },
              ),




            ],
          );
        },
      );
    });
  }


  @override
  Widget build(BuildContext context)
  {
    if (!_isConnected) {
      _showConnectivityDialog();
    }

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
                      return CircularProgressIndicator(backgroundColor: Colors.green);
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.all(25),
                )
              ],
            ),
          )
      ),
    );
  }

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
              // snapshot.data!.insert(0, categories_model(id: 0, name: "همه", slug: "", status: ""));
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 247, 247, 247),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.green,width: 1,style: BorderStyle.solid)
                              )
                          ),
                          onPressed: (){selected_category_index=snapshot.data![index].id;
                          Navigator.push(context, (MaterialPageRoute(builder: (context)=>EndlessGridView(selected_category_index.toString(),0, snapshot.data![index].name.toString()) )));
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
                            side: BorderSide(width: 0.35,color: Colors.green)
                        )
                    ),
                    onPressed: (){
                      selected_category_index=catgegory.id;
                      // Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(catgegory.id.toString(),0, catgegory.name.toString()) )));
                      Navigator.push(context, (MaterialPageRoute(builder: (context)=>EndlessGridView(catgegory.id.toString(),0, catgegory.name.toString())  )));
                    },
                    child: Row(
                      children: [
                        Text("نمایش همه",style: TextStyle( fontSize: 13 ,fontFamily: 'IRANSans', color:

                        Colors.green

                        ))
                        ,
                        Icon(Icons.keyboard_arrow_left,size: 13,color:

                        Colors.green)
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review(theme_data: snapshot.data![index])));
                                },
                                child:
                                snapshot.data![index].cover_address==null?
                                Container(
                                    width: 200,
                                    height: 120,
                                    child: Image.asset("assets/cover.png",
                                      height: 120, fit: BoxFit.cover,)
                                  // child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 120,fit: BoxFit.cover),
                                ):
                                Container(
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
                    return Center(child: CircularProgressIndicator(backgroundColor: Colors.green),);
                  }
                },
              )
          )
        ],
      ),
    );
  }
}