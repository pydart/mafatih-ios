import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafatih/videos/Widgets/CropImage.dart';
import 'package:mafatih/videos/data/data.dart';


class layout_plans extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => layout_plans_state();
}

class layout_plans_state extends State<layout_plans>
{

  //global variables start
  String json="curent_theme.json";
  List<Map<String,dynamic>> form=[];
  Map<String,dynamic>? plans={};



  @override
  void initState() {
    super.initState();

    plans=jsonDecode(json);

    for(var i=0;i<plans!["Plan"].length;i++)
      for(var j=0;j<plans!["Plan"][i].length;j++)
        form.add({"name":plans!["Plan"][i][j]["name"],"value":""});


  }



  //main function Start
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl, 
      child: Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(top: 14,bottom: 0),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: 
        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          for(var i=0;i<plans!["Plan"].length;i++)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text("پلان "+(i+1).toString(),style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
                  ,
                  Container(
                    margin: EdgeInsets.only(top: 14,bottom: 14),
                    height: 1,
                    color: Color(0XFFd1d6dc),
                  )
                  ,
                  for(var j=0;j<plans!["Plan"][i].length;j++)
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if(plans!["Plan"][i][j]["type"]=="txt")
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: SizedBox(
                                child: TextField(
                                  onChanged: (value) {

                                    int sc_index=0;

                                    for(var q=0;q<plans!["Plan"].length;q++)
                                    {
                                      for (var p = 0; p <plans!["Plan"][q].length; p++)
                                      {
                                        debugPrint("compare "+plans!["Plan"][i][j]["name"].toString()+"\t and \t"+form[sc_index]["name"].toString());
                                        if(plans!["Plan"][i][j]["name"].toString()==form[sc_index]["name"].toString())
                                        {
                                          form[sc_index]={"name":plans!["Plan"][i][j]["name"].toString(),"value":value.toString()};
                                          break;
                                        }
                                        sc_index++;
                                      }
                                    }

                                  },
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  maxLength: int.parse(plans!["Plan"][i][j]["len"].toString()),
                                  decoration: InputDecoration(
                                      fillColor: Color(0XFFf9f9f9),
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: plans!["Plan"][i][j]["placeholder"].toString()
                                  ),
                                ),
                              ),
                            )
                          else if(plans!["Plan"][i][j]["type"]=="image")
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.all(5),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1,color: Color(0XFFd2d7db),style: BorderStyle.solid),
                                          borderRadius: BorderRadius.circular(0)
                                      )
                                  ),
                                  onPressed: (){

                                    _getFromGallery(plans!["Plan"][i][j]["size"].toString()).then((value){


                                      //Image to base64
                                      List<int> imageBytes = value.readAsBytesSync();
                                      String base64Image = base64Encode(imageBytes);


                                      int sc_index=0;
                                      for(var q=0;q<plans!["Plan"].length;q++)
                                      {
                                        for (var p = 0; p <plans!["Plan"][q].length; p++)
                                        {
                                          debugPrint("compare "+plans!["Plan"][i][j]["name"].toString()+"\t and \t"+form[sc_index]["name"].toString());
                                          if(plans!["Plan"][i][j]["name"].toString()==form[sc_index]["name"].toString())
                                          {
                                            form[sc_index]={"name":plans!["Plan"][i][j]["name"].toString(),"value":base64Image};
                                            break;
                                          }
                                          sc_index++;
                                        }
                                      }

                                    });

                                  },
                                  child: Text("انتخاب عکس",style: TextStyle( color: Color(0XFFd2d7db),fontSize: 14 ),),
                                ),
                              ),
                            )
                          ,
                          Container(
                            margin: EdgeInsets.all(5),
                          )
                        ],
                      ),
                    )

                ],
              ),
            )
          ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   padding: EdgeInsets.all(5),
          //   child: TextButton(
          //     style: TextButton.styleFrom(
          //       backgroundColor: Colors.white,
          //       shape: RoundedRectangleBorder(
          //         side: BorderSide(width: 1,color: Color(0XFFd2d7db),style: BorderStyle.solid),
          //         borderRadius: BorderRadius.circular(0)
          //       )
          //     ),
          //     onPressed: (){
          //       _getFromGallery();
          //     },
          //     child: Text("انتخاب عکس",style: TextStyle( color: Color(0XFFd2d7db),fontSize: 14 ),),
          //   ),
          // ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(5),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: SizedBox(
          //     child: TextField(
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          //   maxLength: 24,
          //   decoration: InputDecoration(
          //     fillColor: Color(0XFFf9f9f9),
          //     filled: true,
          //     border: InputBorder.none,
          //     hintText: "تیتر لوگو"
          //   ),
          // ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(5),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: SizedBox(
          //     child: TextField(
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          //   maxLength: 24,
          //   decoration: InputDecoration(
          //     fillColor: Color(0XFFf9f9f9),
          //     filled: true,
          //     border: InputBorder.none,
          //     hintText: "تیتر لوگو"
          //   ),
          // ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(5),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: SizedBox(
          //     child: TextField(
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          //   maxLength: 24,
          //   decoration: InputDecoration(
          //     fillColor: Color(0XFFf9f9f9),
          //     filled: true,
          //     border: InputBorder.none,
          //     hintText: "تیتر لوگو"
          //   ),
          // ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(5),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: SizedBox(
          //     child: TextField(
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          //   maxLength: 24,
          //   decoration: InputDecoration(
          //     fillColor: Color(0XFFf9f9f9),
          //     filled: true,
          //     border: InputBorder.none,
          //     hintText: "تیتر لوگو"
          //   ),
          // ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(5),
          // )
          // ,
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(0),
          //   child: SizedBox(
          //     child: TextField(
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 12,
          //   ),
          //   maxLength: 24,
          //   decoration: InputDecoration(
          //     fillColor: Color(0XFFf9f9f9),
          //     filled: true,
          //     border: InputBorder.none,
          //     hintText: "تیتر لوگو"
          //   ),
          // ),
          //   ),
          // )
          // ,
          // Container(
          //   margin: EdgeInsets.all(14),
          // )
          // ,
          // Row(
          //   children: [
          //     ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //   width: 150,
          //   height: 50,
          //   padding: EdgeInsets.all(5),
          //   child: TextButton(
          //     style: TextButton.styleFrom(
          //       backgroundColor: Color(0XFF07afee),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(50)
          //       )
          //     ),
          //     onPressed: (){
          //     },
          //     child: Text("بعدی",style: TextStyle( color: Colors.white ),),
          //   ),
          // ),
          // )

          //   ],
          // )
          
        ],
      ),
    )
    );
  }
  //main function end




  
    /// /// Variables
    
  /// Get from gallery
  Future<File> _getFromGallery(String size) async
  {

    List<String> sizes=size.toUpperCase().split("X");

    XFile pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ))!;

    debugPrint(pickedFile.path);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> CropImage(image_path: pickedFile.path,width: int.parse(sizes[0].toString()),height: int.parse(sizes[1].toString()),) ));

    return File(pickedFile.path);

  }



  
  
}
  